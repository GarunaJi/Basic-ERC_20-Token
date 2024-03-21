// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.18;
//
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

//abstract is to avoid red lines
contract Block is IERC20{

  string public name="Block"; //name of the token
  string public symbol="BLK"; //symbol of the token
  uint public decimal=0; 
  address public founder;
  mapping(address=>uint) public balances; //information of balance of each address
  uint public totalSupply;

  mapping(address=>mapping(address=>uint)) allowed;
  
  constructor(){
     totalSupply=1000;
     founder=msg.sender;
     balances[founder]=totalSupply;
  }
  
  //balance of token of an account

  function balanceOf(address account) external view returns (uint256){
     return balances[account];
  }
  function transfer(address recipient, uint256 amount) external returns (bool){
     require(amount>0,"amount must be greater than zero");
     require(balances[msg.sender]>=amount,"Balance must be greater than zero");
     balances[msg.sender]-=amount;//balances[msg.sender]=balances[msg.sender]-amount
     balances[recipient]+=amount;
     emit Transfer(msg.sender, recipient, amount);
     return true;
  }
  
  function allowance(address owner, address spender) external view returns (uint256){
        return allowed[owner][spender];
  } 

  function approve(address spender, uint256 amount) external returns (bool){
        require(amount>0,"amount must be greater than zero");
        require(balances[msg.sender]>=amount,"Balance must be greater than zero");
        allowed[msg.sender][spender]=amount;
        emit Approval(msg.sender, spender, amount);
        return true;
  }
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool){
     require(allowed[sender][recipient]>=amount,"Recipient don't have authority to spend sender's token");
     require(balances[sender]>=amount,"Insufficient balance");
     balances[sender]-=amount;
     balances[recipient]+=amount;
     emit Transfer(msg.sender, recipient, amount);
     return true;
  }
  
}
