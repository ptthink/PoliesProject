// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./IERC20.sol";

interface IFinanceOrg   {
    event ApplicationPassed(address indexed orgAddress); 
    function approveFinanceOrg() external  returns (bool);
    function createFund(address token,uint256 amount) external  returns (bool);
    function getInfo() external view returns(address platform,bytes32 name, bytes32 url1, bytes32 url2, uint256 level,uint256  createAt,uint256 joinAt,bool valid);
    function getPerformance() external view returns(uint investReturnPercent);
}
