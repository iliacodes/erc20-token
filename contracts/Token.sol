// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Token {
    // token variables
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public totalSupply;

    // Track balances
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // Events - fire events on state changes
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value
        );

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
        );

    constructor (
        string memory _name,
        string memory _symbol,
        uint _decimals,
        uint _totalSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        balanceOf[msg.sender] = totalSupply;
    }

    // transfer amount of tokens to an address
    // _to receiver address
    // _value amount value of token to send
    // return true if successful
    function transfer(address _to, uint256 _value) external returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] = balanceOf[msg.sender] - (_value);
        balanceOf[_to] = balanceOf[_to] + (_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // internal helper function with required safety checks
    // _from sender address
    // _to receiver address
    // _value amount value of token to send
    // Emit Transfer event
    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != address(0));
        balanceOf[_from] = balanceOf[_from] - (_value);
        balanceOf[_to] = balanceOf[_to] + (_value);
        emit Transfer(_from, _to, _value);
    }

    // approve other to spend on your behalf
    // _spender allowed to spend and a max allowed to spend
    // amount value of teoken to send
    // return true if successful
    // emit the approval event
    function approve(address _spender, uint256 _value) external returns (bool) {
        require(_spender != address(0));
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // transfer by approved address from original address of an amuont of tokens
    // _from address sending to and the amount to send
    // _to receiver address
    // _value amount value of token to send
    // interna; helper function with required safety checks
    // return true if successful
    // allow _spender to spend up to the _value on yoru behalf
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool) {
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);
        allowance[_from][msg.sender] = allowance[_from][msg.sender] - (_value);
        _transfer(_from, _to, _value);
        return true;
    }
}
