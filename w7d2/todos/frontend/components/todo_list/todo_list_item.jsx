import React, { useEffect, useState } from 'react';
import TodoDetailView from '../todos/todo_detail_view';

function ToDoListItem(props) {
  const [done, setDone] = useState(props.todo.done);
  const [detail, setDetail] = useState(false);

  const removeTodo = (e) => {
    e.preventDefault();
    props.removeTodo(props.todo);
  }

  const updateDone = (e) => {
    setDone(!done);
    const todo = { ...props.todo, done: !done };
    props.updateTodo(todo);
  }

  const updateDetail = (e) => {
    e.preventDefault();
    setDetail(!detail);
  }

  return (
    <div>
      <li>{props.todo.title}</li>
      <button onClick={removeTodo}>Remove</button>
      <label>
        <input type="checkbox" checked={done} onChange={updateDone} />
        Done
      </label>
      <button onClick={updateDetail}>Details</button>
      { detail ? <TodoDetailView todo={props.todo} /> : "" }
    </div>
  )
}

export default ToDoListItem;