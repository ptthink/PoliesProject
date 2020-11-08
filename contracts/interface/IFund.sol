// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./IERC20.sol";

interface IFund {
    function invest(
        address investor,
        address token,
        uint256 amount
    ) external returns (bool);

    function injectProfitsAndFinish() external returns (bool);

    function pick(address token, uint256 amount) external returns (address);

    function forzen() external returns (bool);

    function unforzen() external returns (bool);

    function allowToInvest() external returns (bool);

    function withdrawProfit(address token, uint256 amount)
        external
        returns (bool);
}
