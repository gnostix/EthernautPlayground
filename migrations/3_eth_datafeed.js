const EthDataFeed = artifacts.require('EthDataFeed')
const RINKEBY_LINKTOKEN = '0x01be23585060835e02b77ef475b0cc51aa1e0709'

module.exports = async (deployer, network, [defaultAccount]) => {
    // hard coded for rinkeby
   //LinkToken.setProvider(deployer.provider)
   EthDataFeed.setProvider(deployer.provider)
    console.log("account balance: " + defaultAccount)
    if (network.startsWith('rinkeby')) {
      await deployer.deploy(EthDataFeed)
      let dnd = await EthDataFeed.deployed()
    } else if (network.startsWith('mainnet')) {
      console.log("If you're interested in early access to Chainlink VRF on mainnet, please email vrf@chain.link")
    } else {
      console.log("Right now only rinkeby works! Please change your network to Rinkeby")
      // await deployer.deploy(DungeonsAndDragonsCharacter)
      // let dnd = await DungeonsAndDragonsCharacter.deployed()
    }
  }
