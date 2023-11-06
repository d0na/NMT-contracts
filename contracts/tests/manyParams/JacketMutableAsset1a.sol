// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

// Uncomment this line to use console.log
import "hardhat/console.sol";
import "../../base/MutableAsset.sol";
import "../../JacketNMT.sol";
import "../../base/SmartPolicy.sol";

/**
 * @title Smart Asset which represents a Jacket
 * @author Francesco Donini <francesco.donini@phd.unipi.it>
 * @notice This Smart Contract contains all the Jacket properties and features which allows
 * it to mutate
 */
contract JacketMutableAsset1a is MutableAsset {
    /** */
    constructor(
        address _nmt,
        address _creatorSmartPolicy,
        address _holderSmartPolicy
    ) MutableAsset(_nmt, _creatorSmartPolicy, _holderSmartPolicy) {}

    //Jacket descriptor
    struct JacketDescriptor {
        uint256 color;
        bool sleeves;
        uint256 method1;
    }

    // Current state representing jacket descriptor with its attributes
    JacketDescriptor public jacketDescriptor;

    /** Retrieves all the attributes of the descriptor Jacket
     *
     * TODO forse visto che jacketDescriptor è public nn doverebbe servire
     */
    function getJacketDescriptor()
        public
        view
        returns (JacketDescriptor memory)
    {
        return (jacketDescriptor);
    }

    event StateChanged(JacketDescriptor jacketDescriptor);

    /**
     * USERS ACTIONS with attached policy
     * */

    fallback() external {}

    function setColor(
        uint256 _color,
        string memory _tokenURI
    )
        public
        evaluatedByCreator(
            msg.sender,
            abi.encodeWithSignature(
                "setColor(uint256,string)",
                _color,
                _tokenURI
            ),
            address(this)
        )
        evaluatedByHolder(
            msg.sender,
            abi.encodeWithSignature(
                "setColor(uint256,string)",
                _color,
                _tokenURI
            ),
            address(this)
        )
    {
        _setColor(_color, _tokenURI);
    }

    // Public only for evaluating costs
    function _setColor(uint256 _color, string memory _tokenURI) public {
        jacketDescriptor.color = _color;
        setTokenURI(_tokenURI);
        emit StateChanged(jacketDescriptor);
    }

    function setMethod(
        uint256 _param1,
        string memory _tokenURI
    )
        public
        evaluatedByCreator(
            msg.sender,
            abi.encodeWithSignature(
                "setMethod(uint256, string)",
                _param1,
                _tokenURI
            ),
            address(this)
        )
        evaluatedByHolder(
            msg.sender,
            abi.encodeWithSignature(
                "setMethod1(uint256, string)",
                _param1,
                _tokenURI
            ),
            address(this)
        )
    {
        _setMethod(_param1, _tokenURI);
    }

    function _setMethod(uint256 _param1, string memory _tokenURI) public {
        jacketDescriptor.method1 = _param1;
        setTokenURI(_tokenURI);
        emit StateChanged(jacketDescriptor);
    }

    
}
