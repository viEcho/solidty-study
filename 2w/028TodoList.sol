// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract TodoList{
    struct Todo{
        string text;
        bool completed;
    }

    Todo [] public todos;
    function create (string calldata _text) external {
        todos.push(Todo({text:_text, completed: false}));
    }

    function updateText(uint _index,string calldata _newText ) external{
        // 更新一个字段是 这种写法比下面写法省gas
        todos[_index].text = _newText;

        // 更新多个字段时，这种写法比上面写法省gas
        // Todo storage todo = todos [_index];
        // todo.text = _text;
    }

    function get(uint _index) external view returns(string memory,bool) {
        Todo memory todo = todos[_index];
        return (todo.text, todo.completed);
    }

    function toggleCompleted(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }
}