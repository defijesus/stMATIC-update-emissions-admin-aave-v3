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
contract ChangeLdoEmissionAdminPayload is IProposalGenericExecutor {
  address public constant EMISSION_MANAGER = 0x048f2228D7Bf6776f99aB50cB1b1eaB4D1d4cA73;

  address public constant LDO = 0xC3C7d422809852031b44ab29EEC9F1EfF2A58756;

  address public constant NEW_EMISSION_ADMIN = 0x87D93d9B2C672bf9c9642d853a8682546a5012B5;

  function execute() public {
    IEmissionManager(EMISSION_MANAGER).setEmissionAdmin(LDO, NEW_EMISSION_ADMIN);
  }
}
