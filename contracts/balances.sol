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
//0xFfa5d9e18ac4c3DbA363e3c613aAA507911b357d,[0x47034B3c18f17dd89CE1d7F87B9A90235158E4CC,0x54E8d3c6Bfa55F809d5687AAB4d1Eb00f13394B4]