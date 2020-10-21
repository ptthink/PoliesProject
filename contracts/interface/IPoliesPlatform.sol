// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./IERC20.sol";
import "./IInvest.sol";
import "./IFinanceOrg.sol";

interface IPoliesPlatform is IInvest,IFinanceOrg {
    event FundRequestApproved(address indexed token,uint256 indexed requestId, uint256 amount);    
    
    function approveOrgRequest(uint requestId,bool pass) external view returns (bool);

    function approveFundRequest(uint requestId,bool pass) external view returns (bool);

    function updateFeeRate(uint investFeeRate,uint profitFeeRate) external returns (bool);
}
