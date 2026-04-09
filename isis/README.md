# Lab: IS-IS

Intermediate System to Intermediate System routing protocol lab using Containerlab and FRR.

## Topology

6 FRR routers (R1–R6), 3 end hosts (PC1–PC3), and a Linux bridge (BR):

```
   PC1
    |
   R1--\
   R3---BR---R2---R6---PC3
              |  / |  /
              R4---R5
                    |
                   PC2
```

R1, R2, and R3 share a broadcast segment via the bridge (BR) on `10.0.123.0/24`. R1 also has four additional loopback interfaces (`lo1`–`lo4`) for route aggregation/filtering exercises.

**Subnets:**

- PC1 (`192.168.1.0/24`) — connected to R1
- PC2 (`192.168.2.0/24`) — connected to R5
- PC3 (`192.168.3.0/24`) — connected to R6
- Bridge segment: `10.0.123.0/24` (R1, R2, R3)
- Point-to-point links: `10.0.24.0/24`, `10.0.26.0/24`, `10.0.45.0/24`, `10.0.46.0/24`, `10.0.56.0/24`

Router configurations include interface IP addresses — students configure IS-IS routing on top.

## Files

| File | Description |
|---|---|
| `isis.clab.yml` | Containerlab topology definition |
| `daemons` | FRR daemon config (isisd + ripd enabled) |
| `bridge.sh` | Script to create the Linux bridge |
| `R1.conf` – `R6.conf` | FRR startup configs with IP addressing |

## Getting the Lab

**If you already have KRI-labs on this VM:**

```bash
cd ~/KRI-labs
git pull
git merge --no-edit origin/lab2-isis
```

**Starting on a new VM (no repo yet):**

```bash
cd ~
git clone https://github.com/iplabs-it/KRI-labs.git
cd KRI-labs
git merge --no-edit origin/lab2-isis
```

## Usage

```bash
cd ~/KRI-labs/isis
bash bridge.sh
containerlab deploy --topo isis.clab.yml
docker exec -it clab-isis-R1 vtysh
```

When done:

```bash
containerlab destroy --topo isis.clab.yml
```
