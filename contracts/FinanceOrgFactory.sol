// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;
import "./FinanceOrg.sol";
import "./interface/IPoliesPlatform.sol";

contract FinanceOrgFactory {
    address _poliesPlatformAddress;

    constructor(address poliesPlatformAddress) public {
        require(
            poliesPlatformAddress != address(0),
            "invalid poliesPlatform address"
        );
        _poliesPlatformAddress = poliesPlatformAddress;
    }

    function createFactory(
        bytes32 name,
        bytes32 url1,
        bytes32 url2
    ) public returns (uint256 financeOrgId) {
        FinanceOrg financeOrg = new FinanceOrg(name, url1, url2);

        IPoliesPlatform(_poliesPlatformAddress).applyAsFinanceOrg(
            address(financeOrg)
        );
    }
}
