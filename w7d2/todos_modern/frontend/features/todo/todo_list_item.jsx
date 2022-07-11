import React from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { removeTodo, toggleTodo } from './todo_slice';
import TodoDetailView from './todo_detail_view';

export default function TodoListItem ({todo}) {
  const [detail, setDetail] = useState(false);
  const dispatch = useDispatch();

  const remove = (e) => {
    e.preventDefault();
    dispatch(removeTodo(todo.id));
  }

  const toggle = (e) => {
    dispatch(toggleTodo(todo.id));
  }

  const showDetails = (e) => {
    e.preventDefault();
    setDetail(!detail);
  }

  return (
    <li>
      <h2>{todo.title}</h2>
      <button onClick={remove}>Remove</button>
      <label>
        <input type="checkbox" checked={todo.done} onChange={toggle} />
        Done
      </label>
      <button onClick={showDetails}>{detail ? "Hide Details" : "Details"}</button>
      { detail ? <TodoDetailView todo={todo} /> : "" }
    </li>
  )
}
