// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./access/Ownable.sol";
import "./interface/IFund.sol";
import "./Fund.sol";
import "./interface/IFinanceOrg.sol";
import "./interface/IPoliesPlatform.sol";

contract PoliesPlatform is IPoliesPlatform, Ownable {
    uint256 private _orgRegIdCursor; // Automatic increase id of finance organization application
    uint256 private _fundReqIdCursor; // Automatic increase id of fund application
    uint256 private _investFeeRate;
    uint256 private _profitFeeRate;
    mapping(address => uint256) private _orgs; // finance organization,finance org contract --> orgId
    mapping(uint256 => address) private _fundApplications; // fund, application id --> fund contract address

    function initialize() public override {
        Ownable.initialize();
    }

    //fund org address => application id ==> token address ==>
    function applyToBeAFinanceOrg(address financeOrg)
        external
        override
        returns (bool)
    {
        uint256 orgRegId = _orgs[financeOrg];
        require(orgRegId == 0, "already applied");
        address platform;
        (platform, , , , , , , ) = IFinanceOrg(financeOrg).getInfo();

        require(platform == address(this), "invalid org");

        _orgRegIdCursor = _orgRegIdCursor + 1;
        _orgs[financeOrg] = _orgRegIdCursor;
    }

    function getOrgId(address financeOrg) external view returns (uint256) {
        return _orgs[financeOrg];
    }

    function approveOrgRequest(address financeOrg)
        external
        override
        returns (bool)
    {
        require(_orgs[financeOrg] > 0, "invalid application org");
        bool valid;

        (, , , , , , , valid) = IFinanceOrg(financeOrg).getInfo();
        require(valid != true, "already approved");

        IFinanceOrg(financeOrg).approveFinanceOrg();
    }

    function applyFund(address token, uint256 applyAmount)
        external
        override
        returns (address)
    {
        require(applyAmount > 0, "apply amount must gt 0");
        address fundOrgAddr = msg.sender;
        bool valid;
        (, , , , , , , valid) = IFinanceOrg(fundOrgAddr).getInfo();
        require(valid == true, "invlid finance org");

        if (token != address(0)) {
            require(IERC20(token).totalSupply() > 0, "invalid erc20 token");
        }

        Fund fund = new Fund(address(this), fundOrgAddr, token, applyAmount);
        _fundReqIdCursor = _fundReqIdCursor + 1;
        _fundApplications[_fundReqIdCursor] = address(fund);
    }

    function approveFundRequest(address fundAddress)
        external
        override
        onlyOwner
        returns (bool)
    {
        return IFund(fundAddress).allowToInvest();
    }

    function updateFeeRate(uint256 investFeeRate, uint256 profitFeeRate)
        external
        override
        onlyOwner
        returns (bool)
    {
        _investFeeRate = investFeeRate;
        _profitFeeRate = profitFeeRate;
    }

    function withdrawProfit(
        uint256 fundId,
        address token,
        uint256 amount
    ) external view returns (bool) {}
}
