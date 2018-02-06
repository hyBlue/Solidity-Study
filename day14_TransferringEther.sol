pragma solidity ^0.4.0;

// 모든 주소가 contract를 갖고 있는 것은 아니다.
// fallback function : capture ehter transactions coming in to us
// ex) 이더를 컨트랙트에 보내고 싶을 때 어떤 특정한 함수를 호출하는 것이 아니라 단지 컨트랙트 주소를 입력하고 이더를 보내는 것이다.

contract EtherTransferTo{

  function () public payable {//parameter 필요 없다.
  } // 컨트랙트에 fallback 함수로 이더를 보냄

  function getBalance() public returns (uint) {
    // 특정 주소를 컨트랙트의 생성자로 보냄으로써 실제 컨트랙트 주소를 참조.


    return address(this).balance; // balance는 object에 원래 정의되어 있는 것.
     //this 혹은 잔고 확인이 필요한 다른 주소.
  }
}

// 다른 컨트랙트 주소에 이더를 보내는 것은 두 가지 방법이 있다.
/*
1. reference by the address directly : 그 주소의 함수들을 이용할 수 없다.
2.
*/
contract EtherTransferFrom{

  //1. transfer할 이더 주소를 우리 컨트랙트 안에 인스턴스로 생성하는 것.
  EtherTransferTo private _instance;

  function EtherTranferFrom() public {
    // _instance = EtherTransferTo(address(this));
    /* 단지 주소를 입력하는 것 만으로 new를 안쓰고도 인스턴스 참조 가능. 하지만 주석처리 한 이유는 this를 instance참조하여 EtherTransferFrom을 부르면 에러가 날 것. */
    _instance = new EtherTransferTo(); // 이것은 컨트랙트 주소가 될 것이다.
  }

  function getBalance() public returns(uint){
    return address(this).balance;
  }

  function getBalanceOfInstance() public returns (uint){
    //return address(_instance).balance;
    return _instance.getBalance();
  }

  function () public payable {
    //msg.sender.send(msg.value);
    address(_instance).send(msg.value); // EtehrTransferFrom에서 이더리움을 받자마자 바로 EtherTransferTo 컨트랙트로 보내는 함수.
  }
}
