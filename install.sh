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

#!/bin/bash

# Define variables
VERIFIER_URL="https://cysic-verifiers.oss-accelerate.aliyuncs.com/verifier_linux"
LIBZKP_URL="https://cysic-verifiers.oss-accelerate.aliyuncs.com/libzkp.so"
CONFIG_FILE="~/cysic-verifier/config.yaml"
START_SCRIPT="~/cysic-verifier/start.sh"

# Remove existing directory if it exists
rm -rf ~/cysic-verifier

# Create the directory
mkdir -p ~/cysic-verifier

# Download necessary files
curl -L $VERIFIER_URL -o ~/cysic-verifier/verifier
curl -L $LIBZKP_URL -o ~/cysic-verifier/libzkp.so

# Create configuration file
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
claim_reward_address: "0x696969696969"

server:
  # don't modify this
  cysic_endpoint: "https://api-testnet.prover.xyz"
EOF

# Make verifier executable
chmod +x ~/cysic-verifier/verifier

# Create and configure the start script
cat <<EOF > ~/cysic-verifier/start.sh
#!/bin/bash
# Set library path and start the verifier
LD_LIBRARY_PATH=~/cysic-verifier:$LD_LIBRARY_PATH ~/cysic-verifier/verifier
EOF

# Make the start script executable
chmod +x ~/cysic-verifier/start.sh

# Run the start script
~/cysic-verifier/start.sh

