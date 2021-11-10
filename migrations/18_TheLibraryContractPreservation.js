
const TheLibraryContractPreservation = artifacts.require("TheLibraryContractPreservation");

module.exports = async function (deployer) {
  await deployer.deploy(TheLibraryContractPreservation);
  let instance = await TheLibraryContractPreservation.deployed();
  console.log('TheLibraryContractPreservation Deployed at address ', instance.address);
};

