// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

interface IScore {
    function setScore(address student,uint score) external;
}

contract Score {
    mapping (address => uint) studentScore;
    address public owner;
    address public teacher;
    error NotTeacher();

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(owner == msg.sender,"Not owner");
        _;
    }

    modifier onlyTeacher {
        if (teacher != msg.sender) {
            revert NotTeacher();
        }
        _;
    }

    function setTeacher(address newTeacher) public onlyOwner{
        teacher = newTeacher;
    }

    function setScore(address student,uint score) external onlyTeacher{
        studentScore[student] = score;
    }
}

contract Teacher {
    IScore score;

    constructor(address s) {
        score = IScore(s);
    }

    function callSetScore(address student,uint value) public {
        score.setScore(student,value);
    }
}