// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

contract TokenBalanceChecker {
   
    struct TokenBalance {
        address tokenAddress;
        uint256 balance;
    }

    function getBalances(address user, address[] memory tokenAddresses) public view returns (TokenBalance[] memory) {
        TokenBalance[] memory balances = new TokenBalance[](tokenAddresses.length);
        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            IERC20 token = IERC20(tokenAddresses[i]);
            balances[i] = TokenBalance({
                tokenAddress: tokenAddresses[i],
                balance: token.balanceOf(user)
            });
        }

        return balances;
    }
}