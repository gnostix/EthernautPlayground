
const FlipCoinAnapoda = artifacts.require("FlipCoinAnapoda");

module.exports = async function (deployer) {
  await deployer.deploy(FlipCoinAnapoda);
  let instance = await FlipCoinAnapoda.deployed();
  console.log('FlipCoinAnapoda Deployed at address ', instance.address);
};

