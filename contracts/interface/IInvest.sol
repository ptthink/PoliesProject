// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./IERC20.sol";

interface IInvest {
    function inverst(address token, uint256 amount) external view returns (bool);

    function withdrawProfit() external view returns (bool);
}
