// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./access/Ownable.sol";
import "./interface/IPoliesPlatform.sol";

contract PoliesPlatform is IPoliesPlatform, Ownable {
    constructor() public {}

    function approveOrgRequest(uint256 requestId, bool pass)
        external
        override
        view
        onlyOwner
        returns (bool)
    {}

    function approveFundRequest(uint256 requestId, bool pass)
        external
        override
        view
        onlyOwner
        returns (bool)
    {}

    function updateFeeRate(uint256 investFeeRate, uint256 profitFeeRate)
        external
        override
        onlyOwner
        returns (bool)
    {}

    function applyAsFinanceOrg(
        address owner,
        bytes32 name,
        bytes32 url1,
        bytes32 url2
    ) external override view returns (address) {}

    function createFund(address token, uint256 amount)
        external
        override
        view
        returns (bool)
    {}

    function withdrawProfit(
        uint256 fundId,
        address token,
        uint256 amount
    ) external override view returns (bool) {}
}
