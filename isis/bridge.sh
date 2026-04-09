#!/bin/bash
# --- add bridge (remove existing one first if present)
if ip link show BR &>/dev/null; then
    echo "Bridge BR already exists — removing it first..."
    sudo ip link set down dev BR
    sudo brctl delbr BR
fi
sudo brctl addbr BR
sudo brctl stp BR off
sudo ip link set up dev BR
sudo brctl show
