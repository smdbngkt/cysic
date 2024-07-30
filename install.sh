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


# Define variables
VERIFIER_URL="https://cysic-verifiers.oss-accelerate.aliyuncs.com/verifier_linux"
LIBZKP_URL="https://cysic-verifiers.oss-accelerate.aliyuncs.com/libzkp.so"
CONFIG_DIR="$HOME/cysic-verifier"
CONFIG_FILE="$CONFIG_DIR/config.yaml"
START_SCRIPT="$CONFIG_DIR/start.sh"

# Prompt for input
read -p "Enter your EVM address to claim rewards: " claim_reward_address

# Remove existing directory if it exists
rm -rf $CONFIG_DIR

# Create the directory
mkdir -p $CONFIG_DIR

# Download necessary files
curl -L $VERIFIER_URL -o $CONFIG_DIR/verifier
curl -L $LIBZKP_URL -o $CONFIG_DIR/libzkp.so

# Create configuration file with user input
cat <<EOF > $CONFIG_FILE
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
claim_reward_address: "$claim_reward_address"

server:
  # don't modify this
  cysic_endpoint: "https://api-testnet.prover.xyz"
EOF

# Verify if config file is created
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Config file $CONFIG_FILE not found!"
  exit 1
fi

# Make verifier executable
chmod +x $CONFIG_DIR/verifier

# Create and configure the start script
cat <<EOF > $START_SCRIPT
#!/bin/bash
# Set library path and start the verifier
export LD_LIBRARY_PATH=$CONFIG_DIR:$LD_LIBRARY_PATH
export CHAIN_ID=534352
$CONFIG_DIR/verifier
EOF

# Make the start script executable
chmod +x $START_SCRIPT

# Run the start script
$START_SCRIPT
