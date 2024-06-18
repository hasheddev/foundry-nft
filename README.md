# Proveably Random Raffle contracts

## About
This is a simple nft project that:
- Uses ipfs or onchain storage for nft creation
- For onchain user can create a mood nft that can flip according to their mood
- Uses openzeppelin's ERC721

### Requirements
- git
- foundry
- make

### Gettig started

``` shell
git clone https://github.com/kdshola/foundry-nft.git
cd foundry-nft
make install
forge build
```

#### Help text

``` shell
make help
```
#### Spin up anvil node

``` shell
make anvil
```

#### Deploy contract to test network
For anvil deployment no use `make deploy`

#### Environment variables
- PRIVATE_KEY
- ETHERSCAN_API_KEY
- SEPOLIA_RPC_URL

``` shell
make deploy ARGS="--network sepolia"
```

#### Test contract

``` shell
make test