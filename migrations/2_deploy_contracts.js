const MemberApp = artifacts.require("MemberApp");
const SuperApp = artifacts.require("SuperApp");

module.exports = function(deployer) {
  // deployer.deploy(MemberApp);
  // deployer.link(MemberApp, SuperApp);
  deployer.deploy(SuperApp);
};
