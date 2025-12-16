#!/bin/bash
LOGFILE="enum_$(date +%F_%H-%M-%S).log"
exec > >(tee -a "$LOGFILE") 2>&1

if [ "$EUID" -ne 0 ]; then
  echo "[!] Warning: Run as root for full enumeration"
  echo
fi

# =========================================
# Linux & Network Enumeration Toolkit
# Author: Harshraj
# Description: Basic system enumeration
# =========================================

echo "================================="
echo "   LINUX SYSTEM ENUMERATION"
echo "================================="
echo

echo "Hostname:" $(hostname)
echo

echo "OS Information:" $(grep PRETTY_NAME /etc/os-release | cut -d= -f2)
echo

echo "Kernel Version:" $(uname -r)
echo

echo "Logged-in Users:" $(who)
echo

echo "CPU Information:" $(lscpu | grep "Model name")
echo

echo "Memory Usage:" $(free -h)
echo

echo "Disk Usage:" $(df -h | grep "^/dev")
echo

echo "================================="
echo "   NETWORK ENUMERATION"
echo "================================="
echo

echo "Network Interfaces & IP Addresses:"
ip -brief address
echo

echo "Routing Table:"
ip r
echo

echo "Open Listening Ports (TCP/UDP):"
ss -tuln | grep LISTEN
echo

echo "Running Services:"
systemctl list-units --type=service --state=running | awk '{print $1}'
echo
