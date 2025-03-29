#!/bin/bash
CONTAINER_NAME="t3rn-executor"
echo "=== T3RN EXECUTOR NODE DIAGNOSTIC ==="

# Container status
docker ps | grep $CONTAINER_NAME > /dev/null && echo "✅ Container '$CONTAINER_NAME' is running." || echo "❌ Container '$CONTAINER_NAME' is NOT running!"

# Logs
echo -e "\n🔍 Recent logs:"
docker logs --tail 20 $CONTAINER_NAME 2>/dev/null

# Port status
echo -e "\n🌐 Port bindings:"
docker exec -it $CONTAINER_NAME netstat -tnp | grep 9944
docker exec -it $CONTAINER_NAME netstat -tnp | grep 30333
