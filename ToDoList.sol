// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ToDoList {

    struct Task {
        uint id;
        string name;
        string date;
    }

    address owner;

    Task task;
    mapping (uint => Task) tasks; // list of all tasks
    uint taskId = 1;
    event taskCreate(uint taskId, string name);
    event taskUpdate(uint taskId, string name);
    event taskDelete(uint taskId);

    /*Modifiers in Solidity are used to add custom conditions 
    or checks to functions before they can be executed. 
    They provide a way to encapsulate common checks and conditions, 
    making code more readable, maintainable, and secure. */

    modifier checkId(uint id){
        require(id != 0 && id < taskId, "Invalid Id");
        _;
    }

    modifier onlyOwner(){
    require(msg.sender==owner,"Invalid Owner");
    _;
    }

    constructor() {
        owner = msg.sender;
    }
    // In Solidity, calldata is a special location where function arguments are stored. 
    // It is used for function parameters that are read-only and used for input data.

    function createTask( string calldata _taskName, string calldata _data ) public {
        tasks[taskId] = Task(taskId, _taskName, _data);
        taskId++;
        emit taskCreate(taskId,_taskName);
        
    }

    function updateTask( uint _taskId, string calldata _taskName, string calldata _data) checkId(_taskId) public {
        tasks[_taskId] = Task(_taskId, _taskName, _data);
        emit taskUpdate(taskId,_taskName);
    }

    function allTask() public view returns(Task[] memory){
        Task[] memory taskList = new Task[](taskId-1);// array -> lenght -> taskId-1
        for(uint i=0;i<taskId-1;i++){
            taskList[i]=tasks[i+1];
    }
        return taskList;
    }

    function viewTask(uint _taskId) checkId(_taskId) public view returns(Task memory){
        return tasks[_taskId];
    }

    function deleteTask(uint _taskId) checkId(_taskId) public {
    //   takes the values to their initial 
      delete tasks[_taskId];
      emit taskDelete(_taskId);
    }
}


// contarct address -> 0x51f36149ff5ffb1dc7310c0226ce08ed4cbd711d