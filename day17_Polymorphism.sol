
// polymorphism : object의 명시적 정의나 구현을 몰라도 그 오브젝트 사용 가능
// 단지 우리가 아는 어떤 오브젝트로부터 그 object가 기원했다고만 알고 있음.

pragma solidity ^0.4.0
interface Letter {
  function n() public returns (uint);
}

// contract 가 Letter을 참조하려면 이름이 n이고 uint return하는 함수 이 항상 있어야됨.
// 어떤 것이든 상관 없이

contract A is Letter {
  function n() public returns (uint){
    return 1;
  }
}

// A를 상속. A는 Letter이기 때문에 B 도 Letter
contract B is A {

}


contract C is Letter {
  function n() public returns (uint) {
    return 2;
  }
  function x() public returns (string){
    return "x";
  }
}

contract Alphabet {
  Letter[] private letters;

  event Printer(uint);


  // 배열에서 참조하는 것은 contract의 주소값.
  // 배열에 저장된 것중 확실한 것은 그것이 하나의 함수를 가진 letter이란 것 밖에 정확한게 없다.
  function Alphabet() public {
    letters.push(new A()); // n()함수 실행 : 1
    letters.push(new B()); // 1
    letters.push(new C()); // 2
  }

  // 잠재적으로 이미 존재할 수 있을지도 모르는 무언가에 cast 할 수 있음
  function loadRemote(address _addrX, address _addrY, address _addrZ) public{
    letters.push(Letter(_addrX));
    letters.push(Letter(_addrY));
    letters.push(Letter(_addrZ));
  }
  //이 세가지 주소들이 모두 Letter의 interface를 구현했다는 전제 하에 가능



  //이런 기능은 ERC20 토큰을 사용할 때 굉장히 유용

  //출력
  function printLetters() public {
    for(uint i = 0; i < letters.length; i++){
      Printer(letters[i].n());
    }
  }

}
