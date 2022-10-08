// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./interfaces/FlashLoanReceiverBase.sol";

contract flashLoan is FlashLoanReceiverBase {
    event Log(string message, uint256 val);
    event LogAdr(string message, address addr);

    constructor(ILendingPoolAddressesProvider _addressProvider)
        public
        FlashLoanReceiverBase(_addressProvider)
    {}

    function doFlashLoan(
        address asset1,
        address asset2,
        uint256 amount1,
        uint256 amount2
    ) external {
        // checking the balance of contract (increase the balance of contract before running Flash Loan )
        uint256 bal1 = IERC20(asset1).balanceOf(address(this));
        require(bal1 > amount1, "bal1 <= amount1");

        uint256 bal2 = IERC20(asset2).balanceOf(address(this));
        require(bal2 > amount2, "bal2 <= amount2");

        address[] memory assets = new address[](2);
        assets[0] = asset1;
        assets[1] = asset2;

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = amount1;
        amounts[1] = amount2;

        uint256[] memory modes = new uint256[](2);
        // no debt for both tokens : pay all loaned
        modes[0] = 0;
        modes[1] = 0;

        bytes memory params = ""; // extra data to pass abi.encode(...)
        uint16 referralCode = 0;

        LENDING_POOL.flashLoan(
            address(this), // receiver
            assets,
            amounts,
            modes,
            address(this), // onBehalfOf
            params,
            referralCode
        );
    }

    function executeOperation(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        emit Log("abol" , 22) ;
        for (uint256 i = 0; i < assets.length; i++) {
            IERC20(assets[i]).approve(
                address(LENDING_POOL),
                amounts[i] + premiums[i]
            );

            emit LogAdr("token", assets[i]);
            emit Log("borrowed", amounts[i]);
            emit Log("fee", premiums[i]);
        }
        return true;
    }
}
