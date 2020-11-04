const PoliesPlatform = artifacts.require("PoliesPlatform");
const SafeMath = artifacts.require("SafeMath");
const { deployProxy } = require('@openzeppelin/truffle-upgrades');

module.exports = async function (deployer) {
  deployer.deploy(SafeMath);
  deployer.link(SafeMath, PoliesPlatform);
  await deployProxy(PoliesPlatform);
};
