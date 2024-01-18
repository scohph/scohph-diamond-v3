// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

struct TExample0 {
    bool isExist;
    string name;
}

struct TExample0Pool{
    bool isActive;
    uint256 userCount;
    address tokenAddress;
    address[] userlist;
}