// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// Uncomment this line to use console.log
import "hardhat/console.sol";
import "./base/NMT.sol";
import "./JacketMutableAsset.sol";
import "./CreatorSmartPolicy.sol";
import "./DenyAllSmartPolicy.sol";
import "./HolderSmartPolicy.sol";

/**
 * @title Jacket Mutable NFT
 * @author Francesco Donini <francesco.donini@phd.unipi.it>
 * @notice Mutable NFT contracat which maintain the association with the Jacket Asset
 */
 contract JacketNMT is NMT {

    constructor(address to)
        ERC721(
            "Mutable Jacket for a PUB Decentraland UniPi Project",
            "PUBMNTJACKET"
        )
        Ownable(to)
    {}

    fallback() external {
        //console.log("Fallback JacketMNT");
    }

    /**
     *
     * @param to  address of the new holder
     */
    function _mint(
        address to,
        address creatorSmartPolicy,
        address holderSmartPolicy
    ) internal override returns (address, uint) {
        // Asset creation by specifying the creator's address and smart Policies (creator and owner)
        JacketMutableAsset jacket = new JacketMutableAsset(
            address(this),
            address(creatorSmartPolicy),
            address(holderSmartPolicy)
        );

        //transferOwnership(to);

        // Retrieving the tokenID and calling the ERC721 contract minting function
        uint tokenId = uint160(address(jacket));
        // console.log("tokenID",tokenId);

        _safeMint(to, tokenId);
        // console.log("asset address:", address(jacket));
        // console.log("asset tokenId:", tokenId);
        // console.log("res:",address(jacket), tokenId);
        return (address(jacket), tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        // console.log("tokenId",tokenId);
        // _requireMinted(tokenId);

        // Retrieving the contract address of the asset
        address asset_contract = _intToAddress(tokenId);

        // Retrieving the URI describing the asset's current state from the asset contract
        JacketMutableAsset asset = JacketMutableAsset(asset_contract);
        return asset.tokenURI();
    }

    function getJacketAddress(uint256 _tokenId) public pure returns (address) {
        return _intToAddress(_tokenId);
    }

    // function _transferFrom(address from, address to, uint256 tokenId) internal {
    //     // Ownable.transferOwnership(to);
    //     ERC721.transferFrom(from, to, tokenId);
    // }

    // //-----Override delle funzioni previste dallo standard per il trasferimento dei token-----
    // function transferFrom(
    //     address from,
    //     address to,
    //     uint256 tokenId
    // ) public virtual override {
    //     // console.log("transferFrom");
    //     safeTransferFrom(from, to, tokenId);
    // }
}
