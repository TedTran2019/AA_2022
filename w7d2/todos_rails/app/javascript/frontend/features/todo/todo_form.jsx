import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { useState, useEffect } from 'react';
// import { addTodo } from './todo_slice';
import { createTodo } from './todo_slice';

export default function TodoForm () {
  const dispatch = useDispatch();
  const [title, setTitle] = useState('');
  const [body, setBody] = useState('');

  const makeTodo = (e) => {
    e.preventDefault();
    //dispatch(addTodo({ title, body, done: false, id: Date.now() }));
    dispatch(createTodo({ title, body, done: false })).then(() => {
      setTitle('');
      setBody('');
    })
  }

  const handleTitleChange = (e) => {
    setTitle(e.target.value);
  }

  const handleBodyChange = (e) => {
    setBody(e.target.value);
  }

  return (
    <div>
      <h1>Todo Form</h1>
      <form onSubmit={makeTodo}>
        <input onChange={handleTitleChange} type="text" value={title} placeholder="Title" />
        <textarea onChange={handleBodyChange} cols="30" rows="10" value={body} placeholder="Body"></textarea>
        <button type="submit">Create Todo</button>
      </form>
    </div>
  )
}
