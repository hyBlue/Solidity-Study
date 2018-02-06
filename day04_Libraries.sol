pragma solidity ^0.4.0;

import "browser/day4_library.sol";

contract Testlibrary {
  using IntExtended for uint; // uint 자료형 안에 IntExtended의 모든 함수 존재.
 // using IntExtended for *; : string 같은 모든 data type에 적용 가능.
  function testIncrement(uint _base) returns (uint){
    return _base.increment(); // IntExtended.increment(_base)로 써도 됨.
    // _base는 increment의 첫번째 인자로 들어감.
  }

  function testDecremnt(uint _base) returns (uint){
    return _base.decrement();
  }

  function testIncrementByValue(uint _base, uint _value) returns (uint){
    return _base.incrementByValue(_value);
  }

  function testDecremntByValue(uint _base, uint _value) returns (uint){
    return _base.decrementByValue(_value);
  }
}
