// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RecoverEthFromLostAddress {

    address public contrAddr;

    constructor(){
        contrAddr = address(0x8aC75A4c5e7fF61d8538f3E53e5cd5b2bAB04527);
    }

    function recoverEth(address _contrAddr) public returns(bool){
        (bool success, ) = _contrAddr.call(
            abi.encodeWithSignature("destroy(address payable)", msg.sender)
        );

        return success;
    }

    function recoverEth() public returns(bool){
        (bool success, ) = contrAddr.call(
            abi.encodeWithSignature("destroy(address)", msg.sender)
        );
        return success;
    }

    receive() external payable {
    }

}