
# 🧠 T3RN Executor Node — Dockerized Setup by TokioStack

This repository provides a clean, production-ready Docker environment for running the [T3RN Executor](https://docs.t3rn.io/executor) node.  


---

## 🚀 Features

- 🐳 Dockerized Executor binary (auto-fetches latest)
- 🔐 Secure `.env` configuration
- 🔁 Auto-rebuild for version/config updates
- 📊 Prometheus metrics (port `9090`)
- 🧪 Multi-network testnet support
- 🧩 Matches the [official binary setup](https://docs.t3rn.io/executor/become-an-executor/binary-setup)

---

## ⚙️ VPS Requirements

| Resource | Minimum        |
|----------|----------------|
| OS       | Ubuntu 22.04+  |
| CPU      | 4 vCPU         |
| RAM      | 16 GB          |
| Storage  | 200+ GB SSD    |

Open Prometheus port:
```bash
sudo ufw allow 9090/tcp
sudo ufw reload
```

---

## 🛠️ Installation Guide

### 1. Clone the Repo

```bash
git clone https://github.com/yourname/t3rn-executor-docker.git
cd t3rn-executor-docker
```

### 2. Set Up the Environment

```bash
cp .env.example .env
nano .env
```

🔑 Paste your wallet’s **private key**  
🌐 Add valid RPCs under `RPC_ENDPOINTS` (see `.env.example`)

### 3. Build and Launch the Node

```bash
docker compose up -d --build
```

✅ This will:
- Build the image
- Download the latest `executor` binary
- Apply your config
- Start the container in background

---

## 🔄 Updating Your Executor Node

Anytime you:
- Add/change networks or RPCs
- Want the latest Executor version from GitHub

Run:
```bash
docker compose down
docker compose up -d --build
```

This will:
- 🚀 Rebuild the Docker image
- 🔧 Apply updated config
- 🆕 Pull the latest Executor binary


---

## ✅ Check If the Node Is Running

```bash
docker ps
docker logs -f t3rn-executor
```

You should see:
- ✅ Wallet loaded  
- 🔌 RPC provider initialized  
- 🔗 Connected to network  
- 📯 Enabled networks: ...


---

## 🧰 Docker Commands Cheat Sheet

```bash
docker ps                        # Show running containers
docker logs -f t3rn-executor    # View logs
docker stop t3rn-executor       # Stop the node
docker rm t3rn-executor         # Remove the container
docker compose down             # Stop and clean everything
docker system prune -a          # Wipe unused images/containers
```

---

## 🌐 Ports to Open

The T3RN Executor node does not expose RPC/WebSocket interfaces or require peer-to-peer connections.  
Only one port is necessary for Prometheus metrics if monitoring is enabled.

| Port     | Protocol | Purpose            |
|----------|----------|--------------------|
| 9090/tcp | TCP      | Prometheus endpoint |

```bash
sudo ufw allow 9090/tcp
sudo ufw reload
```


:::caution Wallet balance requirement is hardcoded

The minimum required balance for each enabled network is **not configurable** via `.env`.

To be eligible for bidding:
- Ensure your wallet holds **at least 10–11 ETH (testnet)** on **each** enabled network.
- This threshold is defined inside the Executor binary (`EXECUTOR_MIN_BALANCE_THRESHOLD_ETH`) and cannot be changed manually.

Use [relay.link](https://testnets.relay.link/bridge) or [superbridge.app](https://superbridge.app) to bridge test ETH across networks.  
You can also **buy Sepolia ETH using Mainnet ETH** via [testnetbridge.com](https://www.testnetbridge.com).
:::



## 📂 Project Structure

```
t3rn-executor-docker/
├── docker-compose.yml
├── Dockerfile
├── .env.example
├── entrypoint.sh
├── README.md
```

---

## 🧪 Health Check Script

To check if your node is healthy and functioning properly, run the built-in diagnostic script:

```bash
bash check_t3rn_node.sh
```

### What it does:
- ✅ Checks if the Docker container is running
- ⏱ Displays uptime and resource usage
- 🔁 Warns if the container is restarting too often
- 🔍 Parses logs to show:
  - Number of bids received and rejected
  - Errors count
  - Active networks
- 🌐 Validates each RPC endpoint is live via real-time `eth_blockNumber` requests


It's especially useful after setup, or if you suspect issues with RPCs or network responsiveness.

---

## 🙌 Credits

- Based on [T3RN Docs](https://docs.t3rn.io/executor)
- Dockerized by [TokioStack](https://github.com/karine001)



> If you use this repo or adapt it, please credit **TokioStack** 🙏 — contributions welcome to improve the devops flow!