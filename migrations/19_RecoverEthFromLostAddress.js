
const RecoverEthFromLostAddress = artifacts.require("RecoverEthFromLostAddress");

module.exports = async function (deployer) {
  await deployer.deploy(RecoverEthFromLostAddress);
  let instance = await RecoverEthFromLostAddress.deployed();
  console.log('RecoverEthFromLostAddress Deployed at address ', instance.address);
};

