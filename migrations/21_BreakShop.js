
const BreakShop = artifacts.require("BreakShop");

module.exports = async function (deployer) {
  await deployer.deploy(BreakShop);
  let instance = await BreakShop.deployed();
  console.log('BreakShop Deployed at address ', instance.address);
};

