// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./access/Ownable.sol";
import "./interface/IFinanceOrg.sol";
import "./interface/IPoliesPlatform.sol";

contract PoliesPlatform is IPoliesPlatform, Ownable {
    uint256 private _orgRegIdCursor; // Automatic increase id of finance organization application
    uint256 private _fundReqIdCursor;// Automatic increase id of fund application
    uint256 private _investFeeRate;
    uint256 private _profitFeeRate;
    mapping(address => uint256) _orgs; // finance organization
    //mapping(address => mapping()) _orgs; // fund application

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

    function applyFund(address token, uint256 amount)
        external
        override
        returns (address)
    {
        address fundOrgAdrr = msg.sender;
        bool valid;
        (, , , , , , , valid) = IFinanceOrg(fundOrgAdrr).getInfo();
        require(valid == true, "invlid finance org");

    }

    function approveFundRequest(address fundAddress, bool pass)
        external
        override
        view
        onlyOwner
        returns (bool)
    {}

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
