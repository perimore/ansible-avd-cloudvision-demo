# DC1_FABRIC

## Table of Contents

- [DC1_FABRIC](#dc1fabric)
  - [Fabric Switches and Management IP](#fabric-switches-and-management-ip)
  - [Fabric Topology](#fabric-topology)
  - [Fabric IP Allocation](#fabric-ip-allocation)
    - [Fabric Point-To-Point Links](#fabric-point-to-point-links)
    - [Point-To-Point Links Node Allocation](#point-to-point-links-node-allocation)
    - [Overlay Loopback Interfaces (BGP EVPN Peering)](#overlay-loopback-interfaces-bgp-evpn-peering)
    - [Loopback0 Interfaces Node Allocation](#loopback0-interfaces-node-allocation)
    - [VTEP Loopback VXLAN Tunnel Source Interfaces (Leafs Only)](#vtep-loopback-vxlan-tunnel-source-interfaces-leafs-only)
    - [VTEP Loopback Node allocation](#vtep-loopback-node-allocation)

## Fabric Switches and Management IP

| POD | Type | Node | Management IP | Platform | Provisioned in Cloudvision |
| --- | ---- | ---- | ------------- | -------- | -------------------------- |
| DC1_FABRIC | l3leaf | DC1-BLEAF1A | 10.73.3.9/16 | vEOS-LAB | Provisioned |
| DC1_FABRIC | l3leaf | DC1-BLEAF1B | 10.73.3.10/16 | vEOS-LAB | Provisioned |
| DC1_FABRIC | l2leaf | DC1-L2LEAF1A | 10.73.3.11/16 | vEOS-LAB | Provisioned |
| DC1_FABRIC | l2leaf | DC1-L2LEAF2A | 10.73.3.12/16 | vEOS-LAB | Provisioned |
| DC1_FABRIC | l3leaf | DC1-LEAF1A | 10.73.3.3/16 | vEOS-LAB | Provisioned |
| DC1_FABRIC | l3leaf | DC1-LEAF1B | 10.73.3.4/16 | vEOS-LAB | Provisioned |
| DC1_FABRIC | l3leaf | DC1-LEAF2A | 10.73.3.5/16 | vEOS-LAB | Provisioned |
| DC1_FABRIC | l3leaf | DC1-LEAF2B | 10.73.3.6/16 | vEOS-LAB | Provisioned |
| DC1_FABRIC | l3leaf | DC1-LEAF3A | 10.73.3.7/16 | vEOS-LAB | Provisioned |
| DC1_FABRIC | l3leaf | DC1-LEAF4A | 10.73.3.8/16 | vEOS-LAB | Provisioned |
| DC1_FABRIC | spine | DC1-SPINE01 | 10.73.3.1/16 | vEOS-LAB | Provisioned |
| DC1_FABRIC | spine | DC1-SPINE02 | 10.73.3.2/16 | vEOS-LAB | Provisioned |

> Provision status is based on Ansible inventory declaration and do not represent real status from Cloudvision.

## Fabric Topology

| Type | Node | Node Interface | Peer Type | Peer Node | Peer Interface |
| ---- | ---- | -------------- | --------- | ----------| -------------- |
| l3leaf | DC1-BLEAF1A | Ethernet1 | spine | DC1-SPINE01 | Ethernet6 |
| l3leaf | DC1-BLEAF1A | Ethernet2 | spine | DC1-SPINE02 | Ethernet6 |
| l3leaf | DC1-BLEAF1A | Ethernet3 | mlag_peer | DC1-BLEAF1B | Ethernet3 |
| l3leaf | DC1-BLEAF1A | Ethernet4 | mlag_peer | DC1-BLEAF1B | Ethernet4 |
| l3leaf | DC1-BLEAF1B | Ethernet1 | spine | DC1-SPINE01 | Ethernet7 |
| l3leaf | DC1-BLEAF1B | Ethernet2 | spine | DC1-SPINE02 | Ethernet7 |
| l2leaf | DC1-L2LEAF1A | Ethernet1 | l3leaf | DC1-LEAF1A | Ethernet5 |
| l2leaf | DC1-L2LEAF1A | Ethernet2 | l3leaf | DC1-LEAF1B | Ethernet5 |
| l2leaf | DC1-L2LEAF2A | Ethernet1 | l3leaf | DC1-LEAF2A | Ethernet5 |
| l2leaf | DC1-L2LEAF2A | Ethernet2 | l3leaf | DC1-LEAF2B | Ethernet5 |
| l3leaf | DC1-LEAF1A | Ethernet1 | spine | DC1-SPINE01 | Ethernet1 |
| l3leaf | DC1-LEAF1A | Ethernet2 | spine | DC1-SPINE02 | Ethernet1 |
| l3leaf | DC1-LEAF1A | Ethernet3 | mlag_peer | DC1-LEAF1B | Ethernet3 |
| l3leaf | DC1-LEAF1A | Ethernet4 | mlag_peer | DC1-LEAF1B | Ethernet4 |
| l3leaf | DC1-LEAF1B | Ethernet1 | spine | DC1-SPINE01 | Ethernet2 |
| l3leaf | DC1-LEAF1B | Ethernet2 | spine | DC1-SPINE02 | Ethernet2 |
| l3leaf | DC1-LEAF2A | Ethernet1 | spine | DC1-SPINE01 | Ethernet3 |
| l3leaf | DC1-LEAF2A | Ethernet2 | spine | DC1-SPINE02 | Ethernet3 |
| l3leaf | DC1-LEAF2A | Ethernet3 | mlag_peer | DC1-LEAF2B | Ethernet3 |
| l3leaf | DC1-LEAF2A | Ethernet4 | mlag_peer | DC1-LEAF2B | Ethernet4 |
| l3leaf | DC1-LEAF2B | Ethernet1 | spine | DC1-SPINE01 | Ethernet4 |
| l3leaf | DC1-LEAF2B | Ethernet2 | spine | DC1-SPINE02 | Ethernet4 |
| l3leaf | DC1-LEAF3A | Ethernet1 | spine | DC1-SPINE01 | Ethernet5 |
| l3leaf | DC1-LEAF3A | Ethernet2 | spine | DC1-SPINE02 | Ethernet5 |
| l3leaf | DC1-LEAF4A | Ethernet1 | spine | DC1-SPINE01 | Ethernet8 |
| l3leaf | DC1-LEAF4A | Ethernet2 | spine | DC1-SPINE02 | Ethernet8 |

## Fabric IP Allocation

### Fabric Point-To-Point Links

| P2P Summary | Available Addresses | Assigned addresses | Assigned Address % |
| ----------- | ------------------- | ------------------ | ------------------ |
| 172.31.255.0/24 | 256 | 32 | 12.5 % |

### Point-To-Point Links Node Allocation

| Node | Node Interface | Node IP Address | Peer Node | Peer Interface | Peer IP Address |
| ---- | -------------- | --------------- | --------- | -------------- | --------------- |
| DC1-BLEAF1A | Ethernet1 | 172.31.255.25/31 | DC1-SPINE01 | Ethernet6 | 172.31.255.24/31 |
| DC1-BLEAF1A | Ethernet2 | 172.31.255.27/31 | DC1-SPINE02 | Ethernet6 | 172.31.255.26/31 |
| DC1-BLEAF1B | Ethernet1 | 172.31.255.29/31 | DC1-SPINE01 | Ethernet7 | 172.31.255.28/31 |
| DC1-BLEAF1B | Ethernet2 | 172.31.255.31/31 | DC1-SPINE02 | Ethernet7 | 172.31.255.30/31 |
| DC1-LEAF1A | Ethernet1 | 172.31.255.1/31 | DC1-SPINE01 | Ethernet1 | 172.31.255.0/31 |
| DC1-LEAF1A | Ethernet2 | 172.31.255.3/31 | DC1-SPINE02 | Ethernet1 | 172.31.255.2/31 |
| DC1-LEAF1B | Ethernet1 | 172.31.255.5/31 | DC1-SPINE01 | Ethernet2 | 172.31.255.4/31 |
| DC1-LEAF1B | Ethernet2 | 172.31.255.7/31 | DC1-SPINE02 | Ethernet2 | 172.31.255.6/31 |
| DC1-LEAF2A | Ethernet1 | 172.31.255.9/31 | DC1-SPINE01 | Ethernet3 | 172.31.255.8/31 |
| DC1-LEAF2A | Ethernet2 | 172.31.255.11/31 | DC1-SPINE02 | Ethernet3 | 172.31.255.10/31 |
| DC1-LEAF2B | Ethernet1 | 172.31.255.13/31 | DC1-SPINE01 | Ethernet4 | 172.31.255.12/31 |
| DC1-LEAF2B | Ethernet2 | 172.31.255.15/31 | DC1-SPINE02 | Ethernet4 | 172.31.255.14/31 |
| DC1-LEAF3A | Ethernet1 | 172.31.255.17/31 | DC1-SPINE01 | Ethernet5 | 172.31.255.16/31 |
| DC1-LEAF3A | Ethernet2 | 172.31.255.19/31 | DC1-SPINE02 | Ethernet5 | 172.31.255.18/31 |
| DC1-LEAF4A | Ethernet1 | 172.31.255.21/31 | DC1-SPINE01 | Ethernet8 | 172.31.255.20/31 |
| DC1-LEAF4A | Ethernet2 | 172.31.255.23/31 | DC1-SPINE02 | Ethernet8 | 172.31.255.22/31 |

### Overlay Loopback Interfaces (BGP EVPN Peering)

| Overlay Loopback Summary | Available Addresses | Assigned addresses | Assigned Address % |
| ------------------------ | ------------------- | ------------------ | ------------------ |
| 192.168.255.0/24 | 256 | 10 | 3.91 % |

### Loopback0 Interfaces Node Allocation

| POD | Node | Loopback0 |
| --- | ---- | --------- |
| DC1_FABRIC | DC1-BLEAF1A | 192.168.255.9/32 |
| DC1_FABRIC | DC1-BLEAF1B | 192.168.255.10/32 |
| DC1_FABRIC | DC1-LEAF1A | 192.168.255.3/32 |
| DC1_FABRIC | DC1-LEAF1B | 192.168.255.4/32 |
| DC1_FABRIC | DC1-LEAF2A | 192.168.255.5/32 |
| DC1_FABRIC | DC1-LEAF2B | 192.168.255.6/32 |
| DC1_FABRIC | DC1-LEAF3A | 192.168.255.7/32 |
| DC1_FABRIC | DC1-LEAF4A | 192.168.255.8/32 |
| DC1_FABRIC | DC1-SPINE01 | 192.168.255.1/32 |
| DC1_FABRIC | DC1-SPINE02 | 192.168.255.2/32 |

### VTEP Loopback VXLAN Tunnel Source Interfaces (Leafs Only)

| VTEP Loopback Summary | Available Addresses | Assigned addresses | Assigned Address % |
| --------------------- | ------------------- | ------------------ | ------------------ |
| 192.168.254.0/24 | 256 | 8 | 3.13 % |

### VTEP Loopback Node allocation

| POD | Node | Loopback1 |
| --- | ---- | --------- |
| DC1_FABRIC | DC1-BLEAF1A | 192.168.254.9/32 |
| DC1_FABRIC | DC1-BLEAF1B | 192.168.254.9/32 |
| DC1_FABRIC | DC1-LEAF1A | 192.168.254.3/32 |
| DC1_FABRIC | DC1-LEAF1B | 192.168.254.3/32 |
| DC1_FABRIC | DC1-LEAF2A | 192.168.254.5/32 |
| DC1_FABRIC | DC1-LEAF2B | 192.168.254.5/32 |
| DC1_FABRIC | DC1-LEAF3A | 192.168.254.7/32 |
| DC1_FABRIC | DC1-LEAF4A | 192.168.254.8/32 |
