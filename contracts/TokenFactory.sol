// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenFactory is Ownable {
    uint256 public constant FEE = 10 * 1e18; 

    
    event TokenCreated(
        address indexed creator, 
        address tokenAddress, 
        string name, 
        string symbol, 
        uint256 initialSupply
    );

    
    constructor() Ownable(msg.sender) {}

    
    function createToken(
        string memory name, 
        string memory symbol, 
        uint256 initialSupply
    ) external payable {
        require(msg.value == FEE, "Insufficient fee amount");

        
        ERC20Token newToken = new ERC20Token(name, symbol, initialSupply, msg.sender);
        
        emit TokenCreated(msg.sender, address(newToken), name, symbol, initialSupply);
    }

    
    function withdraw() external onlyOwner {
    uint256 contractBalance = address(this).balance; 
    require(contractBalance > 0, "No funds to withdraw");
    payable(owner()).transfer(contractBalance); 
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
        Ownable(tokenCreator) // Pass the tokenCreator as the owner of the token
    {
        _mint(tokenCreator, initialSupply); 
    }
}
