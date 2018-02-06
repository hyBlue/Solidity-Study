pragma solidity ^0.4.0;

contract Assembly{


  function nativeLoops() public returns (uint _r){
    for(uint i = 0; i < 10; i ++){
      _r++;
    }
  }

  // inline assebly 로 loop 구현
  function asmLoops() public returns (uint _r){
    // inline assebly 로 구현한 것들은 gas cost가 낮기 때문에 어셈블리 코드를 이해하는 것이 매우 중요.
    assembly {
      //assign an integer
      let i := 0 // assembly 에서 assingment 는 :=, assembly 레벨에서 모든 변수는 integer다.

      loop: // label
      i := add(i, 1) // i = i + 1
      _r := add(_r, 1)
      jumpi(loop, lt(i, 10)) //jump 는 그냥 jump. jumpi 는 conditional jump. i = if
      // lt : i is less than 10.
      // i 가 10 보다 작으면 loop로 간다.

    }
  }
  // native loops : gas cost 999, asmLoops : gas cost 702 => inline assembly 가 가스 소모량 적음.




  function nativeConditional(uint _v) public returns (uint) {
    if (5 == _v){
      return 55;
    } else if ( 6 == _v) {
      return 66;
    }
    return 11;
  }

  function asmConditional(uint _v) public returns (uint _r) {
    //return method  는 좀 다르다.

    //case statement 는 solidity에는 없고 assembly에서만 존재
    assembly {
      switch _v  // switch 문. v가 5인지 6인지
      case 5{
        _r := 55
      }
      case 6{
        _r := 66
      }
      default{
        _r := 11
      }
    }
  }
  //gas cost native : 295, asm : 285


  //assembly 에서의 return statement 는 메모리에 대한 포인터이다. 그래서 우리는 return하기 전에 메모리에 먼저 할당해야 됨.
  // mstore, msize
  function asmReturns() public returns (uint _v) {
    assembly {
      /* stack의 가장 위에 할당하기 위해 mstore, msize, 사용 */

      //현재 메모리의 최대 크기이자 가장 큰 접근 accessed memory index.
      let _ptr := add(msize(), 1) // 존재하는 블럭에 덮어쓰는게 아니라 새로 할당하기 위하여 주소를 + 1 한 것.
      mstore(_ptr, _v) // _v를 메모리 _ptr 에 저장
      return(_ptr, 0x20 ) // _ptr 주소부터 몇 bytes를 리턴할지 결정해야됨, 우리는 uint를 return으로 했기 때문에 256 - bits = 32bytes. 0x20 : 32
      }
  }
}
