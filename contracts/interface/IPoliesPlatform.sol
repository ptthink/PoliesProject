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

    /// @notice Apply to become a financial organization
    /// @param financeOrg Finance organization address
    /// @return  Submit successful or failed
    /// @dev Financial organization should approved before getting funding
    function applyToBeAFinanceOrg(address financeOrg) external returns (bool);

    /// @notice Financial organization applying for funding
    /// @param token Eth (if the address equals address(0)) or ERC20 token (address is ERC20 token contract address)
    /// @param amount Amount of funds to be applied for
    /// @return The fund address
    /// @dev Invalid financial organization will failed
    function applyFund(address token,uint256 amount) external returns (address);


    /// @notice Approve applications from financial organization
    /// @param financeOrg Finance organization address
    /// @return Approve result of financial organization application
    /// @dev Only platform owner can approve
    function approveOrgRequest(address financeOrg)
        external
        returns (bool);

    /// @notice Approve funding applications from financial organization
    /// @param fundAddress The fund contract address
    /// @return Submit successful or failed
    /// @dev Only platform owner can approve
    function approveFundRequest(address fundAddress, bool pass)
        external
        returns (bool);

    /// @notice Update the fee rate
    /// @param investFeeRate Fee rate of invest
    /// @param profitFeeRate Fee rate of profit
    /// @return Update successful or failed
    /// @dev If no fees will be charged in the future, set fee rate = 0
    function updateFeeRate(uint256 investFeeRate, uint256 profitFeeRate)
        external
        returns (bool);
}
