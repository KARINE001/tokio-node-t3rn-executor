#!/bin/bash
CONTAINER_NAME="t3rn-executor"
LOG_LINES=500
declare -A RPC_ENDPOINTS=(
  ["l2rn"]="https://rivalz2.rpc.caldera.xyz/http"
  ["arbt"]="https://arbitrum-sepolia.drpc.org"
  ["bast"]="https://base-sepolia-rpc.publicnode.com"
  ["opst"]="https://sepolia.optimism.io"
  ["unit"]="https://unichain-sepolia-rpc.publicnode.com"
)

echo "=== 🧠 T3RN EXECUTOR NODE DIAGNOSTIC ==="

# 1. Container status
if docker ps | grep -q $CONTAINER_NAME; then
  echo "✅ Container '$CONTAINER_NAME' is running."
else
  echo "❌ Container '$CONTAINER_NAME' is NOT running!"
  exit 1
fi

# 2. Uptime
echo -e "\n⏱️ Uptime:"
docker inspect -f '{{.State.StartedAt}}' $CONTAINER_NAME

# 3. CPU & RAM
echo -e "\n📊 CPU & RAM Usage:"
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" | grep $CONTAINER_NAME

# 4. Restart count
RESTARTS=$(docker inspect -f '{{.RestartCount}}' $CONTAINER_NAME)
echo -e "\n🔁 Restart count: $RESTARTS"
if [ "$RESTARTS" -gt 3 ]; then
  echo "⚠️ Warning: High restart count. Consider running:"
  echo "    docker compose down && docker compose up -d --build"
fi

# 5. Logs tail
echo -e "\n🔍 Last 20 logs:"
docker logs --tail 20 $CONTAINER_NAME 2>/dev/null

# 6. Log metrics
echo -e "\n📊 Log metrics (last $LOG_LINES lines):"
BIDS=$(docker logs --tail $LOG_LINES $CONTAINER_NAME 2>/dev/null | grep -c 'BidReceived')
REJECTED=$(docker logs --tail $LOG_LINES $CONTAINER_NAME 2>/dev/null | grep -c 'Your bid was not accepted')
ERRORS=$(docker logs --tail $LOG_LINES $CONTAINER_NAME 2>/dev/null | grep -ci 'error')
NETWORKS=$(docker logs --tail $LOG_LINES $CONTAINER_NAME 2>/dev/null | grep -Eo '"networkId":"[a-z-]+"' | sort | uniq -c)

echo "🔁 BidReceived: $BIDS"
echo "❌ Rejected bids: $REJECTED"
echo "🚨 Errors: $ERRORS"
echo -e "🌐 Networks in logs:\n$NETWORKS"

if [ "$ERRORS" -gt 10 ]; then
  echo "⚠️ High error count. Check your .env or RPCs."
fi

# 7. Bid score
echo -e "\n📈 Bid Quality Indicator:"
if [ "$BIDS" -gt 0 ]; then
  SUCCESS=$((BIDS - REJECTED))
  PERCENT=$((SUCCESS * 100 / BIDS))
  echo "✅ Accepted bids: $SUCCESS/$BIDS ($PERCENT%)"
else
  echo "⚠️ No bids received recently."
fi

# 8. RPC endpoint checks
echo -e "\n🌐 RPC Endpoint Status:"
for net in "${!RPC_ENDPOINTS[@]}"; do
  RPC="${RPC_ENDPOINTS[$net]}"
  echo -n "$net → $RPC : "
  curl -s -X POST "$RPC" \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' | grep -q result \
  && echo "✅ OK" || echo "❌ Failed"
done
