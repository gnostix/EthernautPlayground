
const Delegate = artifacts.require("Delegate");
const MyDelegation = artifacts.require("MyDelegation");

const alxAddr = '0x82688Ed8427E2dB9fb5F2b9527361f55B40D90D5';


module.exports = async function (deployer) {
  await deployer.deploy(Delegate, alxAddr);
  let instance1 = await Delegate.deployed();
  console.log('Delegate Deployed at address ', instance1.address);

  await deployer.deploy(MyDelegation, instance1.address);
  let instance2 = await MyDelegation.deployed();
  console.log('Delegation Deployed at address ', instance2.address);
};

