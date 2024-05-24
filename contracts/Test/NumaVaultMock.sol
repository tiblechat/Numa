//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable2Step.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@uniswap/v3-core/contracts/libraries/FullMath.sol";
import "../Numa.sol";
import "../interfaces/IVaultOracleSingle.sol";
import "../interfaces/INuAssetManager.sol";
import "../interfaces/IVaultManager.sol";
import "../interfaces/INumaVault.sol";
import "../interfaces/IRewardFeeReceiver.sol";

import "../lending/CTokenInterfaces.sol";
import "../lending/NumaComptroller.sol";
import "../lending/CNumaToken.sol";

import "../NumaProtocol/NumaVault.sol";

/// @title Numa vault to mint/burn Numa to lst token
contract NumaVaultMock is NumaVault
{
      constructor(
        address _numaAddress,
        address _tokenAddress,
        uint256 _decimals,
        address _oracleAddress,
        address _minter)
     NumaVault(_numaAddress,_tokenAddress,_decimals, _oracleAddress,_minter) 
    {
    }
            /**
     * @dev transfers rewards to rwd_address and updates reference price
     */
    function extractRewards() override external 
    {    
        // require(
        //     block.timestamp >= (last_extracttimestamp + 24 hours),
        //     "reward already extracted"
        // );

        (uint256 rwd, uint256 currentvalueWei,uint256 rwdDebt) = rewardsValue();
        require(rwd > rwd_threshold, "not enough rewards to collect");
        extractInternal(rwd, currentvalueWei,rwdDebt);
    }
       

    
}
