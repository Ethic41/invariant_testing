// SPDX-License-Identifier: MIT
// -=-<[ Bismillahirrahmanirrahim ]>-=-
// -*- coding: utf-8 -*-
// @Date    : 2023-08-09 16:39:17
// @Author  : Dahir Muhammad Dahir (dahirmuhammad3@gmail.com)
pragma solidity ^0.8.18;


import {WETH9} from "src/WETH9.sol";
import {Test} from "forge-std/Test.sol";


contract Handler is Test{
    WETH9 public weth;

    constructor(WETH9 _weth) {
        weth = _weth;
        vm.deal(address(this), 10 ether);
    }

    function deposit(uint256 amount) public {
        weth.deposit{value: amount}();
    }
}

