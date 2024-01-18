// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Errors.sol";

abstract contract Modifiers {

    modifier NotContract(
        address _address
    ) 
    {
        if(_address == address(0)){revert Address_Cannot_Be_Zero(_address);}
        uint256 size;
        assembly {
            size := extcodesize(_address)
        }
        if(size > 0){revert Address_Is_A_Contract(_address);}
        _;
    }
    
    modifier IsContract(
        address _address
    ) 
    {
        if(_address == address(0)){revert Address_Cannot_Be_Zero(_address);}
        
        uint256 size;
        assembly {
            size := extcodesize(_address)
        }
        
        if(size == 0){revert Address_Is_A_Not_Contract(_address);}
        _;
    }
}