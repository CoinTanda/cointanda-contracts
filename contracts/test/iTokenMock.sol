/**
Copyright 2020 Coin Tanda

This file is part of Coin Tanda.

Coin Tanda is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation under version 3 of the License.

Coin Tanda is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Coin Tanda.  If not, see <https://www.gnu.org/licenses/>.
*/
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20.sol";
import "../external/pooltogether/FixedPoint.sol";

import "./ERC20Mintable.sol";

contract iTokenMock is ERC20UpgradeSafe {
  mapping(address => uint256) internal ownerTokenAmounts;
  ERC20Mintable public underlying;

  uint256 internal __supplyRatePerBlock;

  constructor (
    ERC20Mintable _token,
    uint256 _supplyRatePerBlock
  ) public {
    require(address(_token) != address(0), "token is not defined");
    underlying = _token;
    __supplyRatePerBlock = _supplyRatePerBlock;
  }

  function mint(uint256 amount) external returns (uint) {
    uint256 newiTokens;
    if (totalSupply() == 0) {
      newiTokens = amount;
    } else {
      // they need to hold the same assets as tokens.
      // Need to calculate the current exchange rate
      uint256 fractionOfCredit = FixedPoint.calculateMantissa(amount, underlying.balanceOf(address(this)));
      newiTokens = FixedPoint.multiplyUintByMantissa(totalSupply(), fractionOfCredit);
    }
    _mint(msg.sender, newiTokens);
    require(underlying.transferFrom(msg.sender, address(this), amount), "could not transfer tokens");
    return 0;
  }

  function balanceOf() external view returns (uint) {
    return underlying.balanceOf(address(this));
  }

  function burn(uint256 amount) external {
    underlying.burn(address(this), amount);
  }

  function cTokenValueOf(uint256 tokens) public view returns (uint256) {
    return FixedPoint.divideUintByMantissa(tokens, borrowInterestRate());
  }

  function assetBalanceOf(address account) public view returns (uint) {
    return FixedPoint.multiplyUintByMantissa(balanceOf(account), borrowInterestRate());
  }

  function borrowInterestRate() public view returns (uint256) {
    if (totalSupply() == 0) {
      return FixedPoint.SCALE;
    } else {
      return FixedPoint.calculateMantissa(underlying.balanceOf(address(this)), totalSupply());
    }
  }

  function loanTokenAddress() external view returns (address) {
    return address(underlying);
  }

}
