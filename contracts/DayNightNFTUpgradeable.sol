// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

import "./VRFConsumerBaseUpgradeable.sol";

contract DayNightNFTUpgradeable is
    ERC721URIStorageUpgradeable,
    OwnableUpgradeable,
    VRFConsumerBaseUpgradeable
{
    using SafeMathUpgradeable for uint256;
    using StringsUpgradeable for string;

    using CountersUpgradeable for CountersUpgradeable.Counter;
    CountersUpgradeable.Counter private _tokenIds;

    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public masterRandomNumber;

    mapping(bytes32 => address) requestIdToSender;
    mapping(bytes32 => uint256) requestIdToTokenId;
    mapping(bytes32 => uint256) requestIdToRandomNumber;
    mapping(uint256 => uint256) tokenIdToRandomNumber;
    mapping(uint256 => bool) tokenIdToDiceResult;
    mapping(uint256 => string[]) tokenIdUrisHashcodes;
    mapping(uint256 => string) activeUriHashcode;

    event NumberEvent(uint256 previousNumber, uint256 currentNumber);
    event ImageChange(string previousImage, string newImage);

    function __starter(
        address _VRFCoordinator,
        address _LinkToken,
        bytes32 _keyhash
    ) public initializer {
        __VRFConsumerBaseInitializable_init(_VRFCoordinator, _LinkToken);
        __ERC721_init("DiceAlxUp", "ALXU");
        __Ownable_init();
        keyHash = _keyhash;
        fee = 0.1 * 10**18;
    }

    function mintNft(
        address toAddress,
        bytes memory tokenUrisHashcode1,
        bytes memory tokenUrisHashcode2
    ) public onlyOwner returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        string[2] memory tokenUrisHashcodes;

        tokenUrisHashcodes[0] = string(tokenUrisHashcode1);
        tokenUrisHashcodes[1] = string(tokenUrisHashcode2);

        activeUriHashcode[newTokenId] = tokenUrisHashcodes[0];
        tokenIdUrisHashcodes[newTokenId] = tokenUrisHashcodes;
        _safeMint(toAddress, newTokenId);
        //set default tokenUri, however this should change over time by the dice() method
        _setTokenURI(newTokenId, tokenUrisHashcodes[0]);

        return newTokenId;
    }

    function requestNewRandomNumber(uint256 tokenId) public returns (bytes32) {
        require(
            LINK.balanceOf(address(this)) >= fee,
            "Not enough LINK - fill contract with faucet"
        );
        bytes32 requestId = requestRandomness(keyHash, fee);

        requestIdToSender[requestId] = msg.sender;
        requestIdToTokenId[requestId] = tokenId;
        requestIdToRandomNumber[requestId] = 0; // to be updated on fulfillRandomness response
        tokenIdToRandomNumber[tokenId] = 0; // to be updated on fulfillRandomness response

        return requestId;
    }

    function fulfillRandomness(bytes32 _requestId, uint256 _randomNumber)
        internal
        override
    {
        requestIdToRandomNumber[_requestId] = _randomNumber;

        emit NumberEvent(masterRandomNumber, _randomNumber);

        uint256 tokenId = requestIdToTokenId[_requestId];

        tokenIdToDiceResult[tokenId] = dice(_randomNumber, tokenId);
        tokenIdToRandomNumber[tokenId] = _randomNumber;
        // Set as masterNumber the new one, in order to compare each time different numbers
        masterRandomNumber = _randomNumber;
    }

    function dice(uint256 _randomNumber, uint256 tokenId)
        internal
        returns (bool)
    {
        if (masterRandomNumber < _randomNumber) {
            changeTokenUri(tokenIdUrisHashcodes[tokenId][1], tokenId);

            return true;
        }
        changeTokenUri(tokenIdUrisHashcodes[tokenId][0], tokenId);
        return false;
    }

    function changeTokenUri(string memory uriHashCode, uint256 tokenId)
        internal
    {
        if (
            keccak256(bytes(uriHashCode)) !=
            keccak256(bytes(activeUriHashcode[tokenId]))
        ) {
            emit ImageChange(activeUriHashcode[tokenId], uriHashCode);
            _setTokenURI(tokenId, uriHashCode);
            activeUriHashcode[tokenId] = uriHashCode;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://gateway.pinata.cloud/ipfs/";
    }

    function getRandomNumberByTokenId(uint256 tokenId)
        public
        view
        returns (uint256)
    {
        return tokenIdToRandomNumber[tokenId];
    }
}
