import React, { useState, useEffect } from 'react';
import StepListContainer from '../step_list/step_list_container';

export default function TodoDetailView (props) {
  return (
    <div className="todo-detail-view">
      <p>{props.todo.body}</p>
      <StepListContainer todo_id={props.todo.id} />
    </div>
  );
}

