// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import  "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract veToken is ERC20 {
    uint256 private _totalSupply;

   constructor(uint256 initialSupply) ERC20("veToken", "veT") {
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}
