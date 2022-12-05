// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import {IEmissionManager} from '../src/interfaces/IEmissionManager.sol';
import {BaseTest} from './utils/BaseTest.sol';

import {ChangeEmissionAdminPayload} from '../src/contracts/ChangeEmissionAdminPayload.sol';

contract ChangeEmissionAdminTest is BaseTest {
  ChangeEmissionAdminPayload public payload;
  IEmissionManager constant EMISSION_MANAGER =
    IEmissionManager(0x048f2228D7Bf6776f99aB50cB1b1eaB4D1d4cA73);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'));
    payload = new ChangeEmissionAdminPayload();
    _setUp(AaveV3Polygon.ACL_ADMIN);
    _execute(address(payload));
  }

  function testActivation() public {
    /// verify stMATIC
    assertEq(EMISSION_MANAGER.getEmissionAdmin(payload.STMATIC()), payload.STMATIC_MATICX_NEW_EMISSION_ADMIN());
    emit log_named_address('new emission admin for stMATIC rewards', EMISSION_MANAGER.getEmissionAdmin(payload.STMATIC()));
    
    /// verify maticX
    assertEq(EMISSION_MANAGER.getEmissionAdmin(payload.MATICX()), payload.STMATIC_MATICX_NEW_EMISSION_ADMIN());
    emit log_named_address('new emission admin for maticX rewards', EMISSION_MANAGER.getEmissionAdmin(payload.MATICX()));

    /// verify matic admin can make changes  
    vm.startPrank(payload.STMATIC_MATICX_NEW_EMISSION_ADMIN());
    EMISSION_MANAGER.setDistributionEnd(payload.STMATIC(), payload.STMATIC(), 0);
    EMISSION_MANAGER.setDistributionEnd(payload.MATICX(), payload.MATICX(), 0);
    vm.stopPrank();

    /// verify SD
    assertEq(EMISSION_MANAGER.getEmissionAdmin(payload.SD()), payload.SD_NEW_EMISSION_ADMIN());
    emit log_named_address('new emission admin for SD rewards', EMISSION_MANAGER.getEmissionAdmin(payload.SD()));

    /// verify SD admin can make changes
    vm.startPrank(payload.SD_NEW_EMISSION_ADMIN());
    EMISSION_MANAGER.setDistributionEnd(payload.SD(), payload.SD(), 0);
    vm.stopPrank();

    /// verify LDO
    assertEq(EMISSION_MANAGER.getEmissionAdmin(payload.LDO()), payload.LDO_NEW_EMISSION_ADMIN());
    emit log_named_address('new emission admin for LDO rewards', EMISSION_MANAGER.getEmissionAdmin(payload.LDO()));

    /// verify LDO admin can make changes
    vm.startPrank(payload.LDO_NEW_EMISSION_ADMIN());
    EMISSION_MANAGER.setDistributionEnd(payload.LDO(), payload.LDO(), 0);
    vm.stopPrank();

  }
}
