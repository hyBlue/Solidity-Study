pragma solidity ^0.4.0;

interface ERC20 {
  //생태계 내 순환되고 있는 토큰의 총량 return
  function totalSupply() constant returns (uint _totalSupply);

  //특정 주소가 가진 잔고 return
  function balanceOf(address _owner) constant returns (uint balance);

  //본인이 _to 주소에게 _value만큼 전송,
  function transfer(address _to, uint _value) returns (bool success);

  //제3자가 from 주소에서 to 주소에게 value만큼 전송. 대신 몇 가지 제한 사항 존재.
  function transferFrom(address _from, address _to, uint _value) returns (bool success);

  // _spender가 내 토큰을 _value만큼 전송하도록 승인해줌. 나 : token owner, _spender : 내 토큰 쓰는 사람.
  function approve(address _spender, uint _value) returns (bool success);

  // 특정 주소가 다른 주소의 토큰을 얼만큼 소비할 수 있는지 알려줌.
  function allowance(address _owner, address _spender) constant returns (uint remaining);

  // chain에 logging 하는 두 가지.
  event Transfer(address indexed _from, address indexed _to, uint _value);

  event Approval(address indexed _owner, address indexed _spender, uint _value);

}
