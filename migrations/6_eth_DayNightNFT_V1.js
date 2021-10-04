const RINKEBY_VRF_COORDINATOR = '0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B'
const RINKEBY_LINKTOKEN = '0x01be23585060835e02b77ef475b0cc51aa1e0709'
const RINKEBY_KEYHASH = '0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311'

const DayNightNFT_V1 = artifacts.require("DayNightNFT_V1_1");

module.exports = async function (deployer) {
  await deployer.deploy(DayNightNFT_V1, RINKEBY_VRF_COORDINATOR, RINKEBY_LINKTOKEN, RINKEBY_KEYHASH);
  let instance = await DayNightNFT_V1.deployed();
  console.log('DayNightNFT_V1 Deployed at address ', instance.address);
};

