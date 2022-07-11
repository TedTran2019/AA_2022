import React from 'react';
import { removeStep, toggleStep } from './step_slice';
import { useSelector, useDispatch } from 'react-redux';

export default function StepListItem ({step}) {
  const dispatch = useDispatch();

  const handleDelete = (e) => {
    e.preventDefault();
    dispatch(removeStep(step.id));
  }

  const handleToggle = (e) => {
    e.preventDefault();
    dispatch(toggleStep(step.id));
  }

  return (
    <li>
      <h3>{step.title}</h3>
      <p>{step.body}</p>
      <button onClick={handleDelete}>Delete</button>
      <button onClick={handleToggle}>{step.done ? "Not done" : "Done"}</button>
    </li>
  )
}
