// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./IERC20.sol";

interface IFinanceOrg   {
    event FundRequest(address indexed token, uint256 amount); 

    function applyAsFinanceOrg(address owner,bytes32 name ,bytes32 url1,bytes32 url2) external view returns (address);

    function createFund(address token,uint256 amount) external view returns (bool);
}
