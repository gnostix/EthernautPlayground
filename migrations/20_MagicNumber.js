
const MagicNumber = artifacts.require("MagicNumber");

module.exports = async function (deployer) {
  await deployer.deploy(MagicNumber);
  let instance = await MagicNumber.deployed();
  console.log('MagicNumber Deployed at address ', instance.address);
};

