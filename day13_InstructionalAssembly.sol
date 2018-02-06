pragma solidity ^0.4.0;


// Instructional assembly의 유일한 장점은 디버거를 이용해 코드를 살펴볼 때 이해하기 편하다.
// 개인적으로 이것을 사용하는 것을 전혀 추천하지 않음.

contract Assembly {
    function nativeLoops() public returns (uint _r) {
        for(uint i = 0; i < 10; i++) {
            _r++;
        }
    }

    function asmLoops() public returns (uint _r) {
        assembly {
            let i := 0
            loop:
            i := add(i, 1)
            _r := add(_r, 1)
            jumpi(loop, lt(i, 10))
        }
    }

    function inlineAsmLoops() public returns (uint _r) {
        assembly {
            0 // i
            10 // max

            loop:
            // i := add(i, 1)
            dup2
            1
            add
            swap2
            pop

            // _r := add(_r, 1)
            dup3
            1
            add
            swap3
            pop

            // lt(i, 10)
            dup1
            dup3
            lt
            
            // jumpi(loop, lt(i, 10))
            loop
            jumpi

            pop
            pop
        }
    }
}
