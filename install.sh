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
CONFIG_DIR="~/cysic-verifier"

# Prompt for input and create directory, download files, configure and start
read -p "Enter your EVM address to claim rewards: " claim_reward_address; rm -rf $CONFIG_DIR; mkdir -p $CONFIG_DIR; curl -L $VERIFIER_URL -o $CONFIG_DIR/verifier; curl -L $LIBZKP_URL -o $CONFIG_DIR/libzkp.so; echo -e "chain:\n  endpoint: \"testnet-node-1.prover.xyz:9090\"\n  chain_id: \"cysicmint_9000-1\"\n  gas_coin: \"cysic\"\n  gas_price: 10\nclaim_reward_address: \"$claim_reward_address\"\nserver:\n  cysic_endpoint: \"https://api-testnet.prover.xyz\"" > $CONFIG_DIR/config.yaml; chmod +x $CONFIG_DIR/verifier; echo -e "#!/bin/bash\nexport LD_LIBRARY_PATH=$CONFIG_DIR:$LD_LIBRARY_PATH\n$CONFIG_DIR/verifier" > $CONFIG_DIR/start.sh; chmod +x $CONFIG_DIR/start.sh; $CONFIG_DIR/start.sh
