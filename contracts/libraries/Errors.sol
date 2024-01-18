// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/**
 * @dev Revert with an error when an account being called as an assumed
 *      contract does not have code and returns no data.
 * @param account The account that should contain code.
 */
   error Address_Is_A_Contract(address account);
   error Address_Is_A_Not_Contract(address account);
   error Address_Cannot_Be_Zero(address account);

   error Insufficient_Allowance();
   error Insufficient_Balance();
   error Invalid_Action();
   error Invalid_Price();
   error Overflow_0x11();
   error Paused();

    