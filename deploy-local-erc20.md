## Deploying Smart Contract: ERC20
- Deploy the smart contract referring here: https://github.com/paritytech/ink-examples/blob/main/erc20/lib.rs on your initiated chain
1. Test Smart Contract: `cargo test`
2. Check dependencies: `cargo check -p erc20 --release`
3. Building Release using Cargo Contract CLI: `cargo contract build --release` // Install if needed referring here: https://github.com/paritytech/cargo-contract#installation 
4. Instantiate/Deploy Contract using Cargo Contract CLI: `cargo contract instantiate --constructor new --args 1_000_000 --suri //Alice --salt $(date +%s) --execute --url ws://54.89.90.13:9945`
    - Note: used default alice's account available in dev chain to deploy and pay the gas fee. Alice Account is already prefunded
    - Above command deploys contract on local running dev chain, if no --url flag is mentioned and returns as follows:
    ```
    Code hash 0x82cbabc45bbc9413a03fd227af28ed41590f71ea118e5e4013b883b858b87dd7
    Contract 5Dm16njwuzyHXPC7AcuXJsCGdCYQCndJopsEFS6cZATBXMPU                     // Contract ID
    ```

### Getter Functions
- total_supply(): `cargo contract call --contract 5Dm16njwuzyHXPC7AcuXJsCGdCYQCndJopsEFS6cZATBXMPU --message total_supply --suri //Alice --url ws://54.89.90.13:9945`
- balance_of(owner): `cargo contract call --contract 5Dm16njwuzyHXPC7AcuXJsCGdCYQCndJopsEFS6cZATBXMPU --message balance_of --args 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY --suri //Alice --url ws://54.89.90.13:9945` //  all of the tokens are initially owned by the contract owner: ALICE.
- allowance(owner, spender): `cargo contract call --contract 5Dm16njwuzyHXPC7AcuXJsCGdCYQCndJopsEFS6cZATBXMPU --message allowance --args 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY 5FLSigC9HGRKVhB9FiEo4Y3koPsNmBmLJbpXg2mp1hXcS59Y --suri //Alice --url ws://54.89.90.13:9945` // checking allowance of charlie

### Setter Functions
- transfer(to,value) on Node01: `cargo contract call --contract 5Dm16njwuzyHXPC7AcuXJsCGdCYQCndJopsEFS6cZATBXMPU --message transfer --args 5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty 100 --suri //Alice --url ws://54.89.90.13:9945 --execute --gas 7983333376  --proof-size 262144` // alice sends 100 tokens to bob
- approve(spender,value) on Node02: `cargo contract call --contract 5Dm16njwuzyHXPC7AcuXJsCGdCYQCndJopsEFS6cZATBXMPU --message approve --args 5FLSigC9HGRKVhB9FiEo4Y3koPsNmBmLJbpXg2mp1hXcS59Y 1000 --suri //Alice --url ws://54.198.203.189:9945 --execute --gas 7983333376  --proof-size 262144` // alice approves charlie to spend 1000 tokens on her behalf
- transfer_from(from, to, value) on Node03: `cargo contract call --contract 5Dm16njwuzyHXPC7AcuXJsCGdCYQCndJopsEFS6cZATBXMPU --message transfer_from --args 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY 5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty 400 --suri //Charlie --url ws://34.207.133.2:9945 --execute --gas 7983333376  --proof-size 262144` // charlie sends on behalf of alice, 400 tokens to bob.

### Predefined Accounts
```
1. Alice SS58 Address:    5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY
2. Bob SS58 Address:      5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty
3. Charlie SS58 Address:  5FLSigC9HGRKVhB9FiEo4Y3koPsNmBmLJbpXg2mp1hXcS59Y
4. Dave SS58 Address:     5DAAnrj7VHTznn2AWBemMuyBwZWs6FNFjdyVXUeYum3PTXFy
5. Eve SS58 Address:      5HGjWAeFDfFCWPsjFQdVV2Msvz2XtMktvgocEZcCj68kUMaw
6. Ferdie SS58 Address:   5CiPPseXPECbkjWCa6MnjNokrgYjMqmKndv2rSnekmSK2DjL
```

### Additional Check Balance Method Invocation for demo purpose
check balance of bob using funded Custom Account: `cargo contract call --contract 5Dm16njwuzyHXPC7AcuXJsCGdCYQCndJopsEFS6cZATBXMPU --message balance_of --args 5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty --suri "tide front tattoo nerve kingdom resist organ recipe chicken chimney area then" --password 12345678 --url ws://54.89.90.13:9945`

check balance of charlie: `cargo contract call --contract 5Dm16njwuzyHXPC7AcuXJsCGdCYQCndJopsEFS6cZATBXMPU --message balance_of --args 5FLSigC9HGRKVhB9FiEo4Y3koPsNmBmLJbpXg2mp1hXcS59Y --suri //Alice --url ws://54.89.90.13:9945`

