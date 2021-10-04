// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract AthensWeather is ERC721URIStorage, Ownable, ChainlinkClient {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    using Chainlink for Chainlink.Request;
    address public LinkToken;

    address private oracle;
    bytes32 private jobId;
    uint256 private fee;

    mapping(bytes32 => string) requestToCityName;
    mapping(string => uint256) cityNameToTemperature;

    constructor(address _LinkToken) ERC721("Akropolis", "AKR") {
        setPublicChainlinkToken();
        oracle = 0xAA1DC356dc4B18f30C347798FD5379F3D77ABC5b;
        jobId = "235f8b1eeb364efc83c26d0bef2d0c01";
        fee = 0.1 * 10**18; // (Varies by network and job)
        LinkToken = _LinkToken;
    }

    function mintItem(address player, string memory tokenURI)
        public
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(player, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }

    /**
     * Initial request
     */
    function requestWeatherTemperature(string memory _city) public {
        Chainlink.Request memory req = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfillWeatherTemperature.selector
        );
        req.add("city", _city);
        bytes32 requestId = sendChainlinkRequestTo(oracle, req, fee);
        requestToCityName[requestId] = _city;
    }

    /**
     * Callback function
     */
    function fulfillWeatherTemperature(bytes32 _requestId, uint256 _result)
        public
        recordChainlinkFulfillment(_requestId)
    {
        string memory theCity = requestToCityName[_requestId];
        cityNameToTemperature[theCity] = _result;
    }

    function getCityTempertature(string memory _city)
        public
        view
        returns (uint256)
    {
        return cityNameToTemperature[_city];
    }
}
