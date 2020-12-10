const { expect } = require('chai')

const revertedWith = async (promise, errMsg) => {
  try {
    await promise
    assert.fail('transaction not reverted');
  } catch (err) {
    if(err.value) {
      try {
        let value = await err.value;
        assert.fail(`transaction not reverted: ${value}`);
      } catch(errValue) {
        expect(errValue.message).to.include(errMsg)
      }
    } else {
      expect(err.message).to.include(errMsg)
    }
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