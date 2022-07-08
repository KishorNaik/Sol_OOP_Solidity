//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./UserContract.sol";
import "./WithdrawalInterestStrategy.sol";

contract WithdrawContract{

    UserMapContract private userMapContract; // Encapsuation

    constructor(address _userMapContractAddress){
        userMapContract=UserMapContract(_userMapContractAddress); // Get Referance Object of UserMap 
    }


    function withdraw(address _userAddress,uint _amount) public returns(uint){

        IInterestOnWithdrwal interestOnWithdrwal; // Abstract Interface
        uint interestAmount;
        uint balanceAmount;
        uint finalAmount;
        
        // Mapping log
        console.log("Input Address =>",_userAddress);
        console.log("Amount =>",_amount);

        // Get User Data by Passing User Address
        (string memory fullName,uint memberType, uint amount)=userMapContract.getUserDataByPassingUserAddress(_userAddress);

        // Get User Information
        console.log("Member Type => ",memberType);
        console.log("Pre Balance => ",amount);
        console.log("User Full Name =>",fullName);

        // Get Update Balance Amount
        balanceAmount=amount;
    
        if(memberType==1){
            
            if(_amount>=balanceAmount){
                revert("insufficient balance");
            }

            console.log("Silver");
            interestOnWithdrwal=new SilverMember();  // Polymorphisam // Child

            interestAmount=interestOnWithdrwal.calculate(_amount);
           
            balanceAmount=balanceAmount + interestAmount;
           
            finalAmount=balanceAmount - _amount;

            console.log("Actual User Balance", _userAddress.balance);
        }
        else if(memberType==2){
            
            if(_amount>=balanceAmount){
                revert("insufficient balance");
            }

            console.log("Gold Member");
            interestOnWithdrwal=new GoldMember();  // Polymorphisam // Child

            interestAmount=interestOnWithdrwal.calculate(_amount);
            balanceAmount=balanceAmount + interestAmount;
            finalAmount=balanceAmount - _amount;
        }
        else if(memberType==3)
        {
            if(_amount>=balanceAmount){
                revert("insufficient balance");
            }

            console.log("Platinum Member");
            interestOnWithdrwal=new PlatinumMember();  // Polymorphisam // Child
            
            interestAmount=interestOnWithdrwal.calculate(_amount);
            balanceAmount=balanceAmount + interestAmount;
            finalAmount=balanceAmount - _amount;
        }

         console.log("interestAmount =>",interestAmount);
         console.log("balanceAmount =>",balanceAmount);
         console.log("finalAmount =>",finalAmount);

        return finalAmount;
    }   
}