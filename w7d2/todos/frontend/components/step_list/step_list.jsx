import React from 'react';
import StepForm from './step_form';
import StepListItemContainer from './step_list_item_container';

export default function StepList ({ steps, todo_id, receiveStep }) {
  console.log(steps);
  const stepItems = steps.map(step => (
    <StepListItemContainer
      key={step.id}
      step={step} 
    />
  ))

  return (
    <div>
      <ul>
        { stepItems }
      </ul>
      <StepForm todo_id={todo_id} receiveStep={receiveStep} />
    </div>
  );
} 
