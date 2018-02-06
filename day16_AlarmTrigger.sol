pragma solidity ^0.4.0;

interface AlarmWakeUp {
  function callback(bytes data) public;


}

contract AlarmService {

  struct TimeEvent {
    address _addr;
    bytes data;
  }
  mapping(uint => TimeEvent[]) private _events;


  function set(uint _time) public returns (bool) {
    TimeEvent _timeEvent;
    _timeEvent._addr = msg.sender;
    _timeEvent.data = msg.data;

      _events[_time].push(_timeEvent);
  }

  function call(uint _time) public  {
      TimeEvent[] timeEvents = _events[_time];
      for(uint i = 0; i < timeEvents.length; i++){
        AlarmWakeUp(timeEvents[i]._addr).callback(timeEvents[i].data); // 깨워야 되는 모든 주소 callback
      }
  }
}

contract AlarmTrigger is AlarmWakeUp {

  AlarmService private _alarmService;

  function AlarmTrigger() {
      _alarmService = new AlarmService();
  }

  function callback() public {
    // Do something
  }

  function setAlarm() public {
    _alarmService.set(block.timestamp + 60);
  }
}
