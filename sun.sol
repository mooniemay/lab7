// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    address private owner;
    string public name = "SolarSystemToken";
    string public symbol = "SST";
    uint8 public decimals = 8;
    uint256 public totalSupply;
    uint256 public maxSupply = 1000000 * (10**decimals);

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 value);
    
    constructor() {
        owner = msg.sender;
    }
    
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address");
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(_value <= allowance[_from][msg.sender], "Allowance exceeded");
        
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    
    function mint(address to, uint256 value) public returns (bool success) {
        require(msg.sender == owner, "You are not owner");
        require(value*10**decimals <= maxSupply, "no money" );
        require(to != address(0), "Invalid address");
        maxSupply -= value*10**decimals;
        totalSupply += value*10**decimals;
        balanceOf[to] += value*10**decimals;
        emit Mint(to, value*10**decimals);
        return true;
    }
}
