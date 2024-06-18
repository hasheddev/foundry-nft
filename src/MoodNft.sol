// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    error MoodNft__OnlyOwnerCanFlipMood();
    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;
    mapping(uint256 => Mood) private s_tokenIdToMood;

    enum Mood {
        Happy,
        Sad
    }

    constructor(
        string memory sadSvgImageUri,
        string memory happySvgImageUri
    ) ERC721("Mood NFT", "MNFT") {
        s_tokenCounter = 0;
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.Happy;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        if (
            getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender
        ) {
            revert MoodNft__OnlyOwnerCanFlipMood();
        }
        if (s_tokenIdToMood[tokenId] == Mood.Sad) {
            s_tokenIdToMood[tokenId] = Mood.Happy;
        } else {
            s_tokenIdToMood[tokenId] = Mood.Sad;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageUri;
        if (s_tokenIdToMood[tokenId] == Mood.Happy) {
            imageUri = s_happySvgImageUri;
        } else {
            imageUri = s_sadSvgImageUri;
        }
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "',
                                name(),
                                '", "description": "An NFT that reflects the owners mood."',
                                ', "attributes": [{"trait_type": "moodiness", "value": 100}]',
                                ', "image": "',
                                imageUri,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
