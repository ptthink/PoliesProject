// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./access/Ownable.sol";
import "./interface/IFinanceOrg.sol";

contract FinanceOrg is IFinanceOrg, Ownable {
    constructor(
        bytes32 name,
        bytes32 url1,
        bytes32 url2
    ) public {
        _name = name;
        _url1 = url1;
        _url2 = url2;
    }

    bytes32 private _name;
    bytes32 private _url1;
    bytes32 private _url2;
    uint256 private _level;
    mapping(address => uint256) private _holdFunds;
    mapping(address => uint256) private _profits;
    uint256 private _investReturnPercent;
    uint256 private _createAt;
    uint256 private _joinAt;
    bool private _valid;

    function createFund(address token, uint256 amount)
        external
        override
        view
        returns (bool)
    {}
}
