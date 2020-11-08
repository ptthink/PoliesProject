// test/Box.proxy.test.js
// Load dependencies
const { expect, assert } = require('chai');
const { deployer, deployProxy } = require('@openzeppelin/truffle-upgrades');
const FinanceOrg = artifacts.require("FinanceOrg");
const PoliesPlatform = artifacts.require("PoliesPlatform");
const Address = artifacts.require("Address");

// Start test block
contract('FinanceOrg', async accounts => {
  it('create finance org', async function () {
    const name = web3.utils.asciiToHex("testOrgName");
    const url1 = web3.utils.asciiToHex("https://testOrgName.com");
    const url2 = web3.utils.asciiToHex("");
    const platform = await PoliesPlatform.new();
    const org = await FinanceOrg.new();
    await org.initialize(name, url1, url2, platform.address);
    const orgInfo = await org.getInfo();
    assert.equal(orgInfo[0], platform.address, "platform check failed");
    assert.isTrue(orgInfo[1].includes(name), "name check failed");
    assert.isTrue(orgInfo[2].includes(url1), "url1 check failed");
    assert.isTrue(orgInfo[3].includes(url2), "url2 check failed");
    assert.equal(orgInfo[4], 0, "level check failed");
    assert.isTrue(orgInfo[5] > 0, "createAt check failed");
    console.log("orgInfo[6]",orgInfo[6]);
    assert.isTrue(orgInfo[6].eq(web3.utils.toBN(0)), "joinAt check failed");
    assert.equal(orgInfo[7], false, "valid check failed");

  });
});