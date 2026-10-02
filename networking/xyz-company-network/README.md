# XYZ Company Small Office Network Lab

A complete networking lab project demonstrating the design and implementation of a small company network with **one router**, **one switch**, and **three wireless-enabled departments**.

**Company:** XYZ  
**Devices:** Router R1 + Switch S1  
**Environment:** Cisco Packet Tracer  
**Base Network from ISP:** `192.168.1.0/24`

---

## Project Requirements

- One router and one switch
- Three departments: **ADMIN**, **FINANCE**, and **RECEPTION**
- Each department requires a wireless network for users
- Host devices obtain IPv4 addresses **automatically** (DHCP)
- Devices in different departments must communicate with each other
- Use the ISP-provided network base `192.168.1.0`

---

## Network Design Summary

| Component            | Design Choice                                              |
|----------------------|------------------------------------------------------------|
| Topology             | Router-on-a-Stick + Access Switch                          |
| Inter-VLAN Routing   | Router subinterfaces (802.1Q) on GigabitEthernet0/0        |
| VLANs                | VLAN 10 (ADMIN), VLAN 20 (FINANCE), VLAN 30 (RECEPTION)    |
| Addressing           | Three /26 subnets from 192.168.1.0/24                      |
| IP Assignment        | DHCP pools on the router (one per VLAN)                    |
| Trunk                | Switch Fa0/1 ↔ Router Gi0/0                                |
| Wireless             | Access Points connected to department access ports + SSIDs |

### VLAN & IP Addressing Plan

| Department  | VLAN | Network          | Gateway         | DHCP Pool        | Usable Hosts |
|-------------|------|------------------|-----------------|------------------|--------------|
| ADMIN       | 10   | 192.168.1.0/26   | 192.168.1.1     | Admin-Pool       | 62           |
| FINANCE     | 20   | 192.168.1.64/26  | 192.168.1.65    | Finance-Pool     | 62           |
| RECEPTION   | 30   | 192.168.1.128/26 | 192.168.1.129   | Reception-Pool   | 62           |

### Switch Port Mapping

| Ports              | VLAN | Department  | Mode   |
|--------------------|------|-------------|--------|
| FastEthernet0/1    | —    | Trunk       | Trunk  |
| FastEthernet0/2-4  | 10   | ADMIN       | Access |
| FastEthernet0/5-7  | 20   | FINANCE     | Access |
| FastEthernet0/8-10 | 30   | RECEPTION   | Access |

---


---

## Key Features Implemented

- VLANs for department separation (10, 20, 30)
- Router-on-a-Stick inter-VLAN routing
- DHCP server on the router with separate pools per department
- Trunk link carrying multiple VLANs
- Wireless support via Access Points on department ports
- Basic security hardening (enable secret, password encryption, unused ports shutdown)

---

## How to Reproduce

1. Open Cisco Packet Tracer.
2. Place 1 Router (2911) + 1 Switch (2960).
3. Connect **Router Gi0/0** ↔ **Switch Fa0/1**.
4. Connect hosts or Access Points to Fa0/2-10 according to the port mapping.
5. Apply the configurations from the `configs/` folder.
6. Configure wireless APs with SSIDs and connect them to the correct VLAN ports.
7. Set end devices to obtain IP automatically (DHCP).

---

## Verification

See `verification/verification-checklist.md` for full testing steps.

**Quick checks:**
- Hosts receive correct IP via DHCP
- `ping` works between different departments
- `show vlan brief` and `show interfaces trunk` look correct on the switch
- `show ip dhcp binding` shows client leases on the router

---

## Technologies & Skills Demonstrated

- Cisco IOS configuration (Router & Switch)
- VLAN design and 802.1Q trunking
- Router-on-a-Stick inter-VLAN routing
- DHCP configuration with multiple pools
- IP addressing & subnetting (/26)
- Basic switchport configuration
- Network documentation

---

## Future Improvements

- Add Access Control Lists (ACLs) between departments
- Implement NAT for internet access
- Add a guest wireless network
- Configure switch management IP (SVI)
- Add port security
