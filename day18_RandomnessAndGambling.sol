// 솔리디티 문서 : 마이너들의 치팅을 불가능하게 랜덤을 사용하는 것은 굉장히 어렵다.
// 이유 : 랜덤은 블록에 의해 발생되고 블록은 마이너들에 의해 생겨남

pragma solidity ^0.4.0;


contract Random {


  //simple random : financial 말고 굉장히 simple한 게임에 사용
  function unsafeBlockRandom() public returns (uint){
    return uint(block.blockhash(block.number - 1)) % 10;
    //block.number을 seed로 사용하여 hash
  }

  uint private _baseIncrement;

  // 완전 랜덤은 아니고 incrementing value에 의한 랜덤.
  function unsafeIncrementRandom() public return (uint){
    return uint(sha3(_baseIncrement++)) % 100;
    //sha3 : hash function
  }

  // oraclelize library 사용하는 랜덤
  // contract는 랜덤 넘버를 만드는 사이트로부터 요청을 받아 랜덤 발생
  // 문제 : 해당 사이트를 믿는 순간 어딘가에 dependency가 생긴다는 것./
  // shutdown이나 다른 issue가 생기면 문제 발생


}
