pragma solidity ^0.4.0;

import "browser/ERC20.sol"; // Remix 상에서 ERC.sol 파일 만든 후 ERC20tokens.sol 복붙
                            // 다른 환경에서 import할 경우 알아서 경로 변경

contract MyFirstToken is ERC20 {

  string public constant symbol = "MFT"; // 우리 token의 약자. BTC, ETH 같은
  string public constant name = "My First Token";
  uint8 public constant decimals = 18; // 우리가 만든 token이 가질 수 있는 소수자리 수

  uint private constant __totalSupply = 1000;
  mapping (address => uint ) private __balanceOf; // 각 계좌와 연결된 잔고 정보 저장
  mapping (address => mapping(address => uint) ) private __allowances; // 내가 누구에게 value만큼 허락한 정보 보관


  //constructor
  function MyFirstToken(){
    __balanceOf[msg.sender] = __totalSupply; // 만든 사람에게 모든 tokens 준다. 이후 어떠한 조작도 불가.
  }

  function totlaSupply() constant returns (uint _totalSupply){
      _totalSupply = __totalSupply;
  }

  function balanceOf(address addr) constant returns (uint balance){
      return __balanceOf[addr];
  }

  function transfer(address _to, uint _value) returns (bool success){
      if (_value > 0 && _value <= balanceOf(msg.sender)){ // 함수 호출하는 사람의 잔고가 value 이상일때만 실행.
        __balanceOf[msg.sender] -= _value;
        __balanceOf[_to] += _value;
          Transfer(msg.sender, _to, _value);// interface에서 등록한 이벤트
        return true;
      }

      return false;
  }

  function transferFrom(address _from, address _to, uint _value) returns (bool success){
    if(  __allowances[_from][msg.sender] > 0 &&
      _value > 0 &&
      __allowances[_from][msg.sender] >= _value &&
      __balanceOf[_from] >= _value){ // 비디오에 없는 부분. 조건 추가
        __balanceOf[_from] -= _value;
        __balanceOf[_to] += _value;
         __allowances[_from][msg.sender] -= _value; // 비디오에서 빠진 부분
         Transfer(_from, _to, _value); // interface에서 등록한 이벤트
        return true;

      }

      return false;
  }

  function approve(address _spender, uint _value) returns (bool success){
    __allowances[msg.sender][_spender] = _value; // msg.sender가 _spender이 자기 토큰을 _value만큼 쓰도록 허락한 정보를 mapping 에 저장. 여러 제약 추가 가능.
     Approval(msg.sender, _spender, _value); // interface에 등록한 이벤트
    return true;
  }

  function allowance(address _owner, address _spender) constant returns (uint remaining){
    // spender 가 owner 의 계좌에서 얼만큼 쓸 수 있는지 보여줌

 return __allowances[_owner][_spender];
    //owner 가 undefined일 경우 에러 발생 가능.


  }


}
