// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract Notary {
    event Notarized(uint256 timestamp, bytes32 proof, address submitter);

    mapping(bytes32 => bool) private proofs;

    function proofFor(string calldata _document) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_document));
    }

    function notarize(string calldata _document) public {
        bytes32 proof = proofFor(_document);
        proofs[proof] = true;
        emit Notarized(block.timestamp, proof, msg.sender);
    }

    function verifyDocument(string calldata _document)
        public
        view
        returns (bool)
    {
        bytes32 proof = proofFor(_document);
        return proofs[proof];
    }
}
