import { expect } from "chai";
import { ethers } from "hardhat";

// describe("Greeter", function () {
//   it("Should return the new greeting once it's changed", async function () {
//     const Greeter = await ethers.getContractFactory("Greeter");
//     const greeter = await Greeter.deploy("Hello, world!");
//     await greeter.deployed();

//     expect(await greeter.greet()).to.equal("Hello, world!");

//     const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

//     // wait until the transaction is mined
//     await setGreetingTx.wait();

//     expect(await greeter.greet()).to.equal("Hola, mundo!");
//   });
// });


describe("OOP-Example", function () {
  it("#Test1 - User Contract", async function () {
    
    try
    {
      const [owner,add1,add2]=await ethers.getSigners();

      // Contract Deployment
      const UserContract= await ethers.getContractFactory("UserContract");
      const userContract= await UserContract.deploy(owner.address);
      await userContract.deployed();

      const WithdrawContract= await ethers.getContractFactory("WithdrawContract");
      const withdrawContract= await WithdrawContract.deploy(userContract.address); // Pass the User Contract Address.
      await withdrawContract.deployed();

      // Assert
      await userContract.connect(add1).registerUser(add1.address,"Kishor Naik",ethers.utils.parseEther("5"));
      await userContract.connect(add2).registerUser(add2.address,"Eshaan Naik",ethers.utils.parseEther("10"));

      var getValue:number=await withdrawContract.callStatic.withdraw(add1.address,ethers.utils.parseEther("2"));
      console.log("get Value =>",getValue.toString());

      // Test
      expect(true).to.equal(true);
    }
    catch(ex)
    {
      console.log((<Error>ex).message);
      expect(false).to.equal(true);
    }
  });
});