// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ToDoList {
    struct Task {
        uint id;
        string content;
        bool completed;
        uint timestamp;
    }

    address public owner;
    uint public taskCount;
    mapping(uint => Task) public tasks;

    event TaskCreated(uint id, string content, uint timestamp);
    event TaskToggled(uint id, bool completed);
    event TaskUpdated(uint id, string newContent);
    event TaskDeleted(uint id);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
        taskCount = 0;
    }

    function createTask(string calldata _content) public onlyOwner {
        taskCount++;
        tasks[taskCount] = Task(taskCount, _content, false, block.timestamp);
        emit TaskCreated(taskCount, _content, block.timestamp);
    }

    function toggleComplete(uint _taskId) public onlyOwner {
        tasks[_taskId].completed = !tasks[_taskId].completed;
        emit TaskToggled(_taskId, tasks[_taskId].completed);
    }

    function updateTask(uint _taskId, string calldata _newContent) public onlyOwner {
        tasks[_taskId].content = _newContent;
        emit TaskUpdated(_taskId, _newContent);
    }

    function deleteTask(uint _taskId) public onlyOwner {
        delete tasks[_taskId];
        emit TaskDeleted(_taskId);
    }

    function getTask(uint _taskId) public view returns (Task memory) {
        return tasks[_taskId];
    }
}
