const { expect } = require("chai");
const SovrynPrizePoolProxyFactory = require('../build/SovrynPrizePoolProxyFactory.json')
const buidler = require('./helpers/buidler')
const { deployContract } = require('ethereum-waffle')

let overrides = { gasLimit: 20000000 }

describe('SovrynPrizePoolProxyFactory', () => {

  let wallet, wallet2

  let provider

  beforeEach(async () => {
    [wallet, wallet2] = await buidler.ethers.getSigners()
    provider = buidler.ethers.provider

    factory = await deployContract(wallet, SovrynPrizePoolProxyFactory, [], overrides)
  })

  describe('create()', () => {
    it('should create a new prize pool', async () => {
      let tx = await factory.create(overrides)
      let receipt = await provider.getTransactionReceipt(tx.hash)
      let event = factory.interface.parseLog(receipt.logs[0])
      expect(event.name).to.equal('ProxyCreated')
    })
  })
})
