# DegenToken

The `CustomToken` contract is a Solidity smart contract that implements a custom ERC20 token with additional functionalities such as a minter role, a whitelist for addresses, and pause functionality for token transfers. It extends several OpenZeppelin contract libraries to provide these features.

## Features

1. **ERC20 Implementation**: The contract is based on the ERC20 standard, providing basic token functionality like transferring, minting, and burning tokens.

2. **Minter Role**: The contract has a minter role that can be assigned to an address. Only the minter can mint new tokens to a specified address.

3. **Whitelist Functionality**: The contract allows the contract owner to manage a whitelist of addresses. Addresses in the whitelist are restricted from transferring tokens.

4. **Pause Functionality**: The contract owner has the ability to pause and unpause token transfers. When paused, transfers are temporarily disabled.

## Contract Structure

The `CustomToken` contract is structured as follows:

- **Import Statements**: The necessary OpenZeppelin libraries and the Hardhat console are imported.

- **Contract Definition**: The main contract is defined. It inherits from the `ERC20Burnable`, `Ownable`, and `Pausable` contracts.

- **State Variables**:
  - `minter`: The address with the minter role, responsible for minting new tokens.
  - `whitelist`: A mapping of addresses to their whitelist status.

- **Events**:
  - `MinterChanged`: Fired when the minter role is changed.
  - `WhitelistUpdated`: Fired when an address's whitelist status is updated.

- **Modifiers**:
  - `onlyMinter`: A modifier that restricts certain functions to be callable only by the minter.

- **Constructor**: Initializes the contract by minting an initial supply of tokens to the deployer and assigning the minter role and whitelist status to the deployer's address.

- **Public Functions**:
  - `changeMinter`: Allows the contract owner to change the address with the minter role.
  - `updateWhitelist`: Allows the contract owner to update the whitelist status of an address.
  - `mint`: Allows the minter to mint new tokens and assign them to a specified address.
  - `transfer`: Overrides the standard ERC20 transfer function with additional checks to prevent transfers from whitelisted addresses.
  - `redeem`: Allows an address to redeem (burn) a specific amount of tokens.
  - `balanceOf`: Retrieves the balance of tokens held by a specific address.
  - `burn`: Allows the contract owner to burn a specific amount of tokens from an address.
  - `pause`: Pauses all token transfers, can only be called by the contract owner.
  - `unpause`: Unpauses token transfers, can only be called by the contract owner.

## Getting Started

To deploy and interact with the `CustomToken` contract, you can follow these steps:

1. Deploy the contract using a Solidity development environment like Remix or Hardhat.
2. After deployment, the deployer will become the initial minter and will have the ability to mint tokens.
3. The contract owner can update the minter, manage the whitelist, and pause/unpause token transfers.
4. Addresses in the whitelist cannot transfer tokens while the contract is unpaused.
5. Use the provided functions to interact with the contract, such as transferring tokens, minting new tokens, and burning tokens.

## Note

This README provides an overview of the `CustomToken` contract and its functionalities. It's important to test the contract thoroughly in a development environment before deploying it to any mainnet or production network. Make sure to understand the implications of the functions and roles defined in the contract.

## Credits
This project is created by ***[Khushi Gupta](https://github.com/Khushi-1703)***.

## License
This project is licensed under the ***[MIT License](https://github.com/Khushi-1703/SmartContractManagement/blob/main/LICENSE)***.
