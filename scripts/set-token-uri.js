const DungeonsAndDragons = artifacts.require('DungeonsAndDragonsCharacter')
const TOKENID = 0
module.exports = async callback => {
    const dnd = await DungeonsAndDragons.deployed()
    console.log('Let\'s set the tokenURI of your characters')
    const tx = await dnd.setTokenURI(6, "https://gateway.pinata.cloud/ipfs/QmZ6XqyN5Ta8HQBTHjVZZWC3pa1Cv1rDhT8aVhixD8p2kL")
    // const tx1 = await dnd.setTokenURI(1, "https://gateway.pinata.cloud/ipfs/QmeVagr7re2MkoqHgPqNCMMbnoH5kGwc68yMLHB8srL1B1/the-chainlink-elf.json")
    // const tx2 = await dnd.setTokenURI(2, "https://gateway.pinata.cloud/ipfs/QmeVagr7re2MkoqHgPqNCMMbnoH5kGwc68yMLHB8srL1B1/the-chainlink-wizard.json")
    // const tx3 = await dnd.setTokenURI(3, "https://gateway.pinata.cloud/ipfs/QmeVagr7re2MkoqHgPqNCMMbnoH5kGwc68yMLHB8srL1B1/the-chainlink-orc.json")
    console.log(tx)
    callback(tx.tx)
}