#!/bin/bash

# Exit on error
set -e

# VARIABLES (can be edited)
EXECUTOR_VERSION="latest"
INSTALL_DIR="/opt/t3rn-executor"
EXECUTOR_BIN="executor"
EXECUTOR_USER="tokio"
NETWORK="sepolia"  # can be changed to rococo or others later

echo "==== Updating and installing dependencies ===="
sudo apt update && sudo apt upgrade -y
sudo apt install curl wget git build-essential pkg-config libssl-dev -y

echo "==== Creating install directory ===="
sudo mkdir -p $INSTALL_DIR
sudo chown $EXECUTOR_USER:$EXECUTOR_USER $INSTALL_DIR
cd $INSTALL_DIR

echo "==== Downloading executor binary ===="
wget https://github.com/t3rn/t3rn/releases/${EXECUTOR_VERSION}/download/executor -O $EXECUTOR_BIN
chmod +x $EXECUTOR_BIN

echo "==== Creating environment setup file ===="
cat <<EOF > .env
# Example environment setup for t3rn executor node
T3RN_EXECUTOR_NETWORK=$NETWORK
T3RN_EXECUTOR_ACCOUNT=your_account_address
T3RN_EXECUTOR_PRIVATE_KEY=your_private_key_or_path
EOF

echo "==== Installation complete ===="
echo "Now edit the .env file and set your account info before launching the node:"
echo "nano $INSTALL_DIR/.env"

echo ""
echo "To run the executor manually:"
echo "$INSTALL_DIR/$EXECUTOR_BIN --executor --network $NETWORK"
