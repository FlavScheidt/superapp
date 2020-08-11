const ConvertLib = artifacts.require("MemberApp");
const MetaCoin = artifacts.require("SuperApp");

module.exports = function(deployer) {
  deployer.deploy(MemberApp);
  deployer.link(MemberApp, SuperApp);
  deployer.deploy(SuperApp);
};
