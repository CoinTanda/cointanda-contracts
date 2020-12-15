// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.7.0;

import "./SovrynPrizePoolHarness.sol";
import "../external/openzeppelin/ProxyFactory.sol";

/// @title Sovryn Prize Pool Proxy Factory
/// @notice Minimal proxy pattern for creating new Compound Prize Pools
contract SovrynPrizePoolHarnessProxyFactory is ProxyFactory {

  /// @notice Contract template for deploying proxied Prize Pools
  SovrynPrizePoolHarness public instance;

  /// @notice Initializes the Factory with an instance of the Compound Prize Pool
  constructor () public {
    instance = new SovrynPrizePoolHarness();
  }

  /// @notice Creates a new Compound Prize Pool as a proxy of the template instance
  /// @return A reference to the new proxied Compound Prize Pool
  function create() external returns (SovrynPrizePoolHarness) {
    return SovrynPrizePoolHarness(deployMinimal(address(instance), ""));
  }
}
