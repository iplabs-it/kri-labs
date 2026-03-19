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

The labs are designed to run on a **Debian 12** virtual machine with Internet access. Install the following before starting:

### 1. Docker

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin
sudo usermod -aG docker $USER
```

> Log out and back in (or run `newgrp docker`) for the group change to take effect.

### 2. Containerlab

```bash
bash -c "$(curl -sL https://get.containerlab.dev)"
```

### 3. Wireshark & tcpdump (optional, for packet captures)

```bash
sudo apt-get install -y wireshark tcpdump
```

### 4. Docker images

The labs use two container images — `frr` and `vpc`. Your instructor will provide these or you can build them yourself. Load them into Docker:

```bash
docker load -i frr.tar
docker load -i vpc.tar
```

Verify they are available:

```bash
docker images | grep -E 'frr|vpc'
```

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

## Troubleshooting

- **"permission denied" when running docker** — make sure your user is in the `docker` group and you re-logged.
- **Containerlab not found** — ensure `/usr/bin/containerlab` exists or re-run the install script.
- **Images not found** — run `docker images` to check; load them with `docker load -i <image>.tar`.
- **Wireshark not opening** — you need an X11 display; if running headless, capture to a file instead:
  ```bash
  sudo ip netns exec <namespace> tcpdump -nni <iface> -w capture.pcap
  ```
