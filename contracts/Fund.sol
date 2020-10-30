// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./interface/IERC20.sol";
import "./interface/IFund.sol";
import "./math/SafeMath.sol";
import "./utils/Address.sol";

contract Fund is IFund {
    using Address for address;
    using SafeMath for uint256;
    address _platform;
    address _fundOrg;
    address _token;
    uint256 _applyAmount;
    uint256 _realAmount;
    uint256 _profit;
    mapping(address => uint256) _invests;

    constructor(
        address platform,
        address fundOrg,
        address token,
        uint256 applyAmount
    ) public {
        require(platform.isContract(), "invalid platform address");
        require(fundOrg.isContract(), "invalid fundOrg address");
        require(applyAmount > 0, "apply amount should > 0");

        if (_token != address(0))
            require(IERC20(token).totalSupply() > 0, "invalid erc20 address");

        _platform = platform;
        _fundOrg = fundOrg;
        _token = token;
        _applyAmount = applyAmount;
    }

    function invest(
        address investor,
        address token,
        uint256 amount
    ) external override returns (bool) {
        require(_token == token, "invalid token");
        uint256 investAmount = _invests[investor];
        investAmount = investAmount.add(amount);
        _invests[investor] = investAmount;
    }

    function injectProfitsAndFinish() external override returns (bool) {}

    function pick(address token, uint256 amount)
        external
        override
        returns (address)
    {}

    function withdrawProfit(address token, uint256 amount)
        external
        override
        returns (bool)
    {}
}
