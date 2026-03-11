// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SafeBaseToken {

    string public constant name = "SafeBaseToken";
    string public constant symbol = "SBT";
    uint8 public constant decimals = 18;

    uint256 public immutable totalSupply;

    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from,address indexed to,uint256 value);

    constructor() {
        uint256 supply = 1000000 ether;
        totalSupply = supply;
        balanceOf[msg.sender] = supply;
        emit Transfer(address(0), msg.sender, supply);
    }

    function transfer(address to,uint256 value) external returns(bool) {
        require(balanceOf[msg.sender] >= value,"Balance low");

        unchecked {
            balanceOf[msg.sender] -= value;
            balanceOf[to] += value;
        }

        emit Transfer(msg.sender,to,value);
        return true;
    }
}
