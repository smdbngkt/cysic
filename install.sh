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

echo -e "${CYAN} Cysic Testnet Node Installation ${NC}"

# Remove old directory and create new one
rm -rf ~/cysic-verifier
mkdir ~/cysic-verifier

# Download files
echo "Downloading verifier and libzkp.so..."
curl -L https://cysic-verifiers.oss-accelerate.aliyuncs.com/verifier_linux -o ~/cysic-verifier/verifier
if [[ $? -ne 0 ]]; then
  echo -e "${RED}Failed to download verifier${NC}"
  exit 1
fi

curl -L https://cysic-verifiers.oss-accelerate.aliyuncs.com/libzkp.so -o ~/cysic-verifier/libzkp.so
if [[ $? -ne 0 ]]; then
  echo -e "${RED}Failed to download libzkp.so${NC}"
  exit 1
fi

# Prompt for claim reward address
echo -e "${CYAN}Enter claim reward address:${NC}"
read -p " " address

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

# Change to cysic-verifier directory
cd ~/cysic-verifier/

# Make verifier executable
chmod +x verifier

# Create start.sh
cat <<EOF > start.sh
#!/bin/bash
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:$(pwd)
export CHAIN_ID=534352
./verifier
EOF

# Make start.sh executable
chmod +x start.sh

# Check dependencies
ldd ./verifier | grep "not found"
if [[ $? -eq 0 ]]; then
  echo -e "${RED}Some dependencies are missing. Please install them before running the verifier.${NC}"
  exit 1
fi

# Run the verifier
./start.sh

# Check if verifier started successfully
if [[ $? -ne 0 ]]; then
  echo -e "${RED}Verifier failed to start${NC}"
  exit 1
fi

echo -e "${GREEN}Verifier started successfully${NC}"
