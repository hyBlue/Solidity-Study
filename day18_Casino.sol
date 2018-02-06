pragma solidity ^0.4.0;

contract Casino {

  //복권
  //key function : 1. 티켓을 사는것  2. 결과를 확인하는 것


  uint private start;

  uint private buyPeriod = 1000;
  uint private verifyPeriod = 100;
  uint private checkPeriod = 100;

  mapping(address => uint) private _tickets;
  mapping(address => uint) private _winnings;
  address[] _entries;
  address[] _verified;

  uint private winnerSeed;
  bool private hasWinner;
  address private winner;


  function Casino() public {
    start = block.timestamp;
  }
  //이 함수는 contract에 포함되어선 안된다. 모든 데이터가 트랜잭션에서 보이기 때문.
  function unsafeEntry(uint number, uint salt) public payable{
    return buyTicket(generateHash(number, salt));

  }
  // view : instance를 수정하지 않고 단지 보기만 하는 것
  // pure : 수정도 안하고 읽기도 안하고 단지 value를 생성하는 것
  function generateHash(uint number, uint salt) public pure return(uint){
    return uint(kecca256(number + salt));// keccak256 : hash function
  }

  // 티켓을 살 때 숫자를 입력, 비밀을 보장해야 됨.
  function buyTicket(uint hash) public payable returns (bool){
    require( block.timestamp < start + buyPeriod); // 구매 기간동안만 구매 가능

    require(1 ether == msg.value); // 가격이 정확해야 구매 가능

    require(_tickets[msg.sender] == 0); // 1주소 당 1개 구매

    _tickets[msg.sender] = hash;
    _entries.push(msg.sender);
    return true;
  }

  // salt를 이용해 hash 를 검증하기 위함.
  function verifyTicket(uint number, uint salt) public returns (bool){
      require( block.timestamp >= start + buyPeriod); //구매기간 지나고
      require( block.timestamp < start + buyPeriod + verifyPeriod); //검증기간 이내
      require(_tickets[msg.sender] > 0); // 1개 이상 있는지

      require(salt > number); // manipulate 방지
      //hash 검증
      require(generateHash(number, salt) == _ticket[msg.sender]);
      // application 밖에서 만들어진 hash가 안에서 만들어진거랑 같은지 검증.


      //xor operation을 적용하는 것은 값을 invert하는 것 -> 예측과 조작을 힘들게 함
      winnerSeed = winnerSeed ^ salt ^ uint(msg.sender);
      // address를 조작하는 것은 굉장히 힘들기 때문에 자기 자신의 주소 기반하면 안전

      _verified.push(msg.sender);


  }


  function checkWinner() public returns (bool) {
    require( block.timestamp >= start + buyPeriod + verifyPeriod);
    require( block.timestamp < start + buyPeriod + verifyPeriod + checkPeriod);

    if(!hasWinner){
      winner = _verified[winnerSeed % _verified.length];
      _winnings[winner] = _verified.length - 10 ether;
      hasWinner = true;
    }
    return msg.sender == winner;

  }

  function claim() public {
    require(_winngs[msg.sender] > 0);
    msg.sender.transfer(_winnings[msg.sender]);
    _winnings[msg.sender] = 0;
  }
}
