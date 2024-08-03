// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

contract TokenBalanceChecker {
    struct TokenBalance {
        address tokenAddress;
        uint256 balance;
    }

    struct UserBalances {
        uint256 nativeBalance;
        TokenBalance[] tokenBalances;
    }

    function getBalances(address user, address[] memory tokenAddresses) public view returns (UserBalances memory) {
        TokenBalance[] memory balances = new TokenBalance[](tokenAddresses.length);

        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            try IERC20(tokenAddresses[i]).balanceOf(user) returns (uint256 tokenBalance) {
                balances[i] = TokenBalance({
                    tokenAddress: tokenAddresses[i],
                    balance: tokenBalance
                });
            } catch {
                balances[i] = TokenBalance({
                    tokenAddress: tokenAddresses[i],
                    balance: 0 
                });
            }
        }

        UserBalances memory userBalances = UserBalances({
            nativeBalance: user.balance, 
            tokenBalances: balances
        });

        return userBalances;
    }
}
