// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenFactory is Ownable {
    uint256 public fee = 10 * 1e18; // Initial fee (adjustable)
    uint256 public immutable MAX_INITIAL_SUPPLY = 1e30; 

    event TokenCreated(
        address indexed creator,
        address tokenAddress,
        string name,
        string symbol,
        uint256 initialSupply
    );

    constructor() Ownable (msg.sender) {}

    
    function createToken(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) external payable {
        require(msg.value == fee, "Insufficient fee amount");
        require(initialSupply <= MAX_INITIAL_SUPPLY, "Initial supply exceeds maximum allowed");

        
        ERC20Token newToken = new ERC20Token(name, symbol, initialSupply, msg.sender);

        
        emit TokenCreated(msg.sender, address(newToken), name, symbol, initialSupply);
    }

    
    function withdraw() external onlyOwner {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds to withdraw");
        payable(owner()).transfer(contractBalance);
    }

    
    function updateFee(uint256 newFee) external onlyOwner {
        require(newFee <= 100 * 1e18, "Fee exceeds the maximum limit"); 
        fee = newFee;
    }

    
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}


contract ERC20Token is ERC20, Ownable {
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply,
        address tokenCreator
    )
        ERC20(name, symbol)
        Ownable(tokenCreator) 
    {
        _mint(tokenCreator, initialSupply);
    }
}
