import React from 'react';
import { createRoot } from 'react-dom/client';
import configureStore from './store/store';

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("root");
  const root = createRoot(container);

  window.store = configureStore();
  root.render(
    <div>
      Hello World
    </div>);
});

// const newTodos = [{ id: 1, title: 'Learn Redux', body: 'It is fundamental', done: false }];
// const newSteps = [{ id: 1, title: 'Dispatch actions', done: false, todo_id: 1 }];
// store.dispatch(receiveTodos(newTodos));
// store.dispatch(receiveSteps(newSteps));
// store.dispatch(receiveTodo({ id: 3, title: "New Todo" }));
// store.dispatch(receiveStep({ id: 3, title: "New Step" }));
// store.dispatch(receiveTodo({ id: 3, title: "Newer Todo" }));
// store.dispatch(receiveStep({ id: 3, title: "Newer Step" }));
// store.dispatch(removeTodo({ id: 3, title: "Newer Todo" }));
// store.dispatch(removeStep({ id: 3, title: "Newer Step"}));
// store.getState();
