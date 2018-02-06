pragma solidity ^0.4.0; // compile version

contract MyFirstContract {
    //contract instance 는 이더리움 블록체인 상에 저장

    string private name;
    /* solidity에서는 변수를 private으로 만들 때 string private name 이런식으로 string 다음에 씀.  */
    uint private age;
    /* unsinged integer */

    function setName(string newName) {
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
