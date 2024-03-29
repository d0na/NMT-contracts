import { ethers } from "hardhat";

async function main() {

  const Contract = await ethers.getContractFactory("JacketNMT");
  const contract = await Contract.deploy();

  await contract.deployed();

  console.log(
    `Deployed JacketMNT contract ${contract.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
