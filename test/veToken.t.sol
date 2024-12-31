// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {veToken} from "../src/veToken.sol";
import {DeployveToken} from "../script/DeployveToken.s.sol";


contract veTokenTest is Test {
    veToken public  vet;
    DeployveToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 1000 ether;

    function setUp() public {
        deployer = new DeployveToken();
        vet = deployer.run();

        vm.prank(msg.sender);
        vet.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public {
        assertEq(STARTING_BALANCE, vet.balanceOf(bob));
    }

    function testAllowancesWorks() public {
        uint256 initialAllowance = 100;

        //Bob approves Alice to send tokens
        vm.prank(bob);
        vet.approve(alice, initialAllowance);
        
        uint256 transferAmount = 50;

        vm.prank(alice);
        vet.transferFrom(bob, alice, transferAmount);

        assertEq(vet.balanceOf(alice), transferAmount);
        assertEq(vet.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

    function testTransferUpdatesBalances() public {
    uint256 transferAmount = 100 ether;

    vm.prank(bob);
    vet.transfer(alice, transferAmount);

    assertEq(vet.balanceOf(alice), transferAmount);
    assertEq(vet.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

    function testCannotTransferMoreThanBalance() public {
        uint256 transferAmount = STARTING_BALANCE + 1 ether;

        vm.prank(bob);
        vm.expectRevert();
        vet.transfer(alice, transferAmount);
    }


    function testCannotTransferFromWithoutAllowance() public {
        uint256 transferAmount = 50;

        vm.prank(alice);
        vm.expectRevert();
        vet.transferFrom(bob, alice, transferAmount);
    }

        function testMintingTokens() public {
        uint256 mintAmount = 500;

        // Mint new tokens to Alice
        vm.prank(msg.sender);
        vet.mint(alice, mintAmount);

        assertEq(vet.balanceOf(alice), mintAmount);
        assertEq(vet.totalSupply(), STARTING_BALANCE + mintAmount);
    }
}