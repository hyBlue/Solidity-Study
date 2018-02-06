pragma solidity ^0.4.0;

/* solidity 의 상속은 3가지.
1. general extenson of functionality from one contract into to the next. */
/* solidity에서는 상속을 is 사용 */

interface Regulator{

  function checkValue(uint amount) returns (bool);
  function loan() returns (bool);
    // abstract method
}


contract Bank is Regulator{
  uint internal myInternalValue;
  // protected variable. mfc에서는 접근 가능 but 다른데선 불가
  // public private internal -> solidity

  uint private value;

  //constructor 생성, contract와 same name
  function Bank(uint amount){
    value = amount;
  }

  function deposit(uint amount) {
    value += amount;
  }

  function withdraw(uint amount){
    if(checkValue(amount)){
    value -= amount;
  }
}

  function balance() returns(uint){
    return value;
  }
  function checkValue(uint amount) returns (bool){
    return amount >= value;
  }
  function loan() returns(bool){
    return value > 0;
}
  //abstract method 상속하여 구체화
}

  //amount = 10으로 초기화 하는 bank 상속
contract MyFirstContract is Bank(10) {
  // any functions in Bank will exist in mfc
    string private name;
    uint private age;

    function setName(string newName) {
      myInternalValue = 1;
      name = newName;
    }

    function getName() returns(string){
      return name;
    }

    function setAge(uint newAge){
      age = newAge;
    }

    function getAge() returns (uint){
      return age;
    }



}
