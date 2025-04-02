
# 🧠 T3RN Executor Node — Dockerized Setup by TokioStack

This repository provides a clean, production-ready Docker environment for running the [T3RN Executor](https://docs.t3rn.io/executor) node.  
It’s ideal for both beginners and advanced operators — and ready for contribution upstream.

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

```bash
docker ps
docker logs -f t3rn-executor
```

Look for:
- ✅ Wallet loaded
- 🔌 RPC initialized
- 📯 Enabled networks

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

> Fork-friendly and ready for PR — contributions welcome to improve the devops flow!