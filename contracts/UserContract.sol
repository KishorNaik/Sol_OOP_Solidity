
//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

// User Data Transfer Object (DTO)
struct User{
   string fullName;
   uint memberType;
   uint amount;
}

contract UserMapContract{

   // Storage Container
   mapping(address => User) internal userMapping; // Encapsulation Only Access via Parent to Child Only 

   function getUserDataByPassingUserAddress(address _userAddress) public view returns (string memory fullName,uint memberType,uint amount){
       User memory userStructObj= userMapping[_userAddress];

       return (userStructObj.fullName,userStructObj.memberType,userStructObj.amount);
   }
}

contract UserContract is UserMapContract{ // Inheritance

   // Encapsulation
   address private owner;
   
   constructor(address _contractOwner){
      owner=_contractOwner; // My Address becuase i am going to deploy the contract.
   }

   // Modifiers Validation Purpose
   modifier registerUserValidation(address _registerUserAddress,string memory _fullName,uint _amount){
      bytes memory tempFullName=bytes(_fullName); // Convert String into Bytes to check String is empty or not.
      console.log("Address =>",_registerUserAddress);
      console.log("bytes length =>",tempFullName.length);

      require(_registerUserAddress!=address(0),"Address is required");
      require(tempFullName.length!=0,"Full Name is required");
      require(_amount>=1,"amount should be grether than zero");
      _;
   }

   // Private Function // Encapsulation // Hide Logic
   // Assign member type as per How User Deposit amount during the registration.
   function assignMemberTypeWithRegistration(address _registerUserAddress, string memory _fullName,uint _amount) private {

      if(_amount>=1 ether && _amount <=5 ether){ // Silver Member Type (1)
         userMapping[_registerUserAddress]=User(_fullName,1,_amount); // Insert Struct Object into Mapping
         console.log("Silver Member => ",_fullName);
      }
      else if(_amount>=6 ether && _amount<=100 ether){ // Gold Member Type (2)
          userMapping[_registerUserAddress]=User(_fullName,2,_amount); // Insert Struct Object into Mapping
          console.log("Gold Member => ",_fullName);
      }
      else // Platinum Member (3)
      {
          userMapping[_registerUserAddress]=User(_fullName,3,_amount); // Insert Struct Object into Mapping
           console.log("Platinum Member => ",_fullName); 
      }
   }

   // Public Function
   // Get Owner Address
   function getOwnerAddress() public view returns(address){
      require(owner==msg.sender,"Only owner can access the function");

      return owner;
   }

   // Get Contract Address
   function getUserContractAddress() public view returns (address){
      return address(this);
   }

   // User registration
   function registerUser(address _registerUserAddress, string memory _fullName,uint _amount) public registerUserValidation(_registerUserAddress,_fullName,_amount){
      assignMemberTypeWithRegistration(_registerUserAddress,_fullName,_amount);

      console.log("Register User =>",userMapping[_registerUserAddress].fullName);
   }

}

