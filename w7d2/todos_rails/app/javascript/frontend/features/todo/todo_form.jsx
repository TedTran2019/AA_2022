import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { useState, useEffect } from 'react';
// import { addTodo } from './todo_slice';
import { createTodo } from './todo_slice';

export default function TodoForm () {
  const dispatch = useDispatch();
  const [title, setTitle] = useState('');
  const [body, setBody] = useState('');
  const [tagNames, setTagNames] = useState([]);
  const [tag, setTag] = useState('');

  const makeTodo = (e) => {
    e.preventDefault();
    //dispatch(addTodo({ title, body, done: false, id: Date.now() }));
    dispatch(createTodo({ title, body, done: false, tag_names: tagNames })).then(() => {
      setTitle('');
      setBody('');
      setTagNames([]);
    })
  }

  const handleTitleChange = (e) => {
    setTitle(e.target.value);
  }

  const handleBodyChange = (e) => {
    setBody(e.target.value);
  }

  const handleTagChange = (e) => {
    setTag(e.target.value);
  }

  const handleTagNamesChange = (e) => {
    e.preventDefault();
    setTagNames([...tagNames, tag]);
    setTag('');
  }

  return (
    <div>
      <h1>Todo Form</h1>
      <form onSubmit={makeTodo}>
        <input onChange={handleTitleChange} type="text" value={title} placeholder="Title" />
        <textarea onChange={handleBodyChange} cols="30" rows="10" value={body} placeholder="Body"></textarea>
        <ul>
          {tagNames.map(tagName => <li key={tagName}>{tagName}</li>)}
        </ul>
        <input onChange={handleTagChange} type="text" value={tag} placeholder="New Tag" />
        <button onClick={handleTagNamesChange}>Create Tag</button>
        <button type="submit">Create Todo</button>
      </form>
    </div>
  )
}
