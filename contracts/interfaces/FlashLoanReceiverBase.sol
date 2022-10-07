// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "./ILendingPool.sol";
import "./ILendingPoolAddressProvider.sol";
import "./IFlashLoanReceiver.sol";

abstract contract FlashLoanReceiverBase is IFlashLoanReceiver {
  using SafeERC20 for IERC20;

  ILendingPoolAddressesProvider public immutable ADDRESSES_PROVIDER;
  ILendingPool public immutable LENDING_POOL;

  constructor(ILendingPoolAddressesProvider provider) {
    ADDRESSES_PROVIDER = provider;
    LENDING_POOL = ILendingPool(provider.getLendingPool());
  }
}