# t3rn Executor Node Installation (Full Setup)

This repository provides a full guide and installation script for setting up a **t3rn Executor Node** on your VPS.

## What is t3rn?
t3rn is a cross-chain execution protocol designed to execute smart contracts across multiple blockchains reliably.

## What is the Executor?
An Executor is a node that listens to execution requests and performs the actual transaction on the target chain. It's a key component of t3rn's trustless execution layer.

---

## VPS Requirements
- OS: Ubuntu 22.04 LTS
- 4+ vCPU, 16+ GB RAM, 200+ GB SSD
- Open ports: 30333, 9933, 9944

---

## Installation Steps

1. Upload and run the script:
```bash
chmod +x install.sh
./install.sh
```

2. Edit the environment file:
```bash
nano /opt/t3rn-executor/.env
```
Fill in:
- Your account address
- Your private key
- The network (e.g., sepolia or rococo)

3. Run the executor:
```bash
/opt/t3rn-executor/executor --executor --network sepolia
```

---

## Optional: systemd integration

You can run the executor as a system service. Ask us for `executor.service` or follow the guide.

---

## Resources
- Official Docs: https://docs.t3rn.io/executor/become-an-executor/binary-setup
- Project Website: https://www.t3rn.io/
