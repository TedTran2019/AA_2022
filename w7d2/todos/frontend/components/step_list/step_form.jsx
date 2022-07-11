import React, { useState, useEffect } from 'react';
import uniqueId from '../../util/unique_id';

export default function StepForm ({todo_id, receiveStep}) {
  const [state, setState] = useState({
    title: "",
    body: "",
    done: false,
    todo_id: todo_id
  });

  const handleSubmit = (e) => {
    e.preventDefault();
    const step = Object.assign({}, state, { id: uniqueId() });
    receiveStep(step);
    setState({
      title: "",
      body: "",
      done: false,
      todo_id: todo_id
    })
  }

  const updateTitle = (e) => {
    const new_state = Object.assign({}, state, { title: e.target.value });
    setState(new_state);
  }

  const updateBody = (e) => {
    const new_state = Object.assign({}, state, {body: e.target.value});
    setState(new_state);
  }

  return (
    <form onSubmit={handleSubmit}>
      <input type="text" value={state.title} onChange={updateTitle} placeholder="Title" />
      <input type="text" value={state.body} onChange={updateBody} placeholder="Body" />
      <input type="submit" value="Add Step" />
    </form>
  );
}