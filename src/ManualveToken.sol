// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract DeployveToken {
    mapping(address => uint256) public _balanceOf;
    string public name = "veToken";
    string public symbol = "ve";



 function totalSupply() public view virtual returns (uint256) {
    return 100 ether;
}

function balanceOf(address account) public view returns (uint256) {
    uint256 accountBalance;
    assembly {
        accountBalance := sload(add(_balanceOf.slot, account))
    }
    return accountBalance;
}
 
// function transferToken(address _to, uint256 _amount) private {
//  transfer(_to, _amount);
// }

// function Allowance(address _owner, address _spender) private {
//     allowance(_owner, _spender);
// }

// function ApproveAmount(address _spender, uint256 _amount) private {
//     approve(_spender, _amount);
// }

}