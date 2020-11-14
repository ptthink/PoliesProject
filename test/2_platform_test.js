// test/Box.proxy.test.js
// Load dependencies
const { expect, assert } = require('chai');
const { deployer, deployProxy } = require('@openzeppelin/truffle-upgrades');
const FinanceOrg = artifacts.require("FinanceOrg");
const PoliesPlatform = artifacts.require("PoliesPlatform");
const Address = artifacts.require("Address");

// Start test block
contract('PoliesPlatform', async accounts => {
  it('apply finance org', async function () {
    const name = web3.utils.asciiToHex("testOrgName");
    const url1 = web3.utils.asciiToHex("https://testOrgName.com");
    const url2 = web3.utils.asciiToHex("");
    const platform = await PoliesPlatform.new();
    platform.initialize();
    const org = await FinanceOrg.new();
    await org.initialize(name, url1, url2, platform.address);

    await platform.applyToBeAFinanceOrg(org.address);
    const orgId = await platform.getOrgId(org.address);
    assert.isTrue(orgId > 0, "apply org failed");
  });
});