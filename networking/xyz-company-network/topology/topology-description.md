# Topology Description – XYZ Company Network

## Overview

This lab represents a small office network for **XYZ Company** with three departments, each having both wired and wireless devices. The network uses a single router and a single switch with Router-on-a-Stick for inter-VLAN routing.

## Devices Used

| Device              | Model / Type       | Role                              |
|---------------------|--------------------|-----------------------------------|
| Router0             | Cisco 2911         | Router-on-a-Stick (Inter-VLAN routing + DHCP) |
| Switch0             | Cisco 2960         | Access Switch + Trunk             |
| Access Point0       | Access Point-PT    | Wireless for ADMIN/IT             |
| Access Point1       | Access Point-PT    | Wireless for FINANCE/HR           |
| Access Point2       | Access Point-PT    | Wireless for RECEPTION            |
| End Devices         | PCs, Laptops, Printers, Smartphones | Department users              |

## Department Layout

### 1. ADMIN / IT Department (VLAN 10)
- **Network:** 192.168.1.0/26
- **Color in topology:** Blue
- **Devices:**
  - Access Point0 (Wireless)
  - PC0
  - Printer0
  - Laptop1
  - Smartphone1

### 2. FINANCE / HR Department (VLAN 20)
- **Network:** 192.168.1.64/26
- **Color in topology:** Green
- **Devices:**
  - Access Point1 (Wireless)
  - PC1
  - Printer1
  - Laptop0
  - Smartphone0

### 3. RECEPTION / CUSTOMER SERVICE (VLAN 30)
- **Network:** 192.168.1.128/26
- **Color in topology:** Yellow
- **Devices:**
  - Access Point2 (Wireless)
  - PC2
  - PC3

## Physical Connections


- The **Router** is connected to the **Switch** using a trunk link.
- All end devices and Access Points are connected to the Switch.
- Each department is logically separated using VLANs.

## Logical Design

- **Router-on-a-Stick** is used for communication between the three departments.
- Each department has its own:
  - VLAN
  - Subnet (/26)
  - DHCP pool
  - Wireless Access Point

## Wireless Design

| Department              | Access Point     | VLAN | Network            |
|-------------------------|------------------|------|--------------------|
| ADMIN / IT              | Access Point0    | 10   | 192.168.1.0/26     |
| FINANCE / HR            | Access Point1    | 20   | 192.168.1.64/26    |
| RECEPTION / CUSTOMER SERVICE | Access Point2 | 30   | 192.168.1.128/26   |

## Summary

This topology successfully meets all the project requirements:
- One router + one switch
- Three departments with wireless access
- Automatic IP addressing via DHCP
- Full communication between departments
- Efficient use of the 192.168.1.0 network
