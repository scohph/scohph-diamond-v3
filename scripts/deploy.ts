import hre, { ethers } from "hardhat";

const { FacetList, InitParams } = require("../libs/facets.ts");
const { getSelectors, FacetCutAction } = require("../libs/diamond.js");

async function main() {
  console.dir(FacetList);
  console.log("");
  const [deployer] = await ethers.getSigners();

  const diamondFactory = await ethers.getContractFactory("Diamond");
  const diamondContract = await diamondFactory.deploy();
  await diamondContract.deployed();
  console.log("Diamond contract was deployed successfully. 🤩👍");
  console.log("");

  const xxTokenFactory = await ethers.getContractFactory("XXToken");
  const xxTokenContract = await xxTokenFactory.deploy(deployer.address);
  await xxTokenContract.deployed();
  console.log("XX token contract was deployed successfully. 🤩👍");
  console.log("");

  const cut = [];
  for (const FacetName of FacetList) {
    const Facet = await ethers.getContractFactory(FacetName);
    // @ts-ignore
    const facet = await Facet.deploy();
    await facet.deployed();
    console.log(`${FacetName} facet deployed 👍 => ${facet.address}`);
    cut.push({
      target: facet.address,
      action: FacetCutAction.Add,
      selectors: getSelectors(facet),
    });
  }

  const addressZero = ethers.constants.AddressZero;
  const tx = await diamondContract.diamondCut(cut, addressZero, "0x");
  await tx.wait();

  const exampleFacet = await ethers.getContractAt(
    "Example0",
    diamondContract.address
  );

  const initPool = await exampleFacet.connect(deployer).initPool(InitParams);
  await initPool.wait();

  const register = await exampleFacet
    .connect(deployer)
    .register("SCOHPH", { value: ethers.utils.parseEther("2") });
  await register.wait();

  console.log("");
  console.log(await exampleFacet.getPool());
  console.log("");
  console.log(await exampleFacet.getUser(deployer.address));

  let contractAddresses = new Map<string, string>();
  contractAddresses.set("DIAMOND => ", diamondContract.address);
  contractAddresses.set("XX TOKEN => ", xxTokenContract.address);
  contractAddresses.set("DEPLOYER => ", deployer.address);
  console.table(contractAddresses);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
