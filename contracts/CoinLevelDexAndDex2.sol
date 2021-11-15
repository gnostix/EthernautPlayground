// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

 contract NaughtCoin is ERC20 {

  // string public constant name = 'NaughtCoin';
  // string public constant symbol = '0x0';
  // uint public constant decimals = 18;
  uint public timeLock = block.timestamp + 10 * 365 days;
  uint256 public INITIAL_SUPPLY;
  address public player;

  constructor() 
  ERC20('NaughtCoin', '0x0')
  {
    player = msg.sender;
    INITIAL_SUPPLY = 1000000; // * (10**uint256(decimals()));
    // _totalSupply = INITIAL_SUPPLY;
    // _balances[player] = INITIAL_SUPPLY;
    _mint(player, 10000);
    emit Transfer(address(0), player, 10000);
  }
  
  //0xe2b69b78bdfb82621549ff2d9472d05370491cd4 
  function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(spender, spender, amount);
        _approve(msg.sender, spender, amount);
        _approve(spender, msg.sender, amount);
        return true;
    }
    
  function transfer(address _to, uint256 _value) override public returns(bool) {
    super.transfer(_to, _value);
  }

  function transferFrom(address _from, address _to, uint256 _value) override public returns(bool) {
    super.transferFrom(_from, _to, _value);
  }
  
}