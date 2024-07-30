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
LOGDIR=~/cysic-verifier
LOGFILE=$LOGDIR/install.log

# Create log directory and log file
mkdir -p $LOGDIR
echo -e "$(date +'%Y-%m-%d %H:%M:%S') - Starting Cysic Verifier Installation" > $LOGFILE

# Logging function
log() {
    echo -e "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOGFILE
}

# Display ASCII art
log -e "${RED}  ________  ___      ___  ________   ${NC}"
log -e "${GREEN} /\"       )|\"  \\    /\"  ||\"      \"\\  ${NC}"
log -e "${YELLOW}(:   \\___/  \\   \\  //   |(.  ___  :) ${NC}"
log -e "${BLUE} \\___  \\    /\\\\  \\/.    ||: \\   ) || ${NC}"
log -e "${MAGENTA}  __/  \\\\  |: \\.        |(| (___\\ || ${NC}"
log -e "${CYAN} /\" \\   :) |.  \\    /:  ||:       :) ${NC}"
log -e "${RED}(_______/  |___|\\__/|___|(________/  ${NC}"

# Remove old directory and create new one
log "Removing old directory and creating new one..."
rm -rf $LOGDIR
mkdir $LOGDIR

# Download files
log "Downloading verifier and libzkp.so..."
if curl -L https://cysic-verifiers.oss-accelerate.aliyuncs.com/verifier_linux > $LOGDIR/verifier; then
    log "Verifier downloaded successfully."
else
    log "Failed to download verifier."
    exit 1
fi

if curl -L https://cysic-verifiers.oss-accelerate.aliyuncs.com/libzkp.so > $LOGDIR/libzkp.so; then
    log "libzkp.so downloaded successfully."
else
    log "Failed to download libzkp.so."
    exit 1
fi

# Prompt for claim reward address
echo -e "${CYAN}Enter claim reward address:${NC}"
read -p " " address
log "Claim reward address entered: $address"

# Create config.yaml
log "Creating config.yaml..."
cat <<EOF > $LOGDIR/config.yaml
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
if [ -f $LOGDIR/config.yaml ]; then
    log "config.yaml created successfully."
else
    log "Failed to create config.yaml."
    exit 1
fi

# Change to cysic-verifier directory
cd $LOGDIR
log "Changed directory to $LOGDIR."

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
