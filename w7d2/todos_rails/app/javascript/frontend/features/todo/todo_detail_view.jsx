import React from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import StepList from '../step/step_list';

export default function TodoDetailView({ todo }) {
  const stepsByTodoId = useSelector(state => {
    return state.steps.filter(step => step.todo_id === todo.id);
  });

  return (
    <div>
      <p>{todo.body}</p>
      <StepList 
        steps={stepsByTodoId}
        todo_id={todo.id}
      />
    </div>
  )
}
