// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

struct PoliesInverstor {
    address invertor;
    uint256 level;
    mapping(address => uint256) invertTokens;
    mapping(address => uint256) profits;
    uint256 joinAt;
}
