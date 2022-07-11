import React from 'react';

export default function StepListItem ({ step, removeStep, receiveStep }) {
  const setDone = () => {
    const toggledStep = Object.assign(
      {},
      step,
      { done: !step.done }
    );
    receiveStep(toggledStep);
  }
  return (
    <li>
      <h1>{step.title}</h1>
      <p>{step.body}</p>
      <button onClick={() => removeStep(step)}>Delete</button>
      <button onClick={setDone}>{step.done ? "Not done" : "Done"}</button>
    </li>
  );
}
