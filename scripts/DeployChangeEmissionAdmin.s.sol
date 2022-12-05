// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {Script} from 'forge-std/Script.sol';
import {ChangeEmissionAdminPayload} from '../src/contracts/ChangeEmissionAdminPayload.sol';

contract DeployChangeEmissionAdmin is Script {
  function run() external {
    vm.startBroadcast();
    ChangeEmissionAdminPayload payload = new ChangeEmissionAdminPayload();
    console.log('stMATIC & MATIC Emission Admin Payload address', address(payload));
    vm.stopBroadcast();
  }
}