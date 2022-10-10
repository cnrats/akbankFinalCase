// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.13 to v0.9.0
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Grader is ERC20, Ownable {

	event TeacherEvent(address indexed _from, uint256 indexed _id, string msg);
	
	constructor() ERC20("CanerCOIN", "CNRC") {

		transferOwnership(msg.sender);
		
    }

	struct Teacher {
		uint256 id;
		string name;
		string deparment;
		address addr;
	}

	uint256 internal id = 0;



	Teacher[] public teachers;

	mapping(address => address[]) public teacherToStudents;
	mapping(address => uint256) public teacherAddrToID;
	


	modifier onlyTeacher(uint256 _id) {
		require(msg.sender == teachers[_id].addr);
		_;
	}

	function setTeacher( string memory  name, string memory department, address addr) public {
		Teacher memory teacher = Teacher(
			id,
			name,
			department,
			addr
		);

		teachers.push(teacher);

		emit TeacherEvent(msg.sender, id, name);

		id += 1;
	}
	

	function addStudent(uint256 teacherID, address studentAddr) onlyTeacher(teacherID) public {
		teacherToStudents[msg.sender].push(studentAddr);
	}

	function giveReward(uint256 teacherID,address studentAddr, uint32 grade) onlyTeacher(teacherID) public {
		if(grade <= 100 && grade > 90) {
			_mint(studentAddr, 100);
		} else if( grade > 80 && grade <= 90) {
			_mint(studentAddr, 90);
		} else if( grade > 70 && grade <= 80) {
			_mint(studentAddr, 80);
		} else if( grade > 60 && grade <= 70) {
			_mint(studentAddr, 70);
		} else if( grade > 50 && grade <= 60) {
			_mint(studentAddr, 60);
		}
	}
}
