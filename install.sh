#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Log file
LOGFILE=~/cysic-verifier/install.log

# Logging function
log() {
    echo -e "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOGFILE
}

# Display ASCII art
"${RED}  ________  ___      ___  ________   ${NC}"
"${GREEN} /\"       )|\"  \\    /\"  ||\"      \"\\  ${NC}"
"${YELLOW}(:   \\___/  \\   \\  //   |(.  ___  :) ${NC}"
"${BLUE} \\___  \\    /\\\\  \\/.    ||: \\   ) || ${NC}"
"${MAGENTA}  __/  \\\\  |: \\.        |(| (___\\ || ${NC}"
"${CYAN} /\" \\   :) |.  \\    /:  ||:       :) ${NC}"
"${RED}(_______/  |___|\\__/|___|(________/  ${NC}"

# Remove old directory and create new one
log "Removing old directory and creating new one..."
rm -rf ~/cysic-verifier
mkdir ~/cysic-verifier

# Download files
log "Downloading verifier and libzkp.so..."
if curl -L https://cysic-verifiers.oss-accelerate.aliyuncs.com/verifier_linux > ~/cysic-verifier/verifier; then
    log "Verifier downloaded successfully."
else
    log "Failed to download verifier."
    exit 1
fi

if curl -L https://cysic-verifiers.oss-accelerate.aliyuncs.com/libzkp.so > ~/cysic-verifier/libzkp.so; then
    log "libzkp.so downloaded successfully."
else
    log "Failed to download libzkp.so."
    exit 1
fi

# Prompt for claim reward address
read -p "Enter claim reward address: " address
log "Claim reward address entered: $address"

# Create config.yaml
log "Creating config.yaml..."
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
    log "config.yaml created successfully."
else
    log "Failed to create config.yaml."
    exit 1
fi

# Change to cysic-verifier directory
cd ~/cysic-verifier/
log "Changed directory to ~/cysic-verifier."

# Make verifier executable
log "Making verifier executable..."
chmod +x verifier

# Create start.sh
log "Creating start.sh..."
cat <<EOF > start.sh
#!/bin/bash
LD_LIBRARY_PATH=.:~/miniconda3/lib:\$LD_LIBRARY_PATH CHAIN_ID=534352 ./verifier
EOF

# Make start.sh executable
log "Making start.sh executable..."
chmod +x start.sh

# Run the verifier
log "Running the verifier..."
./start.sh
if [ $? -eq 0 ]; then
    log "Verifier started successfully."
else
    log "Failed to start the verifier."
    exit 1
fi
