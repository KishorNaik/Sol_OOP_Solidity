
//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

// Abstract
interface IInterestOnWithdrwal{
   function calculate(uint _amount) external pure returns(uint);
}

// Inheritance
contract SilverMember is IInterestOnWithdrwal{
    
    function calculate(uint _amount) override external pure returns(uint){
        return _amount * 2 /100;
    }
}


// Inheritance
contract GoldMember is IInterestOnWithdrwal{
    
    function calculate(uint _amount) override external pure returns(uint){
        return _amount * 5 /100;
    }
}

// Inheritance
contract PlatinumMember is IInterestOnWithdrwal{
    
    function calculate(uint _amount) override external pure returns(uint){
        return _amount * 10 /100;
    }
}


