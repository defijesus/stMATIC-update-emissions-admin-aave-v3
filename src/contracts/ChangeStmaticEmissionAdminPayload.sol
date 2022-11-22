// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IEmissionManager} from '../interfaces/IEmissionManager.sol';
import {IProposalGenericExecutor} from '../interfaces/IProposalGenericExecutor.sol';

/**
 * @title AddEmissionAdminPayload
 * @author BGD Labs
 * @dev Generic proposal to be executed via cross-chain governance.
 * Once executed this payload would add an EMISSION_ADMIN for a REWARD token on the specified EMISSION_MANAGER.
 */
contract ChangeStmaticEmissionAdminPayload is IProposalGenericExecutor {
  address public constant EMISSION_MANAGER = 0x048f2228D7Bf6776f99aB50cB1b1eaB4D1d4cA73;

  address public constant stMATIC = 0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4;

  address public constant maticX = 0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6;

  address public constant NEW_EMISSION_ADMIN = 0x0c54a0BCCF5079478a144dBae1AFcb4FEdf7b263;

  function execute() public {
    IEmissionManager(EMISSION_MANAGER).setEmissionAdmin(stMATIC, NEW_EMISSION_ADMIN);
    IEmissionManager(EMISSION_MANAGER).setEmissionAdmin(maticX, NEW_EMISSION_ADMIN);
  }
}
