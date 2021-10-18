
const ReEntrancyAttack = artifacts.require("ReEntrancyAttack");

module.exports = async function (deployer) {
  await deployer.deploy(ReEntrancyAttack);
  let instance = await ReEntrancyAttack.deployed();
  console.log('ReEntrancyAttack Deployed at address ', instance.address);
};

