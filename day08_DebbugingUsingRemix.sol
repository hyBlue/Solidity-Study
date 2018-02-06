pragma solidity ^0.4.0;

contract Debugging{
  uint[] private vars;


  // 중요 : solidity locals, solidity stack
  /* stack : 메모리 assign 하기 전에 allocate 먼저 하고 그 다음 assign
  ex) assignment function : myVal1 allocate , myVal2 allocate, myVal1 assign, myVal2 assign */
  function asignment(){
    uint myVal1 = 1;
    uint myVal2 = 2;
    assert(myVal1 == myVal2);
  }



  function memoryAlloc(){
    string memory myString = "test";
    assert(bytes(myString).length == 10);
  }

  // storage 에 먼저 할당, 그 이후 push.
  // 처음에 storage에 저장되는 것은 배열의 크기.(1) 이후 2 push, 그리고 다시 크기가 2로 바뀌고 그다음 3 push.
  function storageAlloc(){
    vars.push(2);
    vars.push(3);
    assert(vars.length == 4);
  }
}

// 중요 : solidity locals, solidity stack
/* stack : 메모리 assign 하기 전에 allocate 먼저 하고 그 다음 assign
ex) assignment function : myVal1 allocate , myVal2 allocate, myVal1 assign, myVal2 assign */
