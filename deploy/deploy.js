const { deploy1820 } = require('@thinkanddev/deploy-eip-1820-rsk')

//const debug = require('debug')('ptv3:deploy.js')
const debug = console.log;

const chainName = (chainId) => {
  switch(chainId) {
    case 1: return 'Mainnet';
    case 3: return 'Ropsten';
    case 4: return 'Rinkeby';
    case 5: return 'Goerli';
    case 42: return 'Kovan';
    case 30: return 'Rsk Mainnet';
    case 31: return 'Rsk testnet';
    case 33: return 'Rsk regtest';
    case 1337: return 'Coverage';
    case 5777: return 'Ganache';
    case 31337: return 'BuidlerEVM';
    default: return 'Unknown';
  }
}

module.exports = async (buidler) => {
  const { getNamedAccounts, deployments, getChainId, ethers } = buidler
  const { deploy } = deployments

  const harnessDisabled = !!process.env.DISABLE_HARNESS

  let {
    deployer,
    rng,
    trustedForwarder,
    adminAccount,
    comptroller,
    reserve
  } = await getNamedAccounts()
  const chainId = parseInt(await getChainId(), 10)
  debug('ChainID', chainId);
  const isLocal = [1, 3, 4, 42, 30, 31].indexOf(chainId) == -1
  // 31337 is unit testing, 1337 is for coverage, 33 is rsk regtest
  const isTestEnvironment = chainId === 31337 || chainId === 1337 || chainId === 33
  debug('isTestEnvironment', isTestEnvironment);
  // Fix transaction format  error from etherjs getTransactionReceipt as transactionReceipt format
  // checks root to be a 32 bytes hash when on RSK its 0x01
  const format = ethers.provider.formatter.formats
  if (format) format.receipt['root'] = format.receipt['logsBloom']
  Object.assign(ethers.provider.formatter, { format: format })

  const signer = await ethers.provider.getSigner(deployer)
  Object.assign(signer.provider.formatter, { format: format })

  debug("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
  debug("Coin Tanda Contracts - Deploy Script")
  debug("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")

  const locus = isLocal ? 'local' : 'remote'
  debug(`  Deploying to Network: ${chainName(chainId)} (${locus})`)

  if (!adminAccount) {
    debug("  Using deployer as adminAccount;")
    adminAccount = signer._address
  }
  debug("\n  adminAccount:  ", adminAccount)

  await deploy1820(signer)

  if (isLocal) {
    debug("\n  Deploying TrustedForwarder...")
    const deployResult = await deploy("TrustedForwarder", {
      from: deployer,
      skipIfAlreadyDeployed: true
    });
    trustedForwarder = deployResult.address

    debug("\n  Deploying RNGService...")
    const rngServiceMockResult = await deploy("RNGServiceMock", {
      from: deployer,
      skipIfAlreadyDeployed: true
    })
    rng = rngServiceMockResult.address

    debug("\n  Deploying Dai...")
    const daiResult = await deploy("Dai", {
      args: [
        'DAI Test Token',
        'DAI'
      ],
      contract: 'ERC20Mintable',
      from: deployer,
      skipIfAlreadyDeployed: true
    })

    debug("\n  Deploying cDai...")
    // should be about 20% APR
    let supplyRate = '8888888888888'
    await deploy("cDai", {
      args: [
        daiResult.address,
        supplyRate
      ],
      contract: 'CTokenMock',
      from: deployer,
      skipIfAlreadyDeployed: true
    })

    await deploy("yDai", {
      args: [
        daiResult.address
      ],
      contract: 'yVaultMock',
      from: deployer,
      skipIfAlreadyDeployed: true
    })

    // Display Contract Addresses
    debug("\n  Local Contract Deployments;\n")
    debug("  - TrustedForwarder: ", trustedForwarder)
    debug("  - RNGService:       ", rng)
    debug("  - Dai:              ", daiResult.address)
  }

  let comptrollerAddress = comptroller
  // if not set by named config
  if (!comptrollerAddress) {
    const contract = isTestEnvironment ? 'ComptrollerHarness' : 'Comptroller'
    const comptrollerResult = await deploy("Comptroller", {
      contract,
      from: deployer,
      skipIfAlreadyDeployed: true
    })
    comptrollerAddress = comptrollerResult.address
    const comptrollerContract = await buidler.ethers.getContractAt(
      "Comptroller",
      comptrollerResult.address,
      signer
    )
    if (adminAccount !== deployer) {
      await comptrollerContract.transferOwnership(adminAccount)
    }
  }

  let reserveAddress = reserve
  // if not set by named config
  if (!reserveAddress) {
    const reserveResult = await deploy("Reserve", {
      from: deployer,
      skipIfAlreadyDeployed: true
    })
    reserveAddress = reserveResult.address
    const reserveContract = await buidler.ethers.getContractAt(
      "Reserve",
      reserveResult.address,
      signer
    )
    if (adminAccount !== deployer) {
      await reserveContract.transferOwnership(adminAccount)
    }
  }

  const reserveRegistryResult = await deploy("ReserveRegistry", {
    contract: 'Registry',
    from: deployer,
    skipIfAlreadyDeployed: true
  })
  const reserveRegistryContract = await buidler.ethers.getContractAt(
    "Registry",
    reserveRegistryResult.address,
    signer
  )
  if (await reserveRegistryContract.lookup() != reserveAddress) {
    await reserveRegistryContract.register(reserveAddress)
  }
  if (adminAccount !== deployer) {
    await reserveRegistryContract.transferOwnership(adminAccount)
  }

  let permitAndDepositDaiResult
  if (chainId != 30 && chainId != 31) {
    debug("\n  Deploying PermitAndDepositDai...")
    permitAndDepositDaiResult = await deploy("PermitAndDepositDai", {
      from: deployer,
      skipIfAlreadyDeployed: true
    })
  }

  debug("\n  Deploying CompoundPrizePoolProxyFactory...")
  let compoundPrizePoolProxyFactoryResult
  if (isTestEnvironment && !harnessDisabled) {
    compoundPrizePoolProxyFactoryResult = await deploy("CompoundPrizePoolProxyFactory", {
      contract: 'CompoundPrizePoolHarnessProxyFactory',
      from: deployer,
      skipIfAlreadyDeployed: true
    })
  } else {
    compoundPrizePoolProxyFactoryResult = await deploy("CompoundPrizePoolProxyFactory", {
      from: deployer,
      skipIfAlreadyDeployed: true
    })
  }

  let yVaultPrizePoolProxyFactoryResult
  if (chainId != 30 && chainId != 31) {
    if (isTestEnvironment && !harnessDisabled) {
      yVaultPrizePoolProxyFactoryResult = await deploy("yVaultPrizePoolProxyFactory", {
        contract: 'yVaultPrizePoolHarnessProxyFactory',
        from: deployer,
        skipIfAlreadyDeployed: true
      })
    } else {
      yVaultPrizePoolProxyFactoryResult = await deploy("yVaultPrizePoolProxyFactory", {
        from: deployer,
        skipIfAlreadyDeployed: true
      })
    }
  }

  debug("\n  Deploying ControlledTokenProxyFactory...")
  const controlledTokenProxyFactoryResult = await deploy("ControlledTokenProxyFactory", {
    from: deployer,
    skipIfAlreadyDeployed: true
  })

  debug("\n  Deploying TicketProxyFactory...")
  const ticketProxyFactoryResult = await deploy("TicketProxyFactory", {
    from: deployer,
    skipIfAlreadyDeployed: true
  })

  let stakePrizePoolProxyFactoryResult
  if (chainId != 30 && chainId != 31) {
    debug("\n  Deploying StakePrizePoolProxyFactory...") // for creating new yVault Prize Pools
    stakePrizePoolProxyFactoryResult = await deploy("StakePrizePoolProxyFactory", {
      from: deployer,
      skipIfAlreadyDeployed: true
    })
  }

  debug("\n  Deploying ControlledTokenBuilder...")
  const controlledTokenBuilderResult = await deploy("ControlledTokenBuilder", {
    args: [
      trustedForwarder,
      controlledTokenProxyFactoryResult.address,
      ticketProxyFactoryResult.address
    ],
    from: deployer,
    skipIfAlreadyDeployed: true
  })

  debug("\n  Deploying SingleRandomWinnerProxyFactory...")
  let singleRandomWinnerProxyFactoryResult
  if (isTestEnvironment && !harnessDisabled) {
    singleRandomWinnerProxyFactoryResult = await deploy("SingleRandomWinnerProxyFactory", {
      contract: 'SingleRandomWinnerHarnessProxyFactory',
      from: deployer,
      skipIfAlreadyDeployed: true
    })
  } else {
    singleRandomWinnerProxyFactoryResult = await deploy("SingleRandomWinnerProxyFactory", {
      from: deployer,
      skipIfAlreadyDeployed: true
    })
  }

  debug("\n  Deploying SingleRandomWinnerBuilder...")
  const singleRandomWinnerBuilderResult = await deploy("SingleRandomWinnerBuilder", {
    args: [
      singleRandomWinnerProxyFactoryResult.address,
      trustedForwarder,
      controlledTokenProxyFactoryResult.address,
      ticketProxyFactoryResult.address
    ],
    from: deployer,
    skipIfAlreadyDeployed: true
  })

  debug("\n  Deploying CompoundPrizePoolBuilder...")
  const compoundPrizePoolBuilderResult = await deploy("CompoundPrizePoolBuilder", {
    args: [
      reserveRegistryResult.address,
      trustedForwarder,
      compoundPrizePoolProxyFactoryResult.address,
      singleRandomWinnerBuilderResult.address
    ],
    from: deployer,
    skipIfAlreadyDeployed: true
  })


  let yVaultPrizePoolBuilderResult
  if (chainId != 30 && chainId != 31) {
    debug("\n  Deploying yVaultPrizePoolBuilder...")
    yVaultPrizePoolBuilderResult = await deploy("yVaultPrizePoolBuilder", {
      args: [
        reserveRegistryResult.address,
        trustedForwarder,
        yVaultPrizePoolProxyFactoryResult.address,
        singleRandomWinnerBuilderResult.address
      ],
      from: deployer,
      skipIfAlreadyDeployed: true
    })
  }

  let stakePrizePoolBuilderResult
  if (chainId != 30 && chainId != 31) {
    debug("\n  Deploying StakePrizePoolBuilder...")
    stakePrizePoolBuilderResult = await deploy("StakePrizePoolBuilder", {
      args: [
        reserveRegistryResult.address,
        trustedForwarder,
        stakePrizePoolProxyFactoryResult.address,
        singleRandomWinnerBuilderResult.address
      ],
      from: deployer,
      skipIfAlreadyDeployed: true
    })
  }

  // Display Contract Addresses
  debug("\n  Contract Deployments Complete!\n")
  debug("  - TicketProxyFactory:             ", ticketProxyFactoryResult.address)
  debug("  - Reserve:                        ", reserveAddress)
  debug("  - Comptroller:                    ", comptrollerAddress)
  debug("  - CompoundPrizePoolProxyFactory:  ", compoundPrizePoolProxyFactoryResult.address)
  debug("  - ControlledTokenProxyFactory:    ", controlledTokenProxyFactoryResult.address)
  debug("  - SingleRandomWinnerProxyFactory: ", singleRandomWinnerProxyFactoryResult.address)
  debug("  - ControlledTokenBuilder:         ", controlledTokenBuilderResult.address)
  debug("  - SingleRandomWinnerBuilder:      ", singleRandomWinnerBuilderResult.address)
  debug("  - CompoundPrizePoolBuilder:       ", compoundPrizePoolBuilderResult.address)
  if (chainId != 30 && chainId != 31) {
    debug("  - yVaultPrizePoolBuilder:         ", yVaultPrizePoolBuilderResult.address)
    debug("  - StakePrizePoolBuilder:          ", stakePrizePoolBuilderResult.address)
    debug("  - PermitAndDepositDai:            ", permitAndDepositDaiResult.address)
  }
  debug("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n")
};
