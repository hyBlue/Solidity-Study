pragma solidity ^0.4.0;

contract Transaction {

  event SenderLogger(address);
  event ValueLogger(uint);
//event : http://solidity.readthedocs.io/en/develop/contracts.html#events


//msg 변수들 정보
//http://solidity.readthedocs.io/en/develop/units-and-global-variables.html



  address private owner;

  modifier isOwner {
    require(owner == msg.sender);
    _;
  }

  modifier validValue{
    assert(msg.value >= 1 ether); // ether : 이더리움 단위
    _;
  }

  //constructor
  function Transaction(){
    owner = msg.sender;
  }

  //fallback function. 함수를 구체화할 필요 없음. 이 함수로 아무나 우리 contract 주소를 알고 있다면 이더리움을 전송할 수 있다.
  function () payable isOwner validValue {
    SenderLogger(msg.sender);
    ValueLogger(msg.value);
  }

}
