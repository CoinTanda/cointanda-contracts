const ethers = require('ethers')

const networks = {
  buidlerevm: {
    blockGasLimit: 200000000,
    allowUnlimitedContractSize: true,
    chainId: 31337
  },
  coverage: {
    url: 'http://127.0.0.1:8555',
    blockGasLimit: 200000000,
    allowUnlimitedContractSize: true,
    chainId: 1337
  },
  localhost: {
    url: 'http://127.0.0.1:8545',
    blockGasLimit: 200000000,
    allowUnlimitedContractSize: false,
    chainId: 1337
  },
  rskregtest: {
    url: 'http://127.0.0.1:4444',
    blockGasLimit: 68000000,
    allowUnlimitedContractSize: false,
    chainId: 33
  }
}

if (process.env.USE_BUIDLER_EVM_ACCOUNTS) {
  networks.buidlerevm.accounts = process.env.USE_BUIDLER_EVM_ACCOUNTS.split(/\s+/).map(privateKey => ({
    privateKey,
    balance: ethers.utils.parseEther('10000000').toHexString()
  }))
}

if (process.env.HDWALLET_MNEMONIC) {
  networks.fork = {
    url: 'http://127.0.0.1:8545'
  }
  networks.rsktestnet = {
    url: 'https://public-node.testnet.rsk.co',
    blockGasLimit: 68000000,
    allowUnlimitedContractSize: false,
    chainId: 31,
    accounts: {
      mnemonic: process.env.HDWALLET_MNEMONIC
    }
  }
  networks.rskmainnet = {
    url: 'https://public-node.rsk.co',
    blockGasLimit: 68000000,
    allowUnlimitedContractSize: false,
    chainId: 30,
    accounts: {
      mnemonic: process.env.HDWALLET_MNEMONIC
    }
  }
}

if (process.env.INFURA_API_KEY && process.env.HDWALLET_MNEMONIC) {
  networks.kovan = {
    url: `https://kovan.infura.io/v3/${process.env.INFURA_API_KEY}`,
    accounts: {
      mnemonic: process.env.HDWALLET_MNEMONIC
    }
  }

  networks.ropsten = {
    url: `https://ropsten.infura.io/v3/${process.env.INFURA_API_KEY}`,
    accounts: {
      mnemonic: process.env.HDWALLET_MNEMONIC
    }
  }

  networks.rinkeby = {
    url: `https://rinkeby.infura.io/v3/${process.env.INFURA_API_KEY}`,
    accounts: {
      mnemonic: process.env.HDWALLET_MNEMONIC
    }
  }

  networks.mainnet = {
    url: `https://mainnet.infura.io/v3/${process.env.INFURA_API_KEY}`,
    accounts: {
      mnemonic: process.env.HDWALLET_MNEMONIC
    }
  }
} else {
  console.warn('No infura or hdwallet available for testnets')
}

module.exports = networks