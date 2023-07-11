import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";
import { string } from "hardhat/internal/core/params/argumentTypes";
const ZERO_ADDRESS = "0x0000000000000000000000000000000000000000";

describe("JacketMNT", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setu-p once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployJacketNMT() {
    // Contracts are deployed using the first signer/account by default
    const [owner] = await ethers.getSigners();
    const JacketMNT = await ethers.getContractFactory("JacketMNT");
    const jacketMNT = await JacketMNT.deploy();
    const JacketAsset = await ethers.getContractFactory("JacketAsset");
    const jacketAsset = await JacketAsset.deploy(owner.address);
    return { jacketMNT, owner, jacketAsset };
  }

  describe("MNT", function () {
    it("Should revert if the miner is 0 address", async function () {
      // valid alternative to ZERO_ADDRESS is
      // ethers.constants.AddressZero
      const { jacketMNT } = await loadFixture(deployJacketNMT);
      expect(jacketMNT.mint(ZERO_ADDRESS)).to.be.revertedWith(
        "Ownable: new owner is the zero address"
      );
    });

    it("Should be able to be minted and owned", async function () {
      // valid alternative ethers.constants.AddressZero
      const { jacketMNT, owner } = await loadFixture(deployJacketNMT);
      await jacketMNT.mint(owner.address);
      expect(await jacketMNT.owner()).to.equal(owner.address);
    });

    it("Should be....", async function () {
      const { jacketMNT, owner } = await loadFixture(deployJacketNMT);
      const Minted = {
        owner: owner.address,
        tokenId: 921600849408656576225127304129841157239410643646,
      };

      const txResponse = await jacketMNT.callStatic.mint(owner.address);

      // console.log("txResponse", txResponse);
    });

    it("Should be minted and trigger events with the right onwer and tokenId", async function () {
      const { jacketMNT, owner } = await loadFixture(deployJacketNMT);
      const Minted = {
        owner: owner.address,
        tokenId: 921600849408656576225127304129841157239410643646,
      };

      const txResponse = await jacketMNT.mint(owner.address);
      const txReceipt = await txResponse.wait();

      // console.log("txResponse", txResponse);
      // console.log("txReceipt", txReceipt);

      const transferEvent = txReceipt.events;
      const OwnershipTransferred = transferEvent && transferEvent[0].args;

      const Transfer = transferEvent && transferEvent[1].args;
      const newOwner = OwnershipTransferred && OwnershipTransferred.newOwner;
      const tokenId: Number = Transfer && Transfer.tokenId;
      // console.log("OwnershipTransferred Event", OwnershipTransferred && OwnershipTransferred)
      // console.log("Transfer Event", Transfer && Transfer[1].args)
      // console.log("NewOwner", newOwner);
      // console.log("tokenId", tokenId);

      expect(newOwner).to.equal(Minted.owner);
      expect(Number(tokenId)).to.equal(Minted.tokenId);
    });

    it("Should minted two assets with two differents tokenIds and the same owner ", async function () {
      const { jacketMNT, owner } = await loadFixture(deployJacketNMT);
      const Minted1 = {
        from: "0x0000000000000000000000000000000000000000",
        owner: owner.address,
        tokenId: "921600849408656576225127304129841157239410643646",
      };

      const Minted2 = {
        from: "0x0000000000000000000000000000000000000000",
        owner: owner.address,
        tokenId: "1048441399354366663447528331587451327875741636968",
      };

      await expect(jacketMNT.mint(owner.address))
        .to.emit(jacketMNT, "Transfer")
        // from, to, tokenId
        .withArgs(Minted1.from, Minted1.owner, Minted1.tokenId);
      await expect(jacketMNT.mint(owner.address))
        .to.emit(jacketMNT, "Transfer")
        // from, to, tokenId
        .withArgs(Minted2.from, Minted2.owner, Minted2.tokenId);
    });

    it("Should be named 'Mutable Jacket for a PUB Decentraland UniPi Project'", async function () {
      const { jacketMNT } = await loadFixture(deployJacketNMT);
      expect(await jacketMNT.name()).to.equal(
        "Mutable Jacket for a PUB Decentraland UniPi Project"
      );
    });

    it("Should have symbol named 'PUBMNTJACKET'", async function () {
      const { jacketMNT } = await loadFixture(deployJacketNMT);
      expect(await jacketMNT.symbol()).to.equal("PUBMNTJACKET");
    });

    it("Should have tokenUri 'filename.glb'", async function () {
      const { jacketMNT, owner } = await loadFixture(deployJacketNMT);
      const Minted = {
        owner: owner.address,
        tokenId: "921600849408656576225127304129841157239410643646",
        uri: "filename.glb",
      };

      await jacketMNT.mint(owner.address);
      expect(
        await jacketMNT.ownerOf(
          "921600849408656576225127304129841157239410643646"
        )
      ).to.be.equal(Minted.owner);
      expect(
        await jacketMNT.tokenURI(
          "921600849408656576225127304129841157239410643646"
        )
      ).to.equal(Minted.uri);
    });

    //
    // it("Should have address....", async function () {
    // const { jacketMNT, owner } = await loadFixture(deployJacketNMT);
    // const Minted = {
    // owner: owner.address,
    // tokenId: "921600849408656576225127304129841157239410643646",
    // uri: "filename.glb",
    // };
    //
    // await jacketMNT.mint(owner.address)
    //
    //console.log(await jacketMNT.getJacketAddress(
    //"921600849408656576225127304129841157239410643646"))
    // expect(
    // await jacketMNT.getJacketAddress(
    // "921600849408656576225127304129841157239410643646"
    // )
    // ).to.be.equal("0xa16e02e87b7454126e5e10d957a927a7f5b5d2be");
    // });
    //
    it("Should be owned by the owner associated with the TokenId", async function () {
      const { jacketMNT, owner } = await loadFixture(deployJacketNMT);
      const Minted = {
        owner: owner.address,
        tokenId: "921600849408656576225127304129841157239410643646",
        uri: "filename.glb",
      };

      await jacketMNT.mint(owner.address);
      expect(
        await jacketMNT.ownerOf(
          "921600849408656576225127304129841157239410643646"
        )
      ).to.be.equal(Minted.owner);
    });

    // it("Should set the right owner", async function () {
    //   const { lock, owner } = await loadFixture(deployOneYearLockFixture);

    //   expect(await lock.owner()).to.equal(owner.address);
    // });

    // it("Should receive and store the funds to lock", async function () {
    //   const { lock, lockedAmount } = await loadFixture(
    //     deployOneYearLockFixture
    //   );

    //   expect(await ethers.provider.getBalance(lock.address)).to.equal(
    //     lockedAmount
    //   );
    // });

    // it("Should fail if the unlockTime is not in the future", async function () {
    //   // We don't use the fixture here because we want a different deployment
    //   const latestTime = await time.latest();
    //   const Lock = await ethers.getContractFactory("Lock");
    //   await expect(Lock.deploy(latestTime, { value: 1 })).to.be.revertedWith(
    //     "Unlock time should be in the future"
    //   );
    // });
  });

  describe("ABAC", function () {
    async function deployABACEnviroment() {
      // Contracts are deployed using the first signer/account by default
      const [owner] = await ethers.getSigners();
      // Pub Attribute Manager contract
      const PubAMContract = await ethers.getContractFactory("PubAM");
      const pubAm = await PubAMContract.deploy();
      // Pip Policy information point contract
      const Pip = await ethers.getContractFactory("PolicyInformationPoint");
      const pip = await Pip.deploy(pubAm.address);
      // Pdp Policy decision point contract
      const Pdp = await ethers.getContractFactory("PolicyDecisionPoint");
      const pdp = await Pip.deploy(pubAm.address);
      return { pip, owner, pubAm, pdp };
    }

    describe("PubAM", function () {
      it("Should return a list of allowed colors ['red','green'] by the brand Pub", async function () {
        const { pubAm } = await loadFixture(deployABACEnviroment);
        const pubAmTransaction = await pubAm.callStatic.allowedColorList();

        await expect(pubAmTransaction[0]).to.be.equals("red");
        await expect(pubAmTransaction[1]).to.be.equals("green");
      });

      it("Should return a list of authorized tailors ['mario','pino'] by the brand Pub", async function () {
        const { pubAm } = await loadFixture(deployABACEnviroment);
        const pubAmTransaction = await pubAm.callStatic.authorizedTailorList();

        await expect(pubAmTransaction[0]).to.be.equals("mario");
        await expect(pubAmTransaction[1]).to.be.equals("pino");
      });
    });

    describe("PIP", function () {
      it("Should create a valid PIP", async function () {
        const { pip } = await loadFixture(deployABACEnviroment);
        // console.log("pip address", pip.address);
        await expect(pip.address).to.be.eq(
          "0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9"
        );
      });

      it("Should returns Pip's Pub list of allowed colour list", async function () {
        const { pip, owner } = await loadFixture(deployABACEnviroment);

        const pubAmTransaction = await pip.callStatic.pubAllowedColorList();

        await expect(pubAmTransaction[0]).to.be.equals("red");
        await expect(pubAmTransaction[1]).to.be.equals("green");
      });
    });

    describe("PDP", function () {
      // JacketMNT.address : 0x5FbDB2315678afecb367f032d93F642f64180aa3
      // pip.address 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9
      // JacketAsset address: 0xa16e02e87b7454126e5e10d957a927a7f5b5d2be

      it("Should change the color Jacket to 'green' by the tailor 'mario' ", async function () {
        const { jacketAsset } = await loadFixture(deployJacketNMT);
        await loadFixture(deployABACEnviroment);
        // const tx = await jacketAsset.changeColor("red", "mario");
        // let receipt = await tx.wait();
        // const events = receipt.events?.filter((x) => {return x.event == "ChangedColor"})

        // console.log("receipt",events);
        // console.log(tx);
        await expect(jacketAsset.changeColor("green", "mario"))
          .to.emit(jacketAsset, "ChangedColor")
          .withArgs("green");
      });

      it("Should change the color Jacket to 'red' by the tailor 'mario' ", async function () {
        const { jacketAsset } = await loadFixture(deployJacketNMT);
        await loadFixture(deployABACEnviroment);
        await expect(jacketAsset.changeColor("red", "mario"))
          .to.emit(jacketAsset, "ChangedColor")
          .withArgs("red");
      });

      it("Should be reverted when is trying to change the color Jacket to 'yellow' by the tailor 'mario' ", async function () {
        const { jacketAsset } = await loadFixture(deployJacketNMT);
        await loadFixture(deployABACEnviroment);
        await expect(jacketAsset.changeColor("yellow", "mario")).to.be
          .revertedWithoutReason;
      });

      it("Should revert the transaction when it is trying to change the color of the Jacket to 'red'  by the tailor 'franco' that it is not allowed ", async function () {
        const { jacketAsset } = await loadFixture(deployJacketNMT);
        await loadFixture(deployABACEnviroment);
        await expect(jacketAsset.changeColor("red", "franco")).to.be
          .revertedWithoutReason;
      });
    });
  });
});
