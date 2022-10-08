const BN = require("bn.js")
const { sendEther, pow } = require("./util")

const IERC20 = artifacts.require("IERC20")
const flashLoan = artifacts.require("flashLoan")

contract("flashLoan", (accounts) => {
    const WHALE = "0x89dF4F398563bF6A64a4D24dFE4be00b20b563Ae"            // for both USDT & USDC
    const TOKEN_BORROW1 = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"    // USDC
    const TOKEN_BORROW2 = "0xdAC17F958D2ee523a2206206994597C13D831ec7"    // USDT
    // const TOKEN_BORROW = [TOKEN_BORROW1 , TOKEN_BORROW2 ]
    const DECIMALS = 6
    const FUND_AMOUNT = pow(10, DECIMALS).mul(new BN(200))
    const BORROW_AMOUNT = pow(10, DECIMALS).mul(new BN(100))

    const ADDRESS_PROVIDER = "0xB53C1a33016B2DC2fF3653530bfF1848a515c8c5"

    let FlashLoan
    let token
    before(async () => {
        token1 = await IERC20.at(TOKEN_BORROW1)
        token2 = await IERC20.at(TOKEN_BORROW2)

        FlashLoan = await flashLoan.new(ADDRESS_PROVIDER)   // ADDRESS_PROVIDER is the input of constructor

        await sendEther(web3, accounts[0], WHALE, 1)

        // NOTICE : WHALE address balance should be greater than FUND_AMOUNT (check on etherScan )
        // WHALE address should be unlocked when the mainnet is forked
        await token1.transfer(FlashLoan.address, FUND_AMOUNT, {
            from: WHALE,
        })
        await token2.transfer(FlashLoan.address, FUND_AMOUNT, {
            from: WHALE,
        })

    })

    it("do flash loan", async () => {
        const tx = await FlashLoan.doFlashLoan(TOKEN_BORROW1, TOKEN_BORROW2, BORROW_AMOUNT, BORROW_AMOUNT, {
            from: WHALE,
        })
        for (const log of tx.logs) {
            console.log(log.args.message, log.args.val.toString())
        }
    })
})