// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import { TExample0, TExample0Pool } from "./Structs.sol";

library LibExample0 {
    bytes32 internal constant STORAGE_SLOT = keccak256('storage.library.example0.com');

    struct Layout {
        mapping(address => TExample0) user0;
        TExample0Pool example0Pool;
    }

    function layout() internal pure returns (Layout storage l) {
        bytes32 slot = STORAGE_SLOT;
        assembly {
            l.slot := slot
        }
    }
}