// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.7.0;

import "../prize-pool/sovryn/SovrynPrizePool.sol";

/* solium-disable security/no-block-members */
contract SovrynPrizePoolHarness is SovrynPrizePool {

  uint256 public currentTime;

  function setCurrentTime(uint256 _currentTime) external {
    currentTime = _currentTime;
  }

  function setTimelockBalance(uint256 _timelockBalance) external {
    timelockTotalSupply = _timelockBalance;
  }

  function _currentTime() internal override view returns (uint256) {
    return currentTime;
  }

  function supply(uint256 mintAmount) external {
    _supply(mintAmount);
  }

  function redeem(uint256 redeemAmount) external returns (uint256) {
    return _redeem(redeemAmount);
  }
}