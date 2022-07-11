import uniqueId from "../../util/unique_id";
import React, { useEffect, useState } from 'react';

export default function ToDoForm (props) {
  const [state, setState] = useState({
    title: "",
    body: "",
    done: false
  });
  // const [title, setTitle] = useState("");
  // const [body, setBody] = useState("");
  // const [done, setDone] = useState(false);

  const updateTitle = (e) => {
    setState({
      ...state,
      title: e.target.value
    });
  }

  const updateBody = (e) => {
    setState({
      ...state,
      body: e.target.value
    });
  }

  const updateDone = (e) => {

    setState({
      ...state,
      done: !(state.done)
    });
  }

  const addTodo = (e) => {
    e.preventDefault();
    const todo = Object.assign({}, state, {id: uniqueId()});
    props.receiveTodo(todo);
    resetState();
  }

  const resetState = () => {
    setState({
      title: "",
      body: "",
      done: false
    });
  }

  return (
    <div className="todo-form">
      <form onSubmit={addTodo}>
        <input onChange={updateTitle} value={state.title} type="text" placeholder="Add a new todo" />
        <textarea onChange={updateBody} cols="30" rows="10" value={state.body}></textarea>
        <label>
          <input type="checkbox" checked={state.done} onChange={updateDone} />
          Done
        </label>
        <button type="submit">Add</button>
      </form>
    </div>
  );
}
