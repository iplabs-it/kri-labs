# KRI Labs — Routing Protocol Exercises

Lab exercises for the KRI (Komutacja i Routing w Internecie) course, built with [Containerlab](https://containerlab.dev/) and [FRR (Free Range Routing)](https://frrouting.org/).

Each lab provides a pre-configured network topology that students deploy as lightweight Linux containers and then configure routing protocols interactively using `vtysh`.

## Repository Structure

```
kri-labs/
├── README.md          ← you are here
├── common/
│   └── capture.sh     # shared Wireshark packet-capture helper
├── ospf/              # Lab 1 – OSPF
│   ├── ospf.clab.yml
│   ├── daemons
│   ├── R1–R5.conf
│   └── README.md
└── isis/              # Lab 2 – IS-IS
    ├── isis.clab.yml
    ├── daemons
    ├── bridge.sh
    ├── R1–R6.conf
    └── README.md
```

## Prerequisites

The labs are designed to run on a **Debian 12** virtual machine with Internet access, Docker, Containerlab, and FRR images.

## Quick Start

1. **Clone the repository** into your home directory:

   ```bash
   cd ~
   git clone https://github.com/iplabs-it/kri-labs.git
   cd kri-labs
   ```

2. **Pick a lab** and deploy it:

   ```bash
   cd ospf
   sudo containerlab deploy --topo ospf.clab.yml
   ```

3. **Connect to a router** and configure it:

   ```bash
   sudo docker exec -it clab-ospf-R1 vtysh
   ```

4. **Capture traffic** (optional) — use the helper script from `common/`:

   ```bash
   bash ../common/capture.sh clab-ospf-R1 eth1
   ```

5. **Destroy the lab** when done:

   ```bash
   sudo containerlab destroy --topo ospf.clab.yml
   ```

## Useful Commands

| Action | Command |
|---|---|
| Deploy a lab | `sudo containerlab deploy --topo <file>.clab.yml` |
| Destroy a lab | `sudo containerlab destroy --topo <file>.clab.yml` |
| List running containers | `sudo containerlab inspect --topo <file>.clab.yml` |
| Enter router CLI | `sudo docker exec -it clab-<lab>-<node> vtysh` |
| Enter container shell | `sudo docker exec -it clab-<lab>-<node> bash` |
| Show routing table | Inside vtysh: `show ip route` |
| Live packet capture | `bash ../common/capture.sh clab-<lab>-<node> <iface>` |
