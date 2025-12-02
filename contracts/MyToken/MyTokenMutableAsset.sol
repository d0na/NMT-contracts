// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// Uncomment this line to use console.log
import "hardhat/console.sol";
import "../base/NMT.sol";
import "../base/MutableAsset.sol";

/*
 * @title MyToken Mutable Asset
 * @author Francesco Donini <francesco.donini@phd.unipi.it>
 * @notice MyToken Asset rapresentation
 */
contract MyTokenMutableAsset is MutableAsset {
    constructor(
        address _nmt,
        address _creatorSmartPolicy,
        address _holderSmartPolicy
    ) MutableAsset(_nmt, _creatorSmartPolicy, _holderSmartPolicy) {}

    //MyToken descriptor
    struct MyTokenDescriptor {
        address attrAddress; // represents the tokenId of the event
        uint256 attrUint; // represents the tokenId of the event
        bool attrBool; //
    }

    // Current state representing MyToken descriptor with its attributes
    MyTokenDescriptor public myTokenDescriptor;

    function getMyTokenDescriptor()
        public
        view
        returns (MyTokenDescriptor memory)
    {
        return (myTokenDescriptor);
    }

    event StateChanged(MyTokenDescriptor myTokenDescriptor);

    /**
     * USERS ACTIONS with attached policy
     * */

    fallback() external {}

    function setAttrAddress(
        address _attrAddress,
        string memory _tokenURI
    )
        public
        evaluatedBySmartPolicies(
            msg.sender,
            abi.encodeWithSignature(
                "setAttrAddress(address,string)",
                _attrAddress,
                _tokenURI
            ),
            address(this)
        )
    {
        // _setBackstageAccess(_backstageAccess, _tokenURI);
        myTokenDescriptor.attrAddress = _attrAddress;
        setTokenURI(_tokenURI);
        emit StateChanged(myTokenDescriptor);
    }
    
   function setAttrUint(
        uint256 _attrUint
    )
        public
        evaluatedBySmartPolicies(
            msg.sender,
            abi.encodeWithSignature(
                "setAttrUint(uint256)",
                _attrUint
            ),
            address(this)
        )
    {
        // _setBackstageAccess(_backstageAccess, _tokenURI);
        myTokenDescriptor.attrUint = _attrUint;
        emit StateChanged(myTokenDescriptor);
    }

    function setAttrBool(
        bool _attrBool
    )
        public
        evaluatedBySmartPolicies(
            msg.sender,
            abi.encodeWithSignature(
                "setAttrBool(bool)",
                _attrBool
            ),
            address(this)
        )
    {
        // _setBackstageAccess(_backstageAccess, _tokenURI);
        myTokenDescriptor.attrBool = _attrBool;
        emit StateChanged(myTokenDescriptor);
    }


 
}
