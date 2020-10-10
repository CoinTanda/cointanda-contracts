const { expect } = require('chai')

const revertedWith = async (promise, errMsg) => {
  try {
    await promise
    assert.fail('transaction not reverted');
  } catch (err) {
    expect(err.message).to.include(errMsg)
  }
}

const notRevertedWith = async (promise, errMsg) => {
  try {
    await promise
    assert.fail('transaction not reverted');
  } catch (err) {
    expect(err.message).not.to.include(errMsg)
  }
}


module.exports  = { revertedWith, notRevertedWith }