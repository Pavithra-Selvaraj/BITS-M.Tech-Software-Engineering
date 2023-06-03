// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract bank {

    mapping(address => uint256) private balances;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function deposit() payable public {
        balances[msg.sender] = balances[msg.sender] + msg.value;
    }

    function withdraw(uint256 _amount) payable public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender] - _amount;
        payable(msg.sender).transfer(_amount);
    }

    function transfer(address _to, uint256 _value) public {
        
        require(balances[msg.sender] >= _value);
        _transfer(msg.sender, _to, _value);
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != address(0));
        balances[_from] -= _value;
        balances[_to] += _value;
        payable(_to).transfer(_value);
    }

    function balance() view public returns (uint256) {
        return balances[msg.sender];
    }
}
