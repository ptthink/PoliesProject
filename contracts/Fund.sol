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
    bool _forzen;
    bool _valid;
    mapping(address => uint256) _invests;

    /**
     * @dev Throws if called by any account other than the fund owner.
     */
    modifier onlyOwnerFundOrg() {
        require(_fundOrg == msg.sender, "Fund:only owner org can call it");
        _;
    }

    /**
     * @dev Throws if called by any account other than the platform.
     */
    modifier onlyPlatform() {
        require(_platform == msg.sender, "Fund:only platform org can call it");
        _;
    }

    /**
     * @dev Throws if called when fund forzen.
     */
    modifier onlyNotForzen() {
        require(_forzen == false, "Fund:forzen");
        _;
    }

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

    function allowToInvest() external override onlyPlatform returns (bool) {
        _valid = true;
    }

    function forzen() external override onlyPlatform returns (bool) {
        if (_forzen != true) _forzen = true;
    }

    function unforzen() external override onlyPlatform returns (bool) {
        if (_forzen == true) _forzen = false;
    }

    function invest(
        address investor,
        address token,
        uint256 amount
    ) external override onlyNotForzen returns (bool) {
        require(_valid == true, "can not invest before approve");
        require(_token == token, "invalid token");
        uint256 investAmount = _invests[investor];
        investAmount = investAmount.add(amount);
        _invests[investor] = investAmount;
    }

    function injectProfitsAndFinish()
        external
        override
        onlyOwnerFundOrg
        onlyNotForzen
        returns (bool)
    {}

    function pick(address token, uint256 amount)
        external
        override
        onlyOwnerFundOrg
        onlyNotForzen
        returns (address)
    {}

    function withdrawProfit(address token, uint256 amount)
        external
        override
        onlyNotForzen
        returns (bool)
    {}
}
