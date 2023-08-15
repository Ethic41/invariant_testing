// SPDX-License-Identifier: MIT
// -=-<[ Bismillahirrahmanirrahim ]>-=-
// -*- coding: utf-8 -*-
// @Date    : 2023-08-09 16:39:17
// @Author  : Dahir Muhammad Dahir (dahirmuhammad3@gmail.com)
pragma solidity ^0.8.18;


import {WETH9} from "src/WETH9.sol";
import {Test} from "forge-std/Test.sol";


struct AddressSet {
    address[] addrs;
    mapping(address => bool) saved;
}

library LibAddressSet {
    function add(AddressSet storage s, address addr) internal {
        if (!s.saved[addr]) {
            s.addrs.push(addr);
            s.saved[addr] = true;
        }
    }

    function contains(
        AddressSet storage s, 
        address addr
    ) internal view returns (bool) {
        return s.saved[addr];
    }

    function count(
        AddressSet storage s
    ) internal view returns (uint256) {
        return s.addrs.length;
    }
}


contract Handler is Test{
    using LibAddressSet for AddressSet;

    AddressSet internal _actors;

    WETH9 public weth;

    uint256 public constant ETH_SUPPLY = 120_500_000 ether;

    modifier createActor() {
        _actors.add(msg.sender);
        _;
    }

    constructor(WETH9 _weth) {
        weth = _weth;
        vm.deal(address(this), ETH_SUPPLY);
    }

    uint256 public ghost_depositSum;
    uint256 public ghost_withdrawSum;

    function deposit(uint256 amount) public {
        amount = bound(amount, 0, address(this).balance);
        _fund(msg.sender, amount);

        vm.prank(msg.sender);
        weth.deposit{value: amount}();
    }
}

