# CoinTanda Prize Savings Protocol

[![built-with openzeppelin](https://img.shields.io/badge/built%20with-OpenZeppelin-3677FF)](https://docs.openzeppelin.com/)

The [CoinTanda](https://www.cointanda.com/) Prize Savings Protocol Ethereum smart contracts.

For an overview of the concepts and API please see the [documentation](https://docs.cointanda.com/)

#### Setup

This project is available as an NPM package:

```bash
$ yarn add @cointanda/cointanda-contracts
```

#### Usage

###### Artifacts

There are deployment artifacts available in the `deployments/` directory.  This includes:

- Builders
- Proxy Factories
- Comptroller
- ProxyAdmin

Prize Pools and Prize Strategies are not included, as they are created using the Builders.

For example, to pull in the CompoundPrizePoolBuilder artifact:

```javascript
const CompoundPrizePoolBuilder = require('@cointanda/cointanda-contracts/deployments/rinkeby/CompoundPrizePoolBuilder.json')
const {
  abi,
  address,
  receipt
 } = CompoundPrizePoolBuilder
```

###### ABIs

Application Binary Interfaces for all CoinTanda contracts and related contracts are available in the `abis/` directory.

For example, to pull in the PrizePool ABI:

```javascript
const PrizePool = require('@cointanda/cointanda-contracts/abis/PrizePool.json')
```

#### Development

First clone this repository

Install dependencies:

```
$ yarn
```

We make use of [Buidler](https://buidler.dev) and [buidler-deploy](https://github.com/wighawag/buidler-deploy)

###### Deploy Locally

Start a local node and deploy the top-level contracts:

```bash
$ yarn start
```

NOTE: When you run this command it will reset the local blockchain.

###### Connect Locally

When using a local RSK node for test use this code for the node as it has a fix  allowUnlimitedContractSize and gasLimit flags  https://github.com/riflending/rskj/tree/riflending

Start up a [Buidler Console](https://buidler.dev/guides/buidler-console.html):

```bash
$ buidler console --network localhost
```

Now you can load up the deployed contracts using [buidler-deploy](https://github.com/wighawag/buidler-deploy):

```javascript
> await deployments.all()
```

If you want to send transactions, you can get the signers like so:

```javascript
> let signers = await ethers.getSigners()
```

Let's mint some Dai for ourselves:

```javascript
> let dai = await ethers.getContractAt('ERC20Mintable', (await deployments.get('Dai')).address, signers[0])
> await dai.mint(signers[0]._address, ethers.utils.parseEther('10000'))
> ethers.utils.formatEther(await dai.balanceOf(signers[0]._address))
```

###### Deploy to Live Networks

Copy over .envrc.example to .envrc

```
$ cp .envrc.example .envrc
```

Make sure to update the enviroment variables with suitable values.

Now enable the env vars using [direnv](https://direnv.net/docs/installation.html)

```
$ direnv allow
```

Now deploy to a network like so:

```
$ yarn deploy rinkeby
```

It will update the `deployments/` dir.
