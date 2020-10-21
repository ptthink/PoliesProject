// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./IERC20.sol";

interface IInvestor {
    function withdrawProfit() external view returns (bool);
}
