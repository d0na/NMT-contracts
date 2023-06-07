// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
import "hardhat/console.sol";
import "./interfaces/MNTAsset.sol";

/**
 * @title Smart Asset which represents a Jacket
 * @author Francesco Donini
 * @notice This Smart Contract contains all the Jacket properties and features which allows
 * it to mutate
 */
contract JacketAsset is MNTAsset {
    /**  @dev Indicates which is the current asset contract owner */
    address public currentOwner;

    // https://www.google.com/search?q=pattern+clothes+anmes&oq=pattern+clothes+anmes&aqs=chrome..69i57j0i22i30j0i8i10i13i15i30.6999j1j7&sourceid=chrome&ie=UTF-8#imgrc=mZSD24o1hA8VdM
    enum _PATTERN {
        STRIPPED,
        PLAIN,
        CHECKED
    }
    enum _COLOR {
        RED,
        GREEN,
        BLUE,
        YELLOW,
        GRAY
    }

    /**
     * @notice Asset Properties describing how can change the asset
     * color: base color used with pattern
     * pattern: ..
     */
    struct AssetProperties {
        _COLOR color;
        _PATTERN pattern;
    }

    constructor(address owner) {
        require(owner == address(owner), "Invalid collection contract address");
        currentOwner = owner;
    }

    function render() external view override returns (uint) {}

    function get3DModel() external view override {}

    function init() external view override {}
}