import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

export default function TodoList () {
  const todos = useSelector(state => state.todos);
  return (
    <div>
      <h1>To-Do List</h1>
      <ul>
        { todos.map(todo => (
          <TodoListItem 
            key={todo.id}
            todo={todo}
          />
        )) }
      </ul>
      <TodoForm />
    </div>
  )
}
