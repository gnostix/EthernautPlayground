// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BadKing is Ownable {
    event Received(address caller, uint256 amount, string message);
    event Destruct(address caller, string message);

    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    receive() external payable {
        revert("pare to pouli tou nayti!");
    }

    function kourades() public onlyOwner {
        emit Destruct(msg.sender, "Contract selfdestruct received");
        selfdestruct(payable(owner()));
    }

    function pareToMarouli() public payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
