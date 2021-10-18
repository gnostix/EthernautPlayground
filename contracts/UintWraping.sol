// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Testing Uint256 underflow and overflow in Solidity

contract UintWrapping {
    uint public zero = 0;
    uint public max = 2**256-1;
    
    // zero will end up at 2**256-1
    function zeroMinus1() public {
        zero -= 1;
    }
    // max will end up at 0
    function maxPlus1() public {
        max += 1;
    }
}