// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

struct FinanceOrg {
    address owner;
    bytes32 name;
    bytes32 url1;
    bytes32 url2;
    uint256 level;
    mapping(address => uint256) holdFunds;
    mapping(address => uint256) profits;
    uint256 investReturnPercent;
    uint256 createAt;
    uint256 joinAt;
}
