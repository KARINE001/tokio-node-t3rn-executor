

# 🧠 Tokio Node — T3RN Executor Node (Testnet)

This repository contains everything you need to run a **T3RN Executor Node** in a containerized environment using Docker.

---

## 🧰 Features

- 🐳 Simple Docker-based setup
- 🔁 Auto-restart on failure
- 🔐 Environment variables in `.env` file
- 🧪 Testnet-ready (Sepolia, Optimism, Base, Arbitrum, Unichain, Caldera)
- 🧩 Fully aligned with the official [T3RN documentation](https://docs.t3rn.io/executor/become-an-executor/binary-setup)

---

## 🚀 Prerequisites

> ✅ Make sure Docker and Docker Compose are installed on your VPS or local machine:

```bash
# Install Docker
curl -fsSL https://get.docker.com | sh

# (Optional) Add current user to Docker group
sudo usermod -aG docker $USER
newgrp docker

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Install Compose plugin if not present
sudo apt install docker-compose-plugin
```

## 📂 Clone this Repository

```bash
git clone https://github.com/KARINE001/tokio-node-t3rn-executor.git
cd tokio-node-t3rn-executor
```

## ⚙️ Configure the Environment

Rename the example file and set your private key:

```bash
cp .env.example .env
nano .env
```

Paste your private key and save the file.

## 🛠️ Build and Run the Node

```bash
docker compose up -d --build
```

This will:

- Download the latest executor binary from T3RN GitHub releases
- Build the Docker image
- Start the container with all required environment variables
- Map necessary ports (9944, 30333)

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

## 🧪 Test RPC

```bash
curl http://127.0.0.1:9944
```

## 🔄 Restart Policy (Docker Native)

This node does not need a systemd file because Docker handles restart automatically.

To ensure restart on reboot or crash:

```yaml
# docker-compose.yml
restart: unless-stopped
```

## 🔐 Fund Your Wallet for Testing

You’ll need testnet ETH on all enabled networks:

1. **Faucet Sepolia ETH**
    - https://sepolia-faucet.pk910.de/
    - https://docs.metamask.io/developer-tools/faucet/
2. **Use Bridges for Test Tokens**
    - https://superbridge.app/base-sepolia
    - https://testnets.relay.link/bridge
3. **Caldera Faucet (L2RN)**
    - https://rivalz2.hub.caldera.xyz/

> Make sure to bridge some Sepolia ETH to Base, Optimism, Unichain, and Caldera testnets.

## ✅ Monitoring Snippet

```bash
docker logs -f t3rn-executor
docker exec -it t3rn-executor netstat -tnp | grep 30333
```

## 🧾 Project Structure

```
tokio-node-t3rn-executor/
├── docker-compose.yml
├── Dockerfile
├── .env.example
├── entrypoint.sh
├── README.md
└── ...
```

### 🙌 Credit

This node pack was created by [@tokiostack](https://github.com/karine001) based on the official **T3RN Executor Documentation**. 

🔗 GitHub: [@karine001](https://github.com/karine001)  
🐦 Twitter: [@tokiostack](https://twitter.com/tokiostack)

Feel free to fork, improve, and contribute — just keep a link back 🖖