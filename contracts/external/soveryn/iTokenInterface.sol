pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";

interface iTokenInterface is IERC20 {
    function decimals() external view returns (uint256);
    function totalSupply() external override view returns (uint256);
    function VERSION() external view returns (uint256);
    function assetBalanceOf() external view returns (uint8);
    function borrowInterestRate() external view returns (uint8);
    function avgBorrowInterestRate() external returns (uint256);
    function tokenPrice() external returns (uint256);
    function profitOf() external returns (uint256);

    function underlying() external view returns (address);
    function balanceOfUnderlying(address owner) external returns (uint256);
    function supplyRatePerBlock() external returns (uint256);
    function exchangeRateCurrent() external returns (uint256);
    function mint(uint256 mintAmount) external returns (uint256);
    function balanceOf(address user) external override view returns (uint256);
    function redeemUnderlying(uint256 redeemAmount) external returns (uint256);
}
