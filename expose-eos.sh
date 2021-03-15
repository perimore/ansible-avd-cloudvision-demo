#!/bin/bash

echo "Jumphost Remote access configuration"

_EAPI_PORT=443
_SSH_PORT=22
_SRC_IF='ens3'
_DST_IF='ens4'
_SWITCHES=30
_BASE_IP='10.73'

echo '* Activate kernel routing'
sysctl -w net.ipv4.ip_forward=1

echo '* Flush Current IPTables settings'
iptables --flush
iptables --delete-chain
iptables --table nat --flush
iptables --table nat --delete-chain

echo '* Activate default forwarding'

iptables -P FORWARD ACCEPT
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT

echo '* Activate masquerading'

iptables -t nat -A POSTROUTING -o ${_SRC_IF} -j MASQUERADE
iptables -t nat -A POSTROUTING -o ${_DST_IF} -j MASQUERADE

for i in $(seq 1 $_SWITCHES)
do
# Do this configuration for any EOS device.
echo '* Activate eAPI forwarding for '${_BASE_IP}'.3.'$i':'$((8000 + $i ))''
iptables -t nat -A PREROUTING -p tcp -i ${_SRC_IF} --dport $((8000 + $i )) -j DNAT --to-destination ${_BASE_IP}.3.$i:${_EAPI_PORT}
echo '* Activate SSH forwarding for '${_BASE_IP}'.3.'$i':'$((8100 + $i ))''
iptables -t nat -A PREROUTING -p tcp -i ${_SRC_IF} --dport $((8100 + $i )) -j DNAT --to-destination ${_BASE_IP}.3.$i:${_SSH_PORT}
done

# Configure at the end of the file
iptables -A FORWARD -p tcp -d ${_BASE_IP}.0.0/16 --dport ${_EAPI_PORT} -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p tcp -d ${_BASE_IP}.0.0/16 --dport ${_SSH_PORT} -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

echo "-> Configuration done"