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

    function applyToBeAFinanceOrg(address financeOrgId) external returns (bool);

    function approveOrgRequest(address financeOrg)
        external
        returns (bool);

    function approveFundRequest(uint256 requestId, bool pass)
        external
        returns (bool);

    function updateFeeRate(uint256 investFeeRate, uint256 profitFeeRate)
        external
        returns (bool);
}
