//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable2Step.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "../Numa.sol";


interface INuma {
    function mint(address to, uint256 amount) external;
}





/// @title Numa minter
contract NumaMinter is Ownable2Step, Pausable 
{
    //
    INuma public numa;
    mapping(address => bool) allowedMinters;


    // Events
    event AddedToMinters(address indexed a);
    event RemovedFromMinters(address indexed a);
    event SetToken(address token);


    modifier onlyMinters() {
        require(isMinter(msg.sender));
        _;
    }


    constructor() Ownable(msg.sender)
    {

    }

    function setTokenAddress(address _token) external onlyOwner
    {
        numa = INuma(_token);
        emit SetToken(_token);
    }

    function mint(address to, uint256 amount) external whenNotPaused onlyMinters
    {
        require(address(numa) != address(0),"token address invalid");
        numa.mint(to,amount);

    }

    function addToMinters(address _address) public onlyOwner {
        allowedMinters[_address] = true;
        emit AddedToMinters(_address);
    }

    function removeFromMinters(address _address) public onlyOwner {
        allowedMinters[_address] = false;
        emit RemovedFromMinters(_address);
    }

    function isMinter(address _address) public view returns(bool) {
        return allowedMinters[_address];
    }


}

