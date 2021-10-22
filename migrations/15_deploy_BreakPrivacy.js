
const BreakPrivacy = artifacts.require("BreakPrivacy");

module.exports = async function (deployer) {
  await deployer.deploy(BreakPrivacy);
  let instance = await BreakPrivacy.deployed();
  console.log('BreakPrivacy Deployed at address ', instance.address);
};

