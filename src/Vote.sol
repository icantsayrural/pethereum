pragma solidity ^0.4.0;

contract Vote {
  uint data;

  function set(uint x) public {
    data = x;
  }

  function get() public constant returns (uint) {
    return data;
  }
}
