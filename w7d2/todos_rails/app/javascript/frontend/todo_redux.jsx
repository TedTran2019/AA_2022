import React from 'react';
import { createRoot } from 'react-dom/client';
import { store } from './store/store';
import { Provider } from 'react-redux';
import App from './App';
import { fetchTodos } from './features/todo/todo_slice';
import { fetchSteps } from './features/step/step_slice'; 

document.addEventListener("DOMContentLoaded", () => {
  store.dispatch(fetchTodos());
  store.dispatch(fetchSteps());
  const container = document.getElementById("root");
  const root = createRoot(container);
  root.render(
    <Provider store={store}>
      <App />
    </Provider>
  )
});
