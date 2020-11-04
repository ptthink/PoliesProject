// test/Box.proxy.test.js
// Load dependencies
const { expect, assert } = require('chai');
const { deployProxy } = require('@openzeppelin/truffle-upgrades');
const FinanceOrg = artifacts.require("FinanceOrg");
const Address = artifacts.require("Address");

// Start test block
contract('FinanceOrg', async accounts => {
  it('create finance org', async function () {
    await deployer.deploy(Address);
    await deployer.link(Address, FinanceOrg);
    const name = web3.utils.asciiToHex("testOrgName");
    const url1 = web3.utils.asciiToHex("https://testOrgName.com");
    const url2 = web3.utils.asciiToHex("");
    const platform= web3.eth.accounts.create();
    const org = await deployProxy(FinanceOrg, [name, url1, url2,platform.address]);
    const orgInfo= await org.getInfo();
    assert.equal(orgInfo[0],platform.address, "platform check failed");
    assert.equal(orgInfo[1],name, "name check failed");
    assert.equal(orgInfo[2],url1, "url1 check failed");
    assert.equal(orgInfo[3],url2, "url2 check failed");
    assert.equal(orgInfo[4],0, "level check failed");
    assert.isTrue(orgInfo[5]>0, "createAt check failed");
    assert.isTrue(orgInfo[6].eq(0), "joinAt check failed");
    assert.equal(orgInfo[7],true, "valid check failed");
     
  });

  it('update cda price', async function () {
    const usdt = await UsdtToken.deployed();
    const cda = await CDAToken.deployed();
    const [a1, a2, a3] = accounts;
    await usdt.transfer(a1, 1000);
    await cda.transfer(a1, 200);
    await this.cube.updateCdaPrice(10000);

    let priceResult = await this.cube.getLocalUintVariable(8);
    assert.isTrue(priceResult.eq(web3.utils.toBN(10000)), "cda price should be 10000");
  });
});