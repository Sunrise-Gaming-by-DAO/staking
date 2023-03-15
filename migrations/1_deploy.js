const Token = artifacts.require("Token");
const MasterChef = artifacts.require("MasterChef");

module.exports = async (deployer) => {
    const maxSupply     = web3.utils.toWei(process.env.TOKEN_MAX_SUPPLY, 'ether');
    const initialSupply = web3.utils.toWei(process.env.TOKEN_INITIAL_SUPPLY, 'ether');
    const tokenPerBlock = web3.utils.toWei(process.env.TOKEN_PER_BLOCK, 'ether');

    await deployer.deploy(Token, process.env.TOKEN_NAME, process.env.TOKEN_SYMBOL, maxSupply, initialSupply, process.env.TOKEN_WALLET);

    await deployer.deploy(MasterChef, Token.address, process.env.FEE_WALLET, tokenPerBlock, process.env.START_BLOCK);

    const token = await Token.deployed();

    await token.transferOwnership(MasterChef.address);
};