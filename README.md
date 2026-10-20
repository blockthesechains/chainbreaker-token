# Chainbreaker (CHBK)

An ERC-20 token built with Solidity, OpenZeppelin, and Hardhat 3, with a full Foundry-style test suite.

## Features

- Standard ERC-20 token (transfer, approve, allowance) via OpenZeppelin
- Initial supply minted to the deployer at launch
- Owner-only `mint` function using OpenZeppelin `Ownable`

## Tests

Written as Solidity tests with `forge-std`, run through Hardhat 3:

- Deployment: name, symbol, initial supply, and owner
- Transfers update balances correctly
- Owner can mint new tokens
- Non-owners are blocked from minting
- Transfers above a balance revert
- Fuzz test: transfers of random valid amounts (256 runs)

## Running locally

```shell
npm install
npx hardhat compile
npx hardhat test
```

## Tech

Solidity 0.8.x · OpenZeppelin Contracts · Hardhat 3 · forge-std