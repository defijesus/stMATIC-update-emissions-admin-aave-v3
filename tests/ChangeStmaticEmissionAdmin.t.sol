// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {IERC20} from 'forge-std/interfaces/IERC20.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import {IEmissionManager, ITransferStrategyBase, RewardsDataTypes, IEACAggregatorProxy} from '../src/interfaces/IEmissionManager.sol';
import {BaseTest} from './utils/BaseTest.sol';

import {ChangeStmaticEmissionAdminPayload} from '../src/contracts/ChangeStmaticEmissionAdminPayload.sol';

contract EmissionTest is BaseTest {
  /// @dev Used to simplify the definition of a program of emissions
  /// @param asset The asset on which to put reward on, usually Aave atokens or variable debt tokens
  /// @param emission Total emission of a `reward` token during the whole distribution duration defined
  /// E.g. With an emission of 1_000_000 OP tokens during 10 days, an emission of 10% for aUSDC would be
  /// 1_000_000 * 1e18 * 10% / 10 days in seconds = 100_000 * 1e18 / 864_000 = ~ 0.11574 * 1e18
  struct EmissionPerAsset {
    address asset;
    uint256 emission;
  }

  ChangeStmaticEmissionAdminPayload public payload;
  address constant GUARDIAN = 0xE50c8C619d05ff98b22Adf991F17602C774F785c;
  IEmissionManager constant EMISSION_MANAGER =
    IEmissionManager(0x048f2228D7Bf6776f99aB50cB1b1eaB4D1d4cA73);
  IEACAggregatorProxy constant REWARD_ORACLE =
    IEACAggregatorProxy(0x0D276FC14719f9292D5C1eA2198673d1f4269246); // OP/USD

  ITransferStrategyBase constant TRANSFER_STRATEGY =
    ITransferStrategyBase(0x80B2a024A0f347e774ec3bc58304978FB3DFc940);

  uint256 constant TOTAL_DISTRIBUTION = 5_000_000 ether; // 5m OP
  uint88 constant DURATION_DISTRIBUTION = 90 days;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 35462470);
    /// @dev chains that are controlled by crosschain governance need to execute a proposal to set the emission admin
    payload = new ChangeStmaticEmissionAdminPayload();
    _setUp(AaveV3Polygon.ACL_ADMIN);
    _execute(address(payload));

    // vm.startPrank(GUARDIAN);
    // /// @dev only necessary if the OP_EMISSION_ADMIN doesn't have permissions
    // EMISSION_MANAGER.setEmissionAdmin(OP, OP_EMISSION_ADMIN);
    // vm.stopPrank();
  }

  function test_activation() public {
    // verify stMATIC
    assertEq(EMISSION_MANAGER.getEmissionAdmin(payload.stMATIC()), 0x0c54a0BCCF5079478a144dBae1AFcb4FEdf7b263);
    emit log_named_address('new emission admin for stMATIC rewards',EMISSION_MANAGER.getEmissionAdmin(payload.stMATIC()));

    // verify maticX
    assertEq(EMISSION_MANAGER.getEmissionAdmin(payload.maticX()), 0x0c54a0BCCF5079478a144dBae1AFcb4FEdf7b263);
    emit log_named_address('new emission admin for maticX rewards',EMISSION_MANAGER.getEmissionAdmin(payload.maticX()));
  }

  function _toUint88(uint256 value) internal pure returns (uint88) {
    require(value <= type(uint88).max, "SafeCast: value doesn't fit in 88 bits");
    return uint88(value);
  }
}
