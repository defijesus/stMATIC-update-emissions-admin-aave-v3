// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IEmissionManager} from '../interfaces/IEmissionManager.sol';
import {IProposalGenericExecutor} from '../interfaces/IProposalGenericExecutor.sol';

/**
 * @title ChangeEmissionAdminPayload
 * @author Llama
 * @dev Setting new Emssion Admin for stMATIC & MATICX token in Aave V3 Polygon Liquidity Pool
 * Governance Forum Post: https://governance.aave.com/t/arc-stmatic-maticx-emission-admin-for-polygon-v3-liquidity-pool/10632
 * Snapshot: https://snapshot.org/#/aave.eth/proposal/0x0a319a2b17cc04b804e74f71fb54c3c8a7c21f8c8925b9da72d92028be634bb2
 */
contract ChangeEmissionAdminPayload is IProposalGenericExecutor {
  address public constant EMISSION_MANAGER = 0x048f2228D7Bf6776f99aB50cB1b1eaB4D1d4cA73;

  address public constant STMATIC = 0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4;

  address public constant MATICX = 0xfa68FB4628DFF1028CFEc22b4162FCcd0d45efb6;

  address public constant NEW_EMISSION_ADMIN = 0x0c54a0BCCF5079478a144dBae1AFcb4FEdf7b263;

  function execute() public {
    IEmissionManager(EMISSION_MANAGER).setEmissionAdmin(STMATIC, NEW_EMISSION_ADMIN);
    IEmissionManager(EMISSION_MANAGER).setEmissionAdmin(MATICX, NEW_EMISSION_ADMIN);
  }
}
