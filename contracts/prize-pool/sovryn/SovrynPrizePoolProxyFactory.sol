// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.7.0;

import "./SovrynPrizePool.sol";
import "../../external/openzeppelin/ProxyFactory.sol";

/// @title Sovryn Prize Pool Proxy Factory
/// @notice Minimal proxy pattern for creating new Sovryn Prize Pools
contract SovrynPrizePoolProxyFactory is ProxyFactory {

  /// @notice Contract template for deploying proxied Prize Pools
  SovrynPrizePool public instance;

  /// @notice Initializes the Factory with an instance of the Sovryn Prize Pool
  constructor () public {
    instance = new SovrynPrizePool();
  }

  /// @notice Creates a new Sovryn Prize Pool as a proxy of the template instance
  /// @return A reference to the new proxied Sovryn Prize Pool
  function create() external returns (SovrynPrizePool) {
    return SovrynPrizePool(deployMinimal(address(instance), ""));
  }
}
