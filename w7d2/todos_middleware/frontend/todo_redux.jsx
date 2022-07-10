import React from 'react';
import { createRoot } from 'react-dom/client';
import configureStore from './store/store';

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("root");
  const root = createRoot(container);
  window.store = configureStore();
  // store.dispatch = addLoggingToDispatch(store);
  // store = applyMiddlewares(store, addLoggingToDispatch);
  root.render(
    <div>
      Hello World
    </div>);
});

// const addLoggingToDispatch = (store) => {
//   const dispatch = store.dispatch;
//   return (action) => {
//     console.log(store.getState());
//     console.log(action);
//     dispatch(action);
//     console.log(store.getState());
//   }
// }

// const addLoggingToDispatch = store => next => action => {
//   console.log(store.getState());
//   console.log(action);
//   next(action);
//   console.log(store.getState());
// }

// const applyMiddlewares = (store, ...middlewares) => {
//   const dispatch = store.dispatch;
//   middlewares.forEach(middleware => {
//     dispatch = middleware(store)(dispatch); // Raises dispatch is read-only error
//   })
//   return Object.assign({}, store, { dispatch });
// }

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
