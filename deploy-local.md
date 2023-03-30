## Substrate Node with Pallet_Contracts Integration

### Deploy Node on Local Machine
1. `git clone https://github.com/netxd-rahul/substrate-node-template/`
2. `git checkout pallet-contract-v0.9.37`
3. Check dependencies: `cargo check -p node-template-runtime --release`
4. Build Release: `cargo build --release`
5. Run: `./target/release/node-template --dev --ws-external`

### Notes
1. The above run command initiates a `dev` chain of substrate which is pre configured with some accounts and balances

## Next: Deploying Smart Contract
- Deploy the smart contract referring here: https://github.com/paritytech/ink-playgroung-flipper on above initiated chain
    1. Test Smart Contract: `cargo test`
    2. Check dependencies: `cargo check -p flipper --release`
    3. Building Release using Cargo Contract CLI: `cargo contract build --release` // Install if needed referring here: https://github.com/paritytech/cargo-contract#installation 
    4. Instantiate/Deploy Contract using Cargo Contract CLI: `cargo contract instantiate --constructor new --args "false" --suri //Alice --salt $(date +%s) --execute --url ws://54.89.90.13:9945`
        - Note: used default alice's account available in dev chain to deploy and pay the gas fee. Alice Account is already prefunded
        - Above command deploys contract on local running dev chain, if no --url flag is mentioned and returns as follows:
        ```
        Code hash 0x55c024762587c9e35117641fb6bd3f9f50c5cfc1038a4b9e8a23c4134e875574
        Contract 5FzSzfkW1CCfxPsw2wzQddDwLr8DeRzXBhobRyYfhYrtGfse                     // Contract ID
        ```
    5. Invoke Contract's Getter Function: `cargo contract call --contract 5FzSzfkW1CCfxPsw2wzQddDwLr8DeRzXBhobRyYfhYrtGfse --message get --suri //Alice --url ws://54.89.90.13:9945`
    6. Invoke Contract's Setter Function: `cargo contract call --contract 5FzSzfkW1CCfxPsw2wzQddDwLr8DeRzXBhobRyYfhYrtGfse --message flip --suri //Alice --execute --gas 7983333376  --proof-size 262144 --url ws://54.89.90.13:9945`
    7. Invoke Contract's Getter Function on Node 2: `cargo contract call --contract 5FzSzfkW1CCfxPsw2wzQddDwLr8DeRzXBhobRyYfhYrtGfse --message get --suri //Alice --url ws://54.198.203.189:9945`
    8. Invoke Contract's Setter Function on Node 2: `cargo contract call --contract 5FzSzfkW1CCfxPsw2wzQddDwLr8DeRzXBhobRyYfhYrtGfse --message flip --suri //Alice --execute --gas 7983333376  --proof-size 262144 --url ws://54.198.203.189:9945`
    9. Invoke Contract's Getter Function using non-funded Custom Account: `cargo contract call --contract 5FzSzfkW1CCfxPsw2wzQddDwLr8DeRzXBhobRyYfhYrtGfse --message get --suri "column follow fine steel mosquito tuition gaze spare join area release bitter" --url ws://54.89.90.13:9945`
    10. Invoke Contract's Setter Function using funded Custom Account: `cargo contract call --contract 5FzSzfkW1CCfxPsw2wzQddDwLr8DeRzXBhobRyYfhYrtGfse --message flip --suri "tide front tattoo nerve kingdom resist organ recipe chicken chimney area then" --password 12345678 --execute --gas 7983333376  --proof-size 262144 --url ws://54.89.90.13:9945`

## Next: Setting up Multi Node environment
Steps Involved:
1. Purge Existing Chains, if you want to upgrade the chain, purging is not necessary.
2. Generate AURA and GRANDPA Keys
3. Update Custom Chain Specification accordingly with updated keys # In current repository, we've already pushed an updated chainSpec.json | To generate: `./target/release/node-template build-spec --disable-default-bootnode --chain local > customSpec.json` then `./target/release/node-template build-spec --chain=customSpec.json --raw --disable-default-bootnode > customSpecRaw.json`
4. Spin Nodes

### Purge Any Existing Chain, if any: 
`./target/release/node-template purge-chain --base-path /tmp/alice --chain local`

### Steps to generate a Key 1
1. Generate Key for Aura (--scheme Sr25519): `./target/release/node-template key generate --scheme Sr25519 --password-interactive`
- Add Random Key password: `12345678`
- Generated Aura Key should look like this below:
```
Secret phrase:       very museum phone decade snack design lock throw brother fly dwarf great
  Network ID:        substrate
  Secret seed:       0xbe9f179926a539cd0e27400f09b3f902826e30d9ef64e0675682c81a4344c616
  Public key (hex):  0x00fb3eb89b326db889521f202fd81e20ba85e755c03ce02b6649c1d1cf15aa6d
  Account ID:        0x00fb3eb89b326db889521f202fd81e20ba85e755c03ce02b6649c1d1cf15aa6d
  Public key (SS58): 5C5zVX5WH5PoHAPR27xus3CvvUVo6egT1VRs2NGZMYRe2o2s
  SS58 Address:      5C5zVX5WH5PoHAPR27xus3CvvUVo6egT1VRs2NGZMYRe2o2s
```
2. Generate Key for Grandpa (--scheme Ed25519): `./target/release/node-template key inspect --password-interactive --scheme Ed25519 "very museum phone decade snack design lock throw brother fly dwarf great"`
- Add Random Key password:  `12345678`
- Generated Grandpa Key should look like this below:
```
Secret phrase:       very museum phone decade snack design lock throw brother fly dwarf great
  Network ID:        substrate
  Secret seed:       0xbe9f179926a539cd0e27400f09b3f902826e30d9ef64e0675682c81a4344c616
  Public key (hex):  0xf434ac5bff2bd59b76b11f3e408d9019c1fe8aaaced3224ff45fd2969f427c01
  Account ID:        0xf434ac5bff2bd59b76b11f3e408d9019c1fe8aaaced3224ff45fd2969f427c01
  Public key (SS58): 5HauBsZXjaRfBDmotWorrEh15W2mGB7c33H7o7mHdCfZGvDf
  SS58 Address:      5HauBsZXjaRfBDmotWorrEh15W2mGB7c33H7o7mHdCfZGvDf
```

### Steps to generate a Key 2
1. Generate Key for Aura (--scheme Sr25519): `./target/release/node-template key generate --scheme Sr25519 --password-interactive`
- Add Random Key password: `12345678`
- Generated Aura Key should look like this below:
```
Secret phrase:       tide front tattoo nerve kingdom resist organ recipe chicken chimney area then
  Network ID:        substrate
  Secret seed:       0x1d78c2e3243ba2a497dabf1febc9f8a3e60527b5f3857e438864fca4cd568727
  Public key (hex):  0x5c6bc578b45d3c3ff32b2abb7ec5f6e568526ac04a574e87fd795464fe17b104
  Account ID:        0x5c6bc578b45d3c3ff32b2abb7ec5f6e568526ac04a574e87fd795464fe17b104
  Public key (SS58): 5E9tH3DfTK4ocWWvM87N54c3wDzGdh496cRgFAenKvWzrHzz
  SS58 Address:      5E9tH3DfTK4ocWWvM87N54c3wDzGdh496cRgFAenKvWzrHzz
```
2. Generate Key for Grandpa (--scheme Ed25519): `./target/release/node-template key inspect --password-interactive --scheme Ed25519 "tide front tattoo nerve kingdom resist organ recipe chicken chimney area then"`
- Add Random Key password:  `12345678`
- Generated Grandpa Key should look like this below:
```
Secret phrase:       tide front tattoo nerve kingdom resist organ recipe chicken chimney area then
  Network ID:        substrate
  Secret seed:       0x1d78c2e3243ba2a497dabf1febc9f8a3e60527b5f3857e438864fca4cd568727
  Public key (hex):  0xb5be7c5872c6e3f45d0f954a614ccc192e886ec6d6697704fb47a4ff18ec0165
  Account ID:        0xb5be7c5872c6e3f45d0f954a614ccc192e886ec6d6697704fb47a4ff18ec0165
  Public key (SS58): 5GB17MYVuVxtirTXerTR6QCvQaVBkes6cgQRUgJWywY4uVhP
  SS58 Address:      5GB17MYVuVxtirTXerTR6QCvQaVBkes6cgQRUgJWywY4uVhP
```

### Steps to generate a Key 3
1. Generate Key for Aura (--scheme Sr25519): `./target/release/node-template key generate --scheme Sr25519 --password-interactive`
- Add Random Key password: `12345678`
- Generated Aura Key should look like this below:
```
Secret phrase:       taste seek proof milk scene trumpet account run toilet absorb elegant bullet
  Network ID:        substrate
  Secret seed:       0x44cbfbce4393330fc1da26adf96dc9d54b62aaeba4749925e1e8d43dcf7c5c2f
  Public key (hex):  0x445de49b6c60338c106c2030664dd688b34d6716a00603ebbca12b8560269e2d
  Account ID:        0x445de49b6c60338c106c2030664dd688b34d6716a00603ebbca12b8560269e2d
  Public key (SS58): 5DcM1GJgqKnDKR9kRSDWrdm5Dd6rPDCvuHjcKyasWskiKvRa
  SS58 Address:      5DcM1GJgqKnDKR9kRSDWrdm5Dd6rPDCvuHjcKyasWskiKvRa
```
2. Generate Key for Grandpa (--scheme Ed25519): `./target/release/node-template key inspect --password-interactive --scheme Ed25519 "taste seek proof milk scene trumpet account run toilet absorb elegant bullet"`
- Add Random Key password:  `12345678`
- Generated Grandpa Key should look like this below:
```
Secret phrase:       taste seek proof milk scene trumpet account run toilet absorb elegant bullet
  Network ID:        substrate
  Secret seed:       0x44cbfbce4393330fc1da26adf96dc9d54b62aaeba4749925e1e8d43dcf7c5c2f
  Public key (hex):  0x8619203fea5cead62be3c7cba701ccc3d7bf4a932c093bfa84e8ea67f7ef6845
  Account ID:        0x8619203fea5cead62be3c7cba701ccc3d7bf4a932c093bfa84e8ea67f7ef6845
  Public key (SS58): 5F6XjjpkuyxUnUH3W45VQM6rgo4BcrBrJAi3uwjQCHFFWRCK
  SS58 Address:      5F6XjjpkuyxUnUH3W45VQM6rgo4BcrBrJAi3uwjQCHFFWRCK
```
### Aura Node Addresses
- Node 1: 5C5zVX5WH5PoHAPR27xus3CvvUVo6egT1VRs2NGZMYRe2o2s
- Node 2: 5E9tH3DfTK4ocWWvM87N54c3wDzGdh496cRgFAenKvWzrHzz
- Node 3: 5DcM1GJgqKnDKR9kRSDWrdm5Dd6rPDCvuHjcKyasWskiKvRa
### Grandpa Node Addresses
- Node 1: 5HauBsZXjaRfBDmotWorrEh15W2mGB7c33H7o7mHdCfZGvDf
- Node 2: 5GB17MYVuVxtirTXerTR6QCvQaVBkes6cgQRUgJWywY4uVhP
- Node 3: 5F6XjjpkuyxUnUH3W45VQM6rgo4BcrBrJAi3uwjQCHFFWRCK

### Notes
- Below we'll be spinning 3 nodes on 3 different machines, therefore, we'll be using same PORT WSPORT & RPCPORT across all 3 nodes. In case we need to run 3 instances on same machine, do change ports accordingly.
### Spin Node 1:
  - With Built-in Account: ALICE
    ```
    ./target/release/node-template \
    --base-path /tmp/alice \
    --chain local \
    --alice \
    --port 30333 \
    --ws-port 9945 \
    --rpc-port 9933 \
    --node-key 0000000000000000000000000000000000000000000000000000000000000001 \
    --telemetry-url "wss://telemetry.polkadot.io/submit/ 0" \
    --validator
    ```
  - With Custom Account using Custom Chain Specification
    ```
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
    ```
      - Node Identity: 12D3KooWR93KVfCTyzXqdXY5bWMP4wCQawTFMR4zKNWZhMTrgFAc
      - Add keys to the keystore; aura authority keys to enable block production; grandpa authority keys to enable block finalization.
      ```
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
       ```
      - Verify that your keys are in the keystore for node: `ls /tmp/node01/chains/local_testnet/keystore`
      - close (ctrl+c) and Restart the chain referring "With Custom Account using Custom Chain Specification"

### Spin Node 2:
  - With Built-in Account: BOB
    ```
    ./target/release/node-template \
    --base-path /tmp/bob \
    --chain local \
    --bob \
    --port 30333 \
    --ws-port 9945 \
    --rpc-port 9933 \
    --node-key 0000000000000000000000000000000000000000000000000000000000000001 \
    --telemetry-url "wss://telemetry.polkadot.io/submit/ 0" \
    --validator
    ```
  - With Custom Account using Custom Chain Specification
    ```
    ./target/release/node-template \
    --base-path /tmp/node02 \
    --chain ./customSpecRaw.json \
    --port 30333 \
    --ws-port 9945 \
    --rpc-port 9933 \
    --telemetry-url "wss://telemetry.polkadot.io/submit/ 0" \
    --validator \
    --rpc-methods Unsafe \
    --name Node02 \
    --bootnodes /ip4/54.89.90.13/tcp/30333/p2p/12D3KooWR93KVfCTyzXqdXY5bWMP4wCQawTFMR4zKNWZhMTrgFAc \
    --password-interactive \
    --ws-external \
    --rpc-external \
    --rpc-cors all 
    ```
      - Node Identity: 12D3KooWSZGo2YCoFoed7fm9YgJXmH7a1MzRB8uCJhPLxwH6utyx
      - Add keys to the keystore; aura authority keys to enable block production; grandpa authority keys to enable block finalization.
      ```
      ./target/release/node-template key insert --base-path /tmp/node02 \
        --chain customSpecRaw.json \
        --scheme Sr25519 \
        --suri "tide front tattoo nerve kingdom resist organ recipe chicken chimney area then" \
        --password-interactive \
        --key-type aura

      ./target/release/node-template key insert \
        --base-path /tmp/node02 \
        --chain customSpecRaw.json \
        --scheme Ed25519 \
        --suri "tide front tattoo nerve kingdom resist organ recipe chicken chimney area then" \
        --password-interactive \
        --key-type gran
       ```
      - Verify that your keys are in the keystore for node: `ls /tmp/node02/chains/local_testnet/keystore`
      - close (ctrl+c) and Restart the chain referring "With Custom Account using Custom Chain Specification"

### Spin Node 3:
  - With Built-in Account: CHARLIE
    ```
    ./target/release/node-template \
    --base-path /tmp/charlie \
    --chain local \
    --charlie \
    --port 30333 \
    --ws-port 9945 \
    --rpc-port 9933 \
    --node-key 0000000000000000000000000000000000000000000000000000000000000001 \
    --telemetry-url "wss://telemetry.polkadot.io/submit/ 0" \
    --validator
    ```
  - With Custom Account using Custom Chain Specification
    ```
    ./target/release/node-template \
    --base-path /tmp/node03 \
    --chain ./customSpecRaw.json \
    --port 30333 \
    --ws-port 9945 \
    --rpc-port 9933 \
    --telemetry-url "wss://telemetry.polkadot.io/submit/ 0" \
    --validator \
    --rpc-methods Unsafe \
    --name Node03 \
    --bootnodes /ip4/54.89.90.13/tcp/30333/p2p/12D3KooWR93KVfCTyzXqdXY5bWMP4wCQawTFMR4zKNWZhMTrgFAc \
    --password-interactive \
    --ws-external \
    --rpc-external \
    --rpc-cors all 
    ```
      - Node Identity: 12D3KooWCiSnReUkxzkdrXZ7zQYgB6MqQooxsPeT7yyzhkDuyZa5
      - Add keys to the keystore; aura authority keys to enable block production; grandpa authority keys to enable block finalization.
      ```
      ./target/release/node-template key insert --base-path /tmp/node03 \
        --chain customSpecRaw.json \
        --scheme Sr25519 \
        --suri "taste seek proof milk scene trumpet account run toilet absorb elegant bullet" \
        --password-interactive \
        --key-type aura

      ./target/release/node-template key insert \
        --base-path /tmp/node03 \
        --chain customSpecRaw.json \
        --scheme Ed25519 \
        --suri "taste seek proof milk scene trumpet account run toilet absorb elegant bullet" \
        --password-interactive \
        --key-type gran
       ```
      - Verify that your keys are in the keystore for node: `ls /tmp/node03/chains/local_testnet/keystore`
      - close (ctrl+c) and Restart the chain referring "With Custom Account using Custom Chain Specification"

### Notes
  - you should see the same genesis block and state root hashes.
  - state root hash: 0x2dd7046e55d09c05af2c4126f3a5715f2d5fa808a553548bab5a1a97f4babb02
  - Genesis block/state (state: 0x2dd7046e55d09c05af2c4126f3a5715f2d5fa808a553548bab5a1a97f4babb02, header-hash: 0x2dd7…bb02)

### Substrate Predefined Accounts
```
Alice
Key type  Key value
Node key  c12b6d18942f5ee8528c8e2baf4e147b5c5c18710926ea492d09cbd9f6c9f82a
Peer identifier generated from the node key 12D3KooWBmAwcd4PJNJvfV89HwE48nwkRmAgo8Vy3uQEyNNHBox2
Peer identifier decoded to hex  0x0024080112201ce5f00ef6e89374afb625f1ae4c1546d31234e87e3c3f51a62b91dd6bfa57df

Bob
Key type  Key value
Node key  6ce3be907dbcabf20a9a5a60a712b4256a54196000a8ed4050d352bc113f8c58
Peer identifier generated from the node key 12D3KooWQYV9dGMFoRzNStwpXztXaBUjtPqi6aU76ZgUriHhKust
Peer identifier decoded to hex  0x002408011220dacde7714d8551f674b8bb4b54239383c76a2b286fa436e93b2b7eb226bf4de7

Charlie
Key type  Key value
Node key  3a9d5b35b9fb4c42aafadeca046f6bf56107bd2579687f069b42646684b94d9e
Peer identifier generated from the node key 12D3KooWJvyP3VJYymTqG7eH4PM5rN4T2agk5cdNCfNymAqwqcvZ
Peer identifier decoded to hex  0x002408011220876a7b4984f98006dc8d666e28b60de307309835d775e7755cc770328cdacf2e

Dave
Key type  Key value
Node key  a99331ff4f0e0a0434a6263da0a5823ea3afcfffe590c9f3014e6cf620f2b19a
Peer identifier generated from the node key 12D3KooWPHWFrfaJzxPnqnAYAoRUyAHHKqACmEycGTVmeVhQYuZN
Peer identifier decoded to hex  0x002408011220c81bc1d7057a1511eb9496f056f6f53cdfe0e14c8bd5ffca47c70a8d76c1326d

```

### Pre funded accounts in dev/local chain
```
				vec![
					get_account_id_from_seed::<sr25519::Public>("Alice"),
					get_account_id_from_seed::<sr25519::Public>("Bob"),
					get_account_id_from_seed::<sr25519::Public>("Charlie"),
					get_account_id_from_seed::<sr25519::Public>("Dave"),
					get_account_id_from_seed::<sr25519::Public>("Eve"),
					get_account_id_from_seed::<sr25519::Public>("Ferdie"),
					get_account_id_from_seed::<sr25519::Public>("Alice//stash"),
					get_account_id_from_seed::<sr25519::Public>("Bob//stash"),
					get_account_id_from_seed::<sr25519::Public>("Charlie//stash"),
					get_account_id_from_seed::<sr25519::Public>("Dave//stash"),
					get_account_id_from_seed::<sr25519::Public>("Eve//stash"),
					get_account_id_from_seed::<sr25519::Public>("Ferdie//stash"),
				],
```

`./target/release/node-template key inspect //Alice`
```
Secret Key URI `//Alice` is account:
  Network ID:        substrate 
 Secret seed:       0xe5be9a5092b81bca64be81d212e7f2f9eba183bb7a90954f7b76361f6edb5c0a
  Public key (hex):  0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d
  Account ID:        0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d
  Public key (SS58): 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY
  SS58 Address:      5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY

Secret Key URI `//Bob` is account:
  Network ID:        substrate 
 Secret seed:       0x398f0c28f98885e046333d4a41c19cee4c37368a9832c6502f6cfd182e2aef89
  Public key (hex):  0x8eaf04151687736326c9fea17e25fc5287613693c912909cb226aa4794f26a48
  Account ID:        0x8eaf04151687736326c9fea17e25fc5287613693c912909cb226aa4794f26a48
  Public key (SS58): 5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty
  SS58 Address:      5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty

Secret Key URI `//Charlie` is account:
  Network ID:        substrate 
 Secret seed:       0xbc1ede780f784bb6991a585e4f6e61522c14e1cae6ad0895fb57b9a205a8f938
  Public key (hex):  0x90b5ab205c6974c9ea841be688864633dc9ca8a357843eeacf2314649965fe22
  Account ID:        0x90b5ab205c6974c9ea841be688864633dc9ca8a357843eeacf2314649965fe22
  Public key (SS58): 5FLSigC9HGRKVhB9FiEo4Y3koPsNmBmLJbpXg2mp1hXcS59Y
  SS58 Address:      5FLSigC9HGRKVhB9FiEo4Y3koPsNmBmLJbpXg2mp1hXcS59Y

Secret Key URI `//Dave` is account:
  Network ID:        substrate 
 Secret seed:       0x868020ae0687dda7d57565093a69090211449845a7e11453612800b663307246
  Public key (hex):  0x306721211d5404bd9da88e0204360a1a9ab8b87c66c1bc2fcdd37f3c2222cc20
  Account ID:        0x306721211d5404bd9da88e0204360a1a9ab8b87c66c1bc2fcdd37f3c2222cc20
  Public key (SS58): 5DAAnrj7VHTznn2AWBemMuyBwZWs6FNFjdyVXUeYum3PTXFy
  SS58 Address:      5DAAnrj7VHTznn2AWBemMuyBwZWs6FNFjdyVXUeYum3PTXFy

Secret Key URI `//Eve` is account:
  Network ID:        substrate 
 Secret seed:       0x786ad0e2df456fe43dd1f91ebca22e235bc162e0bb8d53c633e8c85b2af68b7a
  Public key (hex):  0xe659a7a1628cdd93febc04a4e0646ea20e9f5f0ce097d9a05290d4a9e054df4e
  Account ID:        0xe659a7a1628cdd93febc04a4e0646ea20e9f5f0ce097d9a05290d4a9e054df4e
  Public key (SS58): 5HGjWAeFDfFCWPsjFQdVV2Msvz2XtMktvgocEZcCj68kUMaw
  SS58 Address:      5HGjWAeFDfFCWPsjFQdVV2Msvz2XtMktvgocEZcCj68kUMaw

Secret Key URI `//Ferdie` is account:
  Network ID:        substrate 
 Secret seed:       0x42438b7883391c05512a938e36c2df0131e088b3756d6aa7a755fbff19d2f842
  Public key (hex):  0x1cbd2d43530a44705ad088af313e18f80b53ef16b36177cd4b77b846f2a5f07c
  Account ID:        0x1cbd2d43530a44705ad088af313e18f80b53ef16b36177cd4b77b846f2a5f07c
  Public key (SS58): 5CiPPseXPECbkjWCa6MnjNokrgYjMqmKndv2rSnekmSK2DjL
  SS58 Address:      5CiPPseXPECbkjWCa6MnjNokrgYjMqmKndv2rSnekmSK2DjL
```

### Random Substrate Accounts
`tray over muffin monster decline labor dream math kidney find task turkey`
```
Key Password: 12345678
Secret phrase:       column follow fine steel mosquito tuition gaze spare join area release bitter
  Network ID:        substrate
  Secret seed:       0xd8e441dadad4ffe91fffdbad9afb4937546d8855323c332ab744b00c5bb50b64
  Public key (hex):  0x8cb1536d3b6a53834cd554f4697002e309ef964dd7d410a9d3c63c50e69d202a
  Account ID:        0x8cb1536d3b6a53834cd554f4697002e309ef964dd7d410a9d3c63c50e69d202a
  Public key (SS58): 5FFBEkFFGyWCC1pyAw4MqrgkdLU8UzBB8SLV4HZEWXcDo6M8
  SS58 Address:      5FFBEkFFGyWCC1pyAw4MqrgkdLU8UzBB8SLV4HZEWXcDo6M8
```
### susbstrate permissioned network with node-authorization-pallete (Not Implemented)
// kept for reference purposes
```
Spin Validator 1: // Local Node Identity: 12D3KooWBmAwcd4PJNJvfV89HwE48nwkRmAgo8Vy3uQEyNNHBox2 // 9944
./target/release/node-template \
--chain=local \
--base-path /tmp/validator1 \
--alice \
--node-key=c12b6d18942f5ee8528c8e2baf4e147b5c5c18710926ea492d09cbd9f6c9f82a \
--port 30333 \
--ws-port 9944

Spin Validator 2:  // Local Node Identity: 12D3KooWQYV9dGMFoRzNStwpXztXaBUjtPqi6aU76ZgUriHhKust //9945
./target/release/node-template \
--chain=local \
--base-path /tmp/validator2 \
--bob \
--node-key=6ce3be907dbcabf20a9a5a60a712b4256a54196000a8ed4050d352bc113f8c58 \
--bootnodes /ip4/127.0.0.1/tcp/30333/p2p/12D3KooWBmAwcd4PJNJvfV89HwE48nwkRmAgo8Vy3uQEyNNHBox2 \
--port 30334 \
--ws-port 9945

Add a third node to the list of well-known nodes // Local Node Identity: 12D3KooWJvyP3VJYymTqG7eH4PM5rN4T2agk5cdNCfNymAqwqcvZ //9946
./target/release/node-template \
--chain=local \
--base-path /tmp/validator3 \
--name charlie  \
--node-key=3a9d5b35b9fb4c42aafadeca046f6bf56107bd2579687f069b42646684b94d9e \
--port 30335 \
--ws-port=9946 \
--offchain-worker always

Authorize access for the third node

Allow connections from a sub-node

Claim the sub-node

Start the sub-node

Allow connections to the sub-node
```