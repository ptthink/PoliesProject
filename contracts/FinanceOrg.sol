// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./access/Ownable.sol";
import "./interface/IFinanceOrg.sol";
import "./utils/Address.sol";

contract FinanceOrg is IFinanceOrg, Ownable {
    using Address for address;
    address private _platform;
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

    constructor(
        bytes32 name,
        bytes32 url1,
        bytes32 url2,
        address platformContract
    ) public {
        require(platformContract.isContract(), "invalid platform address");
        _platform = platformContract;
        _name = name;
        _url1 = url1;
        _url2 = url2;
    }

    function approveFinanceOrg() external override returns (bool) {
        require(
            _msgSender() == _platform,
            "FinanceOrg:only platform can approve"
        );
        _valid = true;
        _joinAt = block.timestamp;
        emit ApplicationPassed(address(this));
    }

    function createFund(address token, uint256 amount)
        external
        override
        returns (bool)
    {}

    function getInfo()
        external
        override
        view
        returns (
            address, //platform
            bytes32, //name
            bytes32, //url1
            bytes32, //url2
            uint256, //level
            uint256, //createAt
            uint256, //joinAt
            bool //valid
        )
    {
        return (
            _platform,
            _name,
            _url1,
            _url2,
            _level,
            _createAt,
            _joinAt,
            _valid
        );
    }

    function getPerformance()
        external
        override
        view
        returns (uint256 investReturnPercent)
    {
        return _investReturnPercent;
    }
}
