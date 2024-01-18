// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract XXToken is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    
    constructor(
        address _owner
    )
        ERC20("XXToken", "XX")
        Ownable(_owner)
        ERC20Permit("XXToken")
    {
        _mint(_owner, 1_000_000_000 * (10 ** decimals()));
    }

    function mint(
        address _to, 
        uint256 _amount
    ) 
        public 
        onlyOwner 
    {
        _mint(_to, _amount);
    }
}