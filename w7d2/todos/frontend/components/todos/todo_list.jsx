import React from 'react';
import ToDoListItem from '../todo_list/todo_list_item';
import ToDoForm from '../todo_list/todo_form';

export default (props) => {
  return (
    <div>
      <h3>Todo List goes here!</h3>
      <ul>
        {props.todos.map((todo) => {
          return (
            <ToDoListItem 
              todo={todo}
              key={todo.id}
              receiveTodo={props.receiveTodo}
              removeTodo={props.removeTodo}
              updateTodo={props.updateTodo}
            />
          )
        })}
      </ul>
      <ToDoForm 
        receiveTodo={props.receiveTodo}
      />
    </div>
  )
}
