#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Display ASCII art
echo -e "${RED}  ________  ___      ___  ________   ${NC}"
echo -e "${GREEN} /\"       )|\"  \\    /\"  ||\"      \"\\  ${NC}"
echo -e "${YELLOW}(:   \\___/  \\   \\  //   |(.  ___  :) ${NC}"
echo -e "${BLUE} \\___  \\    /\\\\  \\/.    ||: \\   ) || ${NC}"
echo -e "${MAGENTA}  __/  \\\\  |: \\.        |(| (___\\ || ${NC}"
echo -e "${CYAN} /\" \\   :) |.  \\    /:  ||:       :) ${NC}"
echo -e "${RED}(_______/  |___|\\__/|___|(________/  ${NC}"

# Remove old directory and create new one
rm -rf ~/cysic-verifier
mkdir ~/cysic-verifier

# Download files
curl -L https://cysic-verifiers.oss-accelerate.aliyuncs.com/verifier_linux > ~/cysic-verifier/verifier
curl -L https://cysic-verifiers.oss-accelerate.aliyuncs.com/libzkp.so > ~/cysic-verifier/libzkp.so

# Prompt for claim reward address
read -p "Enter claim reward address: " address

# Create config.yaml
cat <<EOF > ~/cysic-verifier/config.yaml
# Not Change
chain:
  # Not Change
  endpoint: "testnet-node-1.prover.xyz:9090"
  # Not Change
  chain_id: "cysicmint_9000-1"
  # Not Change
  gas_coin: "cysic"
  # Not Change
  gas_price: 10
  # Modify Here： ! Your Address (EVM) submitted to claim rewards
claim_reward_address: "$address"

server:
  # don't modify this
  cysic_endpoint: "https://api-testnet.prover.xyz"
EOF

# Verify that config.yaml was created
if [ -f ~/cysic-verifier/config.yaml ]; then
  echo "config.yaml created successfully."
else
  echo "Failed to create config.yaml."
fi

# Change to cysic-verifier directory
cd ~/cysic-verifier/

# Make verifier executable
chmod +x verifier

# Create start.sh
echo "LD_LIBRARY_PATH=.:~/miniconda3/lib:\$LD_LIBRARY_PATH CHAIN_ID=534352 ./verifier" > start.sh

# Make start.sh executable
chmod +x start.sh

# Run the verifier
./start.sh
