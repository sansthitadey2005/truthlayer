// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TruthLayer {
    string public evidenceHash;
    uint256 public timestamp;

    function sealEvidence(string memory _hash) public {
        evidenceHash = _hash;
        timestamp = block.timestamp;
    }

    function verifyEvidence() public view returns (string memory, uint256) {
        return (evidenceHash, timestamp);
    }
}
