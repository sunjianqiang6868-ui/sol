// SPDX-License-Identifier: MIT
// 合约状态变量 → 自动是 storage
// external 函数参数 → 必须用 calldata（最省 Gas）
// 函数内部临时变量 → 用 memory
// 想修改状态变量 → 用 storage 指针

pragma solidity 0.8.23;
contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todoList;
    //创建待办
    function create(string calldata _text) external {
        todoList.push(Todo({text: _text, completed: false}));
    }
    //完成任务
    function completeTodo(uint _index) external {
        require(_index < todoList.length, "transfinite ");
        todoList[_index].completed = true;
    }

    function updateText(uint _index, string calldata _text) external {
        //单个字段直接修改省Gas
        todoList[_index].text = _text;

        //多个字段
        //  Todo storage todo = todoList[_index];
        //  todo.text = _text;
    }

    //根据下标获取待办
    function get(uint _index) external view returns (Todo memory) {
        Todo memory todo = todoList[_index];
        return todo;
    }
}
