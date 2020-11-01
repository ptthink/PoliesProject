const PoliesPlatform = artifacts.require("PoliesPlatform");
const SafeMath = artifacts.require("SafeMath");

module.exports = function (deployer) {
  deployer.deploy(SafeMath);
  deployer.link(SafeMath, PoliesPlatform);
  deployer.deploy(PoliesPlatform);
};
