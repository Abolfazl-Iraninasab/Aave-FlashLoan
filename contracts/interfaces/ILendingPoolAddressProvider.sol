// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

interface ILendingPoolAddressesProvider {
    function getLendingPool() external view returns (address);
}
