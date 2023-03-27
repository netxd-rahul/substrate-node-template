## Substrate Node with Pallet_Contracts Integration

### Deploy on Local
1. `git clone https://github.com/netxd-rahul/substrate-node-template/`
2. `git checkout pallet-contract-v0.9.37`
3. Check dependencies: `cargo check -p node-template-runtime --release`
4. Build Release: `cargo build --release`
5. Run: `./target/release/node-template --dev --ws-external`

### Notes
1. The above run command initiates a `dev` chain of substrate which is pre configured with some accounts and balances

### Next 
- Deploy the smart contract referring here: https://github.com/paritytech/ink-playgroung-flipper on above initiated chain
    1. Test Smart Contract: `cargo test`
    2. Check dependencies: `cargo check -p flipper --release`
    3. Building Release using Cargo Contract CLI: `cargo contract build --release` // Install if needed referring here: https://github.com/paritytech/cargo-contract#installation 
    4. Instantiate/Deploy Contract using Cargo Contract CLI: `cargo contract instantiate --constructor new --args "false" --suri //Alice --salt $(date +%s) --execute`
        - Note: used default alice's account available in dev chain to deploy and pay the gas fee
        - Above command deploys contract on local running dev chain and returns as follows:
        ```
        Code hash 0x4789e25913289df769d23461e707095774fb9dab74d66cdfff805e9498d77ac0    // Code Hash
        Contract 5Cd9AMd5Xj6TqKVUKMkZegYZmp1FYViNZ4TYYtDsJX1DYevM                       // Contract ID
        ```
    5. Invoke Contract's Getter Function: `cargo contract call --contract 5Cd9AMd5Xj6TqKVUKMkZegYZmp1FYViNZ4TYYtDsJX1DYevM --message get --suri //Alice`
    6. Invoke Contract's Setter Function: `cargo contract call --contract 5Cd9AMd5Xj6TqKVUKMkZegYZmp1FYViNZ4TYYtDsJX1DYevM --message flip --suri //Alice --execute --gas 7983333376  --proof-size 262144 --skip-dry-run`