// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SatelliteImageryIntergrity {

    address public immutable minter;

    mapping (bytes => uint256) images;

    constructor() {
        minter = msg.sender;
    }

    error HashCollision();

    function writeHash(string memory inputHash, uint256 timestamp) public {
        require(msg.sender == minter);

        bytes memory _bytesHash = bytes(inputHash);

        if (images[_bytesHash] != 0) revert HashCollision();
        
        images[_bytesHash] = timestamp;
    }

    function checkHash(string memory inputHash) public view returns(uint256) {
        return images[bytes(inputHash)];
    }

}