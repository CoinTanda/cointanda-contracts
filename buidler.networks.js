const networks = {
  buidlerevm: {
    blockGasLimit: 200000000,
    allowUnlimitedContractSize: true,
    chainId: 31337
  },
  coverage: {
    url: 'http://127.0.0.1:8555',
    blockGasLimit: 200000000,
    allowUnlimitedContractSize: true
  },
  localhost: {
    url: 'http://127.0.0.1:4444',
    blockGasLimit: 200000000,
    allowUnlimitedContractSize: true,
    chainId: 33
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