// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import { ISolidStateERC20 } from "@solidstate/contracts/token/ERC20/ISolidStateERC20.sol";
import  "@solidstate/contracts/security/reentrancy_guard/ReentrancyGuard.sol";
import { TExample0, TExample0Pool } from "../libraries/Structs.sol";
import { Math } from "@openzeppelin/contracts/utils/math/Math.sol";
import '@solidstate/contracts/access/ownable/OwnableInternal.sol';
import { LibExample0 } from "../libraries/LibExample0.sol";
import { Modifiers } from "../libraries/Modifiers.sol";
import "../libraries/Errors.sol";

contract Example0 is Modifiers, OwnableInternal, ReentrancyGuard {

    event HANDLE_INIT_POOL(address indexed,uint256);
    event HANDLE_REGISTER(address indexed,uint256);

    function initPool(
        TExample0Pool memory _params
    )
        external 
        onlyOwner 
        IsContract(_params.tokenAddress)
    {
        LibExample0.layout().example0Pool = _params;
        emit HANDLE_INIT_POOL(_params.tokenAddress,block.timestamp);
    }

    function register(
        string memory _name
    )
        external 
        payable 
        NotContract(msg.sender) 
        nonReentrant 
    {
        LibExample0.Layout storage le = LibExample0.layout();

        if(le.user0[msg.sender].isExist){revert Invalid_Action();}
        if(msg.value < 1 ether){revert Invalid_Price();}

        le.user0[msg.sender] = TExample0({
            isExist: true,
            name: _name
        });

        unchecked {
            le.example0Pool.userCount += 1;
        }
        
        le.example0Pool.userlist.push(msg.sender);

        emit HANDLE_REGISTER(msg.sender,block.timestamp);
    }

    function getUser(
        address _user
    )
        public 
        view 
        returns (TExample0 memory) 
    {
        return LibExample0.layout().user0[_user];
    }

    function getPool(
    )
        public 
        view 
        returns (TExample0Pool memory) 
    {
        return LibExample0.layout().example0Pool;
    }
   
}