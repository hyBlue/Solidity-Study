pragma solidity ^0.4.0;


interface Regulator{

  function checkValue(uint amount) returns (bool);
  function loan() returns (bool);
}


contract Bank is Regulator{
  uint internal myInternalValue;
  address private owner; // address : 이더리움 주소 data type, owner of the contract.
  uint private value;


  // This contract only defines a modifier but does not use
   // it: it will be used in derived contracts.
   // The function body is inserted where the special symbol
   // `_;` in the definition of a modifier appears.
   // This means that if the owner calls this function, the
   // function is executed and otherwise, an exception is
   // thrown.
  modifier ownerFunc {
    require(owner == msg.sender);
    _; // ownerfunc를 적용할 때 _; 실행 전에 require 문을 실행하라는 의미. 즉 requrie 앞에 하면 함수를 먼저 실행, require 뒤에 하면 require 먼저 실행. 맘대로.
    //require 쓴 이유 : error thowing


  }
  function Bank(uint amount){
    value = amount;
    owner = msg.sender;
  }
  //constructor 는 단 한번만 수행되기 때문에 owner 는 blockchain 안에 fixed.

//no one but the owner of the original contract can modify them : ownerFunc 뒤에 붙이면
// ownerFunc 앞에 internal or private 도 사용 가능 
  function deposit(uint amount) internal ownerFunc{
    value += amount;
  }

  function withdraw(uint amount) ownerFunc{
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

}


contract MyFirstContract is Bank(10) {

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

// ways to generate errors
//http://solidity.readthedocs.io/en/develop/control-structures.html?highlight=revert#error-handling-assert-require-revert-and-exceptions
contract TestThorws {
  function testAssert(){
    assert(false); // boolean 넣어서 false면 에러
  }
  function testRequire(){
    require(2 == 1);

  }
  function testRevert(){
    revert();
  }
  function testThorw(){
    throw;
  }
}
