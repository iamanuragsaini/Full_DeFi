pragma solidity >=0.4.22 <0.9.0;

import 'https://github.com/aave/flashloan-box/blob/master/contracts/aave/FlashLoanReceiverBase.sol';
import 'https://github.com/aave/aave-protocol/blob/master/contracts/lendingpool/LendingPool.sol';
import 'https://github.com/aave/aave-protocol/blob/master/contracts/configuration/LendingPoolAddressesProvider.sol';

contract Borrow is FlashLoanReceiverBase{

LendingPoolAddressesProvider provider;
address dai;

constructor(address _provider, address _dai) FlashLoanReceiverBase(_provider) public {
    provider = LendingPoolAddressesProvider(_provider);
    dai = _dai;
}

function startLoan(uint amount, bytes calldata _params) external {
    LendingPool lendingpool = LendingPool(provider.getLendingPool());
    LendingPool.flashloan(address(this), dai, amount, _params);
}

function execute(address _reserve, uint amount, uint fee, bytes memory _params) external{
    transferFundsBackToPoolInternal(_reserve, amount+fee);
}


}