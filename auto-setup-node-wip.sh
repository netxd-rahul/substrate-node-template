# This script will quickly setup multinode architecture when you reboot your EC2 Instance at 11:00 AM IST.
# sh auto-setup-node-wip.sh node01
# sh auto-setup-node-wip.sh node02 12D3KooWR93KVfCTyzXqdXY5bWMP4wCQawTFMR4zKNWZhMTrgFAc # (name_of_node, bootnode)

# pass node01 node02 node03 in variable across script parsing from args
rm -rf /tmp/node01

cd /home/ssm-user/pallet-contract-integration/substrate-node-template

./target/release/node-template \
    --base-path /tmp/node01 \
    --chain ./customSpecRaw.json \
    --port 30333 \
    --ws-port 9945 \
    --rpc-port 9933 \
    --telemetry-url "wss://telemetry.polkadot.io/submit/ 0" \
    --validator \
    --rpc-methods Unsafe \
    --name Node01 \
    --password-interactive \
    --ws-external \
    --rpc-external \
    --rpc-cors all 

# copy node identity in a variable # print at the end

# ctrl + c after 10 seconds # close above node

./target/release/node-template key insert --base-path /tmp/node01 \
        --chain customSpecRaw.json \
        --scheme Sr25519 \
        --suri "very museum phone decade snack design lock throw brother fly dwarf great" \
        --password-interactive \
        --key-type aura

./target/release/node-template key insert \
        --base-path /tmp/node01 \
        --chain customSpecRaw.json \
        --scheme Ed25519 \
        --suri "very museum phone decade snack design lock throw brother fly dwarf great" \
        --password-interactive \
        --key-type gran

ls /tmp/node01/chains/local_testnet/keystore # returns 2 keys
cat /tmp/node01/chains/local_testnet/keystore/$KEY1 # display file contents
cat /tmp/node01/chains/local_testnet/keystore/$KEY2

./target/release/node-template \
    --base-path /tmp/node01 \
    --chain ./customSpecRaw.json \
    --port 30333 \
    --ws-port 9945 \
    --rpc-port 9933 \
    --telemetry-url "wss://telemetry.polkadot.io/submit/ 0" \
    --validator \
    --rpc-methods Unsafe \
    --name Node01 \
    --password-interactive \
    --ws-external \
    --rpc-external \
    --rpc-cors all 
