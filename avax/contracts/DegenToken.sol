// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "hardhat/console.sol";

contract CustomToken is ERC20Burnable, Ownable, Pausable {
    using Address for address;

    address public minter;
    mapping(address => bool) public whitelist;

    event MinterChanged(address indexed previousMinter, address indexed newMinter);
    event WhitelistUpdated(address indexed account, bool isWhitelisted);

    modifier onlyMinter() {
        require(msg.sender == minter, "Only minter can call this");
        _;
    }

    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply * (10 ** decimals()));
        minter = msg.sender;
        whitelist[msg.sender] = true;
    }

    /**
     * @dev Change the address with minter role.
     * @param newMinter New address with minter role.
     */
    function changeMinter(address newMinter) public onlyOwner {
        emit MinterChanged(minter, newMinter);
        minter = newMinter;
    }

    /**
     * @dev Update the whitelist status of an account.
     * @param account Address to be updated.
     * @param isWhitelisted New whitelist status.
     */
    function updateWhitelist(address account, bool isWhitelisted) public onlyOwner {
        whitelist[account] = isWhitelisted;
        emit WhitelistUpdated(account, isWhitelisted);
    }

    /**
     * @dev Mint new tokens and assign them to the specified account.
     * @param account Address to receive the minted tokens.
     * @param amount Amount of tokens to mint.
     */
    function mint(address account, uint256 amount) public onlyMinter whenNotPaused {
        _mint(account, amount);
    }

    /**
     * @dev Transfer tokens from the sender to a recipient.
     * Overrides the standard ERC20 transfer function with additional checks.
     * @param recipient Address to receive the tokens.
     * @param amount Amount of tokens to transfer.
     * @return A boolean indicating whether the transfer was successful.
     */
    function transfer(address recipient, uint256 amount) public override whenNotPaused returns (bool) {
        require(recipient != address(0), "Transfer to zero address not allowed");
        require(!whitelist[_msgSender()], "Sender is whitelisted");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev Redeem (burn) a specific amount of tokens.
     * @param amount Amount of tokens to redeem (burn).
     */
    function redeem(uint256 amount) public whenNotPaused {
        _burn(msg.sender, amount);
    }

    /**
     * @dev Get the balance of tokens held by a specific account.
     * @param account Address to check the balance for.
     * @return The balance of tokens held by the account.
     */
    function balanceOf(address account) public view override returns (uint256) {
        return super.balanceOf(account);
    }

    /**
     * @dev Burn a specific amount of tokens from an account.
     * @param account Address to burn tokens from.
     * @param amount Amount of tokens to burn.
     */
    function burn(address account, uint256 amount) public onlyOwner whenNotPaused {
        _burn(account, amount);
    }

    /**
     * @dev Pause all token transfers.
     * Only the owner can call this function.
     */
    function pause() public onlyOwner {
        _pause();
    }

    /**
     * @dev Unpause token transfers.
     * Only the owner can call this function.
     */
    function unpause() public onlyOwner {
        _unpause();
    }
}
