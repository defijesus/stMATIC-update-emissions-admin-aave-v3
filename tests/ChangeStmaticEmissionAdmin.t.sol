// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import {IEmissionManager} from '../src/interfaces/IEmissionManager.sol';
import {BaseTest} from './utils/BaseTest.sol';

import {ChangeEmissionAdminPayload} from '../src/contracts/ChangeStmaticEmissionAdminPayload.sol';

contract ChangeEmissionAdminTest is BaseTest {
  ChangeEmissionAdminPayload public payload;
  IEmissionManager constant EMISSION_MANAGER =
    IEmissionManager(0x048f2228D7Bf6776f99aB50cB1b1eaB4D1d4cA73);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'));
    payload = ChangeEmissionAdminPayload(0x4A6F570E2eAf30b0E0C3E61c030DBcdcfbE94692);
    _setUp(AaveV3Polygon.ACL_ADMIN);
    _execute(address(payload));
  }

  function testActivation() public {
    // verify stMATIC
    assertEq(EMISSION_MANAGER.getEmissionAdmin(payload.STMATIC()), 0x0c54a0BCCF5079478a144dBae1AFcb4FEdf7b263);
    emit log_named_address('new emission admin for stMATIC rewards',EMISSION_MANAGER.getEmissionAdmin(payload.STMATIC()));
    
    // verify maticX
    assertEq(EMISSION_MANAGER.getEmissionAdmin(payload.MATICX()), 0x0c54a0BCCF5079478a144dBae1AFcb4FEdf7b263);
    emit log_named_address('new emission admin for maticX rewards',EMISSION_MANAGER.getEmissionAdmin(payload.MATICX()));
    
    /// verify admin can make changes  
    vm.startPrank(payload.NEW_EMISSION_ADMIN());
    EMISSION_MANAGER.setDistributionEnd(payload.STMATIC(), payload.STMATIC(), 0);
    EMISSION_MANAGER.setDistributionEnd(payload.MATICX(), payload.MATICX(), 0);
    vm.stopPrank();
  }
}
