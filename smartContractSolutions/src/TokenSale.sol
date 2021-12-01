// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;
	
interface TargetInterface {
	function isComplete() external returns (bool);

	function buy(uint256) external payable;

	function sell(uint256) external;	
}

contract TokenSale {
	address owner;
	TargetInterface target;

	constructor(address _targetAddress) {
		owner = msg.sender;
		target = TargetInterface(_targetAddress);
	}

	function calc(uint256 amount) public pure returns (uint256) {
		uint256 output;
		unchecked {
			output = amount * 1 ether;
		}
		return output;
	}
}
