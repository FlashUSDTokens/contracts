# Flash USDTokens Contracts

![Flash USDT Logo](logo/20241226_023114_0000%20(1).png)

## Overview

Flash USDT is a secure, fast, and efficient token for interacting with the Tether ecosystem. Designed for developers, traders, and businesses seeking innovative USDT solutions.

- **Website:** [https://flashusdtokens.com/](https://flashusdtokens.com/)
- **Telegram:** [https://t.me/FlashUSDTokens](https://t.me/FlashUSDTokens)
- **BscScan Token:** [Flash USDT on BscScan](https://bscscan.com/token/0x98bd98dac99ed529dA00370621fa06b52084f4ed)

## Smart Contract: FlashUSDT

### Key Features

- **Auto-Burn Mechanism:** 2% of each transaction is burned.
- **Dynamic Fees:** 1% of each transaction goes to the fee wallet.
- **Admin Roles:** Decentralized admin roles for managing the contract.

### Contract Details

- **Name:** Flash USDT
- **Symbol:** $Tether
- **Decimals:** 18
- **Total Supply:** 100,000,000 $Tether

### Functions

- **transfer:** Transfers tokens to a specified address.
- **approve:** Approves a spender to use a specified amount of tokens.
- **transferFrom:** Transfers tokens from one address to another using an allowance.
- **mint:** Mints new tokens to a specified address (admin only).
- **burn:** Burns a specified amount of tokens from the sender's balance.

### Events

- **Transfer:** Emitted when tokens are transferred.
- **Approval:** Emitted when a spender is approved.
- **Mint:** Emitted when new tokens are minted.
- **Burn:** Emitted when tokens are burned.
- **FeeCollected:** Emitted when transaction fees are collected.
- **AdminAdded:** Emitted when a new admin is added.
- **AdminRemoved:** Emitted when an admin is removed.
- **TransferPaused:** Emitted when transfers are paused.
- **TransferUnpaused:** Emitted when transfers are unpaused.
- **MintPaused:** Emitted when minting is paused.
- **MintUnpaused:** Emitted when minting is unpaused.
- **BurnRateUpdated:** Emitted when the burn rate is updated.
- **FeeRateUpdated:** Emitted when the fee rate is updated.

## Repository Structure

- **FlashUSDT.sol:** Main smart contract for Flash USDT.
- **logo/20241226_023114_0000 (1).png:** Logo image for Flash USDTokens.

## Deployment

To deploy the Flash USDT contract, follow these steps:

1. Ensure you have a compatible Ethereum wallet (e.g., MetaMask).
2. Compile the `FlashUSDT.sol` contract using a Solidity compiler.
3. Deploy the contract to the Ethereum network, providing the fee wallet address as a constructor parameter.

## Usage

After deploying the contract, you can interact with it using any Ethereum-compatible wallet or dApp. Refer to the function descriptions above for details on how to transfer, approve, mint, and burn tokens.

## License

This project is licensed under the MIT License.
