pragma solidity ^0.4.0;

// time-based events를 구현하는 방법은 두 가지.
/*
1. block times
2. 외부 소스의 trigger mechanism 이용
*/


contract TimeBased {

  mapping(address => uint) public _balanceOf;
  mapping(address => uint) public _expiryOf;

  uint private leaseTime = 600; // 10분


  modifier expire(address _addr) {
      // 강의에서 잘못 나온듯. 조건이 강좌 코드랑 반대여야됨.
      if (_expiryOf[_addr] < block.timestamp){ // 10분이 지났으면
        _expiryOf[_addr] = 0;
        _balanceOf[_addr] = 0;
      }
      _;
  }


  function lease()
    public
    payable
    expire(msg.sender)
    returns (bool) {
      require(msg.value == 1 ether);
      require(_balanceOf[msg.sender] == 0);
      _balanceOf[msg.sender] = 1;
      _expiryOf[msg.sender] = block.timestamp + leaseTime;
      return true;
    }

    function balanceOf()
    public returns (uint) {
      return balanceOf(msg.sender);
    }

    function balanceOf(address _addr)
      public expire(_addr) returns (uint){
        return _balanceOf[_addr];
      }

      function expiryOf(address _addr)
      public expire(_addr) returns (uint) {
        return _expiryOf[_addr];
      }
      function expiryOf()
      public returns (uint) {
        return expiryOf(msg.sender);
      }

}
