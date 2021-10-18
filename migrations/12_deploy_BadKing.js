
const BadKing = artifacts.require("BadKing");

module.exports = async function (deployer) {
  await deployer.deploy(BadKing);
  let instance = await BadKing.deployed();
  console.log('BadKing Deployed at address ', instance.address);
};

