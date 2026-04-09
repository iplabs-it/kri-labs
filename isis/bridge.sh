#!/bin/bash
# --- add bridge
sudo brctl addbr BR
sudo brctl stp BR off
sudo ip link set up dev BR
sudo brctl show