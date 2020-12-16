// SPDX-License-Identifier: GPL-3.0s
pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";

interface iTokenInterface is IERC20 {
    function decimals() external view returns (uint256);
    function totalSupply() external override view returns (uint256);

    function mint(address receiver, uint256 depositAmount) external returns (uint256 mintAmount);
    function burn(address receiver, uint256 burnAmount) external returns (uint256 loanAmountPaid);
    function loanTokenAddress() external view returns (address);
    function assetBalanceOf(address _owner) external view returns (uint256);

    function totalReservedSupply() external view returns (uint256);
    function checkpointPrice(address _user) external view returns (uint256 price);
    function supplyInterestRate() external view returns (uint256);
    function tokenPrice() external returns (uint256);
    function totalAssetSupply() external view returns (uint256);
}