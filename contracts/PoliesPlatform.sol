// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./access/Ownable.sol";
import "./interface/IFinanceOrg.sol";
import "./interface/IPoliesPlatform.sol";

contract PoliesPlatform is IPoliesPlatform, Ownable {
    uint256 _orgRegIdCursor;
    mapping(address => uint256) _orgs; // finance organization

    function approveOrgRequest(address financeOrg)
        external
        override
        returns (bool)
    {
        IFinanceOrg(financeOrg).approveFinanceOrg();
    }

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

    function approveFundRequest(uint256 requestId, bool pass)
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
    {}

    function applyAsFinanceOrg(
        address owner,
        bytes32 name,
        bytes32 url1,
        bytes32 url2
    ) external view returns (address) {}

    function createFund(address token, uint256 amount)
        external
        view
        returns (bool)
    {}

    function withdrawProfit(
        uint256 fundId,
        address token,
        uint256 amount
    ) external view returns (bool) {}
}
