# **Flash Loan**
Flash loan is an uncollateralize loan that must be borrowed and repaid in the same transaction. Flash loans are commonly used for arbitrage, liquidation and Defi hacks.  
The Aave Protocol is the largest source of funding for flash loans in DeFi and charges a transaction fee of 0.09%.  

## run the test using ganache-cli

1) Call command below to run ganache on the mainnet fork   
```
ganache-cli --fork https://mainnet.infura.io/v3/5bc20cad614a4604b5a4ee51e8023cb9 --unlock 0x89dF4F398563bF6A64a4D24dFE4be00b20b563Ae --networkId 999
```
Now ganache is running on the mainnet fork.  

2) Open a new terminal and call command below  
```
npx truffle test test/flashLoan.js  --network mainnetFork
```

