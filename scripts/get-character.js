const DungeonsAndDragons = artifacts.require('DungeonsAndDragonsCharacter')

module.exports = async callback => {
    const dnd = await DungeonsAndDragons.deployed()
    console.log('Let\'s get the overview of your character')
    const overview = await dnd.characters(3)
    console.log(overview)
    callback(overview.tx)
}