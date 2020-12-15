
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.7.0;
pragma experimental ABIEncoderV2;

import "./PrizePoolBuilder.sol";
import "./SingleRandomWinnerBuilder.sol";
import "../registry/RegistryInterface.sol";
import "../prize-strategy/single-random-winner/SingleRandomWinnerProxyFactory.sol";
import "../prize-pool/sovryn/SovrynPrizePoolProxyFactory.sol";
import "../token/ControlledTokenProxyFactory.sol";
import "../token/TicketProxyFactory.sol";
import "../external/sovryn/iTokenInterface.sol";
import "../external/openzeppelin/OpenZeppelinProxyFactoryInterface.sol";

/// @title Builds new Sovryn Prize Pools
/* solium-disable security/no-block-members */
contract SovrynPrizePoolBuilder is PrizePoolBuilder {
  using SafeMath for uint256;
  using SafeCast for uint256;

  struct SovrynPrizePoolConfig {
    iTokenInterface iToken;
    uint256 maxExitFeeMantissa;
    uint256 maxTimelockDuration;
  }

  RegistryInterface public reserveRegistry;
  SovrynPrizePoolProxyFactory public sovrynPrizePoolProxyFactory;
  SingleRandomWinnerBuilder public singleRandomWinnerBuilder;
  address public trustedForwarder;

  constructor (
    RegistryInterface _reserveRegistry,
    address _trustedForwarder,
    SovrynPrizePoolProxyFactory _sovrynPrizePoolProxyFactory,
    SingleRandomWinnerBuilder _singleRandomWinnerBuilder
  ) public {
    require(address(_reserveRegistry) != address(0), "SovrynPrizePoolBuilder/reserveRegistry-not-zero");
    require(address(_singleRandomWinnerBuilder) != address(0), "SovrynPrizePoolBuilder/single-random-winner-builder-not-zero");
    require(address(_sovrynPrizePoolProxyFactory) != address(0), "SovrynPrizePoolBuilder/sovryn-prize-pool-builder-not-zero");
    reserveRegistry = _reserveRegistry;
    singleRandomWinnerBuilder = _singleRandomWinnerBuilder;
    trustedForwarder = _trustedForwarder;
    sovrynPrizePoolProxyFactory = _sovrynPrizePoolProxyFactory;
  }

  function createSingleRandomWinner(
    SovrynPrizePoolConfig calldata prizePoolConfig,
    SingleRandomWinnerBuilder.SingleRandomWinnerConfig calldata prizeStrategyConfig,
    uint8 decimals
  ) external returns (SovrynPrizePool) {
    SovrynPrizePool prizePool = sovrynPrizePoolProxyFactory.create();

    SingleRandomWinner prizeStrategy = singleRandomWinnerBuilder.createSingleRandomWinner(
      prizePool,
      prizeStrategyConfig,
      decimals,
      msg.sender
    );

    address[] memory tokens;

    prizePool.initialize(
      trustedForwarder,
      reserveRegistry,
      tokens,
      prizePoolConfig.maxExitFeeMantissa,
      prizePoolConfig.maxTimelockDuration,
      prizePoolConfig.iToken
    );

    _setupSingleRandomWinner(
      prizePool,
      prizeStrategy,
      prizeStrategyConfig.ticketCreditRateMantissa,
      prizeStrategyConfig.ticketCreditLimitMantissa
    );

    prizePool.transferOwnership(msg.sender);

    emit PrizePoolCreated(msg.sender, address(prizePool));

    return prizePool;
  }

  function createSovrynPrizePool(
    SovrynPrizePoolConfig calldata config
  )
    external
    returns (SovrynPrizePool)
  {
    SovrynPrizePool prizePool = sovrynPrizePoolProxyFactory.create();

    address[] memory tokens;

    prizePool.initialize(
      trustedForwarder,
      reserveRegistry,
      tokens,
      config.maxExitFeeMantissa,
      config.maxTimelockDuration,
      config.iToken
    );

    prizePool.transferOwnership(msg.sender);

    emit PrizePoolCreated(msg.sender, address(prizePool));

    return prizePool;
  }
}
