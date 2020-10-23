// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./IERC20.sol";
import "./IInvestor.sol";
import "./IFinanceOrg.sol";

interface IPoliesPlatform {
    event FundRequestApproved(
        address indexed token,
        uint256 indexed requestId,
        uint256 amount
    );

    function applyAsFinanceOrg(address financeAddress)
        external
        view
        returns (address);

    function approveOrgRequest(uint256 requestId, bool pass)
        external
        view
        returns (bool);

    function approveFundRequest(uint256 requestId, bool pass)
        external
        view
        returns (bool);

    function updateFeeRate(uint256 investFeeRate, uint256 profitFeeRate)
        external
        returns (bool);
}
