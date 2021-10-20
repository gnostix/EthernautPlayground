
const MyBuilding = artifacts.require("MyBuilding");

module.exports = async function (deployer) {
  await deployer.deploy(MyBuilding);
  let instance = await MyBuilding.deployed();
  console.log('MyBuilding Deployed at address ', instance.address);
};

