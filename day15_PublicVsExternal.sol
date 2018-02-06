pragma solidity ^0.4.0;


// public 과 External 의 차이점이 무엇인가
// public internal private은 상속의 관점.

contract ExternalContract {
  //External 은 public보다 적은 가스를 사용하는 것으로 생각하겠지만 항상 그런 것은 아니다.
  // return 123으로 동일한 함수 만들어보면 public이 더 적음. 하지만!!


  function externalCall() external returns (uint) {
    //externall call 내에서는 public call 호출 가능
    return publicCall();

    // external call로 무언가를 보낼 때 이것은 단지 지역 stack에 복사된다. 그래서
    // 스택에 있기 때문에 (stack이 가장 싸고 그다음 memory, storage 순으로 비싸다.)
    // 함수에 인자로 보낼 때 external 함수로 보내는게 gas가 덜 소비됨.

  }
  // external은 instance 와 떨어져(detached from)있다. (?) 반면 public은 instance의 일부. 그래서 accessible
  // detach : 컨트랙트의 메모리의 일부가 아니라는 것
  function publicCall() public returns (uint) {
    //public에서 external call을 직접적으로 호출 할 경우 메모리를 직접 참조하는데
    /* return externalCall(); 이것은 오류를 발생함. 왜냐하면 인스턴스의 일부로 보지 않기 때문 */
    return this.externalCall(); // 그래서 this를 붙여서 인스턴스가 아닌 컨트랙트 그 자체를 reference 해줘야 된다.
  }

// 결론 : math( + - * / 등) 나 인스턴스를 요구하지 않는 함수를 만들 떄 external 함수로 만들면 메모리나 스토리지를 사용하지 않아
// gas cost를 줄일 수 있다.

}
