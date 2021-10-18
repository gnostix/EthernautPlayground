
const UintWrapping = artifacts.require("UintWrapping");

module.exports = async function (deployer) {
  await deployer.deploy(UintWrapping);
  let instance = await UintWrapping.deployed();
  console.log('UintWrapping Deployed at address ', instance.address);
};

