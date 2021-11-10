
const SolveGatekeeperOne = artifacts.require("SolveGatekeeperOne");

module.exports = async function (deployer) {
  await deployer.deploy(SolveGatekeeperOne);
  let instance = await SolveGatekeeperOne.deployed();
  console.log('SolveGatekeeperOne Deployed at address ', instance.address);
};

