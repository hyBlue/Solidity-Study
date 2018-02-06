pragma solidity ^0.4.0;

library Strings {

  function concat(string _base, string _value) internal returns (string){

    /* bytes _baseBytes = bytes(_base); // error : type btyes memory is not im
    plicitly convertible to expected type bytes storage pointer*/
    bytes memory _baseBytes = bytes(_base); // storage memory stack :  데이터 저장하는 세가지 위치
    //  function 내에서 선언한 배열은 storage를 참조. 함수의 인자는 default로 메모리에 저장. 하지만 메모리 배열을 암시적으로 stack에 저장할 수 없음.
    // 그래서 함수 내 선언하는 배열은 storage 배열을 참조하거나 memory 선언을 명시적으로 해줘야됨.

    /* stack : function 에 있는 모든 것 저장, function 끝나면 사라짐
    memory : 컨트랙트에 있는 트랜잭션 실행에 관련된 정보 저장
    storage : passing a value which you don't want to be cloned , 함수에 value를 보내는 것은 사실 clone하는 것. original value는 안바뀜.
    그래서 c에서는 original value 바꾸려면 포인터 사용. */

    bytes memory _valueBytes = bytes(_value); // string data를 bytes를 casting 하는 것.

    //concat 하기 위해서는 같은 길이의 새로운 bytes를 만들면 안되고 먼저 string 을 메모리에 만들어야 됨.
    string memory _tmpValue = new string(_baseBytes.length + _valueBytes.length);
    bytes memory _newValue = bytes(_tmpValue);

    /* string 과 bytes의 차이점 : string[0] 은 에러, bytes[0]은 가능. */

    //iterate over base, value 하고 하나를 다른 하나의 끝에 fix 할 것.
    uint i;
    uint j;

    for(i = 0; i < _baseBytes.length; i++){
      _newValue[j++] = _baseBytes[i];
    }

    for(i = 0; i < _valueBytes.length; i++){
      _newValue[j++] = _valueBytes[i];

    }

    return string(_newValue);

  }

  function strpos(string _base, string _value ) internal returns (int){// ensuring 하려면 non - matching value일 경우 음수를 return하게 해야됨, 그래서 uint가 아닌 int
    bytes memory _baseBytes = bytes(_base); // bytes 함수가 return하는 것이 아예 ㅠ
    bytes memory _valueBytes = bytes(_value);

    assert(_valueBytes.length == 1); // 한 글자의 위치만 찾기

    for(uint i = 0; i < _baseBytes.length; i++){
      if (_baseBytes[i] == _valueBytes[0]){
        return int(i);
      }

    }
    return -1;
  }
}

contract TestStrings{

  using Strings for string;

  function testConcat(string _base) returns (string) {
      return _base.concat("_suffix"); // concat 안에 들어가는 argument는 사실 함수 원형의 두번째 인자임. 첫번쨰 인자는 _base. 이름 같을 필요 없다.


  }

  function needleInHaystack(string _base, string _value) returns (int){
    return _base.strpos("t");
  }
}
