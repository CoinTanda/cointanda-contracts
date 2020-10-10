
const buidler = require('@nomiclabs/buidler')

const format = buidler.ethers.provider.formatter.formats
format.receipt['root'] = format.receipt['logsBloom']
Object.assign(buidler.ethers.provider.formatter, { format: format })


module.exports = buidler