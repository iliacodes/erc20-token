import { ethers } from 'hardhat';

async function main() {
  const name = "Bubbles";
  const symbol = "BUBS";
  const decimals = 18;
  const totalSupply = ethers.utils.parseEther("1000");

  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const Token = await ethers.getContractFactory("Token");
  const token = await Token.deploy(name, symbol, decimals, totalSupply);

  console.log("Token address:", token.address);

  await token.deployed();

  console.log("Contract deployed successfully!");

}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });