// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


// https://medium.com/51nodes/why-upgrading-openzeppelin-smart-contracts-from-version-4-to-version-5-is-unsafe-e08be30efd8a

contract MyTokenERC721Enumerable is ERC721Enumerable, ERC721URIStorage, Ownable {
    constructor(address to) ERC721("MyNFT", "MNFT") Ownable(to) {}

    // Allows minting of a new NFT
    function mintCollectionNFT(
        address collector,
        uint256 tokenId
    ) public onlyOwner {
        _mint(collector, tokenId);
    }

    // Allows setting the token URI for a specific token
    function setTokenURI(uint256 tokenId, string memory _tokenURI) public onlyOwner {
        _setTokenURI(tokenId, _tokenURI);
    }

    // Override required by Solidity for multiple inheritance
    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    // Override required by Solidity for multiple inheritance
    function supportsInterface(bytes4 interfaceId) public view override(ERC721Enumerable, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    // Override required by Solidity for multiple inheritance
    function _update(address to, uint256 tokenId, address auth) internal override(ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    // Override required by Solidity for multiple inheritance
    function _increaseBalance(address account, uint128 value) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }
}
