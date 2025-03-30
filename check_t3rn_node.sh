#!/bin/bash
CONTAINER_NAME="t3rn-executor"
LOG_LINES=20

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

# 3. Resource usage
echo -e "\n📊 CPU & RAM Usage:"
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" | grep $CONTAINER_NAME

# 4. Restart count
RESTARTS=$(docker inspect -f '{{.RestartCount}}' $CONTAINER_NAME)
echo -e "\n🔁 Restart count: $RESTARTS"

# 5. Recent logs
echo -e "\n🔍 Last $LOG_LINES logs:"
docker logs --tail $LOG_LINES $CONTAINER_NAME 2>/dev/null

# 6. Metrics from logs
echo -e "\n📊 Metrics from logs:"
BIDS=$(docker logs --tail $LOG_LINES $CONTAINER_NAME 2>/dev/null | grep -c 'BidReceived')
REJECTED=$(docker logs --tail $LOG_LINES $CONTAINER_NAME 2>/dev/null | grep -c 'Your bid was not accepted')
ERRORS=$(docker logs --tail $LOG_LINES $CONTAINER_NAME 2>/dev/null | grep -ci 'error')
NETWORKS=$(docker logs --tail $LOG_LINES $CONTAINER_NAME 2>/dev/null | grep -Eo '"networkId":"[a-z-]+"' | sort | uniq -c)

echo "🔁 BidReceived: $BIDS"
echo "❌ Rejected bids: $REJECTED"
echo "🚨 Errors: $ERRORS"
echo -e "🌐 Networks in logs:\n$NETWORKS"

