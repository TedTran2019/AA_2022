import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import StepListItem from './step_list_item';
import StepForm from './step_form';

export default function StepList ({steps, todo_id}) {
  return (
    <div>
      <h2>Step List</h2>
      <ul>
        { steps.map(step => (
          <StepListItem 
            step={step}
            key={step.id}
          />
        ))}
      </ul>
      <StepForm 
        todo_id={todo_id}
      />
    </div>
  )
}
