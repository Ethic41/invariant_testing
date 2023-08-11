// SPDX-License-Identifier: MIT
// -=-<[ Bismillahirrahmanirrahim ]>-=-
// -*- coding: utf-8 -*-
// @Date    : 2023-08-09 14:43:10
// @Author  : Dahir Muhammad Dahir (dahirmuhammad3@gmail.com)
pragma solidity ^0.8.18;


import {Test} from "forge-std/Test.sol";
import {WETH9} from "src/WETH9.sol";
import {Handler} from "./handlers/Handler.sol";


contract WETH9Invariants is Test {
    WETH9 public weth;
    Handler public handler;

    function setUp() public {
        weth = new WETH9();
        handler = new Handler(weth);

        targetContract(address(handler));
    }

    function invariant_conservationOfETH() public {
        assertEq(
            handler.ETH_SUPPLY(),  
            address(handler).balance + weth.totalSupply()
        );
    }

    function invariant_solvencyDeposits() public {
        assertEq(
            address(weth).balance, 
            handler.ghost_depositSum() - handler.ghost_withdrawSum()
        );
    }

}

