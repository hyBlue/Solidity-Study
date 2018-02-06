pragma solidity ^0.4.0;

contract DataTypes {

  bool myBool = false;

  int8 myInt; // int 뒤 숫자는 8로 나눌 수 있어야 함.int256(o) int245(x)
  // 8비트의 integer. -128 ~ 127
  uint8 myUint = 255;
  // 0~255

  /* string을 integer array에 저장. 아마 uint[]일 것 */
  string myString;
  uint8[] myStringArr;

  function myFunc(string s){ // uint8[]
    // array를 argument로 쓰는거랑 마찬가지, 그리고 nested  array는 지원 안하기에 string[]는 사용 불가.
  }

  byte myValue; // == bytes1
  bytes1 my
  bytes32 myBytes32; // btyes는 1~32까지 가능. integer랑 비슷.

  //fix point number. financial 에서는 floating point number을 사용하면 안됨. 부정확.
  fixed myFixed; / fixed integer value of 128 bits, 19 decimal places

  fixed256x8 myFiexed ; // 255.0
  ufixed myFixed = 1;


  enum Action {ADD, REMOVE, UPDATE}

  Action myAction = Action.ADD;


  address myAddress;

  function assignAddress() {
    myAddress = msg.sender; // address who interacts with the contract
    myAddress.balance;
    myAddress.transfer(10);
  }

  uint[] myIntArr = [1, 2, 3]; // fixed length 필요 없음.

  function arrFunc(){
    myIntArr.push(1); // array 에 append 가능. non definitive length
    myIntArr.length;
    myIntArr[0];
    
  }

  uint[10] myFixedArr; // definitive length;

  struct Account {
    uint balance = 0;
    uint dailyLimit;
  }

  Account myAccont; // struct 생성
  function structFunc(){
    myAccount.balance = 100;
  }

  mapping (address => Account) _accounts; // non-limited associative array

  function () payable {
    _accounts[msg.sender].balance += msg.value;

  }

  function getBalance() returns(uint) {
    return _accounts[msg.sender].balance;
  }
}
