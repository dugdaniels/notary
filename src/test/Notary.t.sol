// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "ds-test/test.sol";
import "src/Notary.sol";

interface CheatCodes {
    function expectRevert() external;
}

contract ContractTest is DSTest {
    Notary notary;
    string public constant DOCUMENT = "Hello, world!";
    CheatCodes constant cheats = CheatCodes(HEVM_ADDRESS);

    function setUp() public {
        notary = new Notary();
    }

    function testProofFor() public {
        bytes32 expected = keccak256(abi.encodePacked(DOCUMENT));
        bytes32 result = notary.proofFor(DOCUMENT);
        assertEq(expected, result);
    }

    function testNotarizeAndVerify() public {
        notary.notarize(DOCUMENT);
        assertTrue(notary.verifyDocument(DOCUMENT));
    }

    function testVerifyWithoutNotarize() public {
        assertTrue(!notary.verifyDocument(DOCUMENT));
    }
}
