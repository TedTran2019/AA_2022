import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { useState, useEffect } from 'react';
import { addStep } from './step_slice';
import { createStep } from './step_slice';

export default function StepForm ({todo_id}) {
  const dispatch = useDispatch();
  const [title, setTitle] = useState('');
  const [body, setBody] = useState('');

  const makeStep = (e) => {
    e.preventDefault();
    // dispatch(addStep({ title, body, done: false, id: Date.now(), todoId: todoId }));
    dispatch(createStep({ title, body, done: false, todo_id: todo_id }));
    setTitle('');
    setBody('');
  }

  const handleTitleChange = (e) => {
    setTitle(e.target.value);
  }

  const handleBodyChange = (e) => {
    setBody(e.target.value);
  }

  return (
    <div>
      <h2>Step Form</h2>
      <form onSubmit={makeStep}>
        <input type="text" onChange={handleTitleChange} value={title} placeholder="title" />
        <textarea onChange={handleBodyChange} value={body} placeholder="body" cols="30" rows="10"></textarea>
        <button type="submit">Add Step</button>
      </form>
    </div>
  )
}
