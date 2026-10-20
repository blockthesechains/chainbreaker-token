// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Chainbreaker} from "./Chainbreaker.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract ChainbreakerTest is Test {
    Chainbreaker token;
    address alice = address(0xA11CE);
    address bob = address(0xB0B);
    uint256 constant INITIAL_SUPPLY = 1_000_000 ether;

    function setUp() public {
        token = new Chainbreaker(INITIAL_SUPPLY);
    }

    function test_NameAndSymbol() public view {
        assertEq(token.name(), "Chainbreaker");
        assertEq(token.symbol(), "CHBK");
    }

    function test_InitialSupplyMintedToDeployer() public view {
        assertEq(token.totalSupply(), INITIAL_SUPPLY);
        assertEq(token.balanceOf(address(this)), INITIAL_SUPPLY);
    }

    function test_OwnerIsDeployer() public view {
        assertEq(token.owner(), address(this));
    }

    function test_Transfer() public {
        token.transfer(alice, 100 ether);
        assertEq(token.balanceOf(alice), 100 ether);
        assertEq(token.balanceOf(address(this)), INITIAL_SUPPLY - 100 ether);
    }

    function test_OwnerCanMint() public {
        token.mint(alice, 50 ether);
        assertEq(token.balanceOf(alice), 50 ether);
        assertEq(token.totalSupply(), INITIAL_SUPPLY + 50 ether);
    }

    function test_RevertWhen_NonOwnerMints() public {
        vm.prank(alice);
        vm.expectRevert(
            abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, alice)
        );
        token.mint(alice, 50 ether);
    }

    function test_RevertWhen_TransferExceedsBalance() public {
        vm.prank(alice);
        vm.expectRevert();
        token.transfer(bob, 1 ether);
    }

    function testFuzz_Transfer(uint256 amount) public {
        amount = bound(amount, 0, INITIAL_SUPPLY);
        token.transfer(bob, amount);
        assertEq(token.balanceOf(bob), amount);
    }
}