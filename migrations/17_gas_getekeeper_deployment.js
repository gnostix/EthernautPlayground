
const SolveGatekeeperTwo = artifacts.require("SolveGatekeeperTwo");

module.exports = async function (deployer) {
  await deployer.deploy(SolveGatekeeperTwo);
  let instance = await SolveGatekeeperTwo.deployed();
  console.log('SolveGatekeeperTwo Deployed at address ', instance.address);
};

