**🚀 Running a T3RN Executor Node with Docker — In 5 Steps**

1. Clone the repo:  
```bash
git clone https://github.com/KARINE001/tokio-node-t3rn-executor.git
cd tokio-node-t3rn-executor
```

2. Add your `.env`:  
Fill in your wallet + networks in `.env` (use `.env.example` as template)

3. Build & Run:  
```bash
docker compose up --build -d
```

4. Check logs:  
```bash
docker logs -f t3rn-executor
```

5. Done ✅ Your Executor is live!

Support T3RN: https://t3rn.io
