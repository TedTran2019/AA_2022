import React from 'react';
import { createRoot } from 'react-dom/client';
import { store } from './store/store';
import { Provider } from 'react-redux';
import App from './App';
import { fetchTodos } from './features/todo/todo_slice';

document.addEventListener("DOMContentLoaded", () => {
  store.dispatch(fetchTodos()); // Testing
  const container = document.getElementById("root");
  const root = createRoot(container);
  root.render(
    <Provider store={store}>
      <App />
    </Provider>
  )
});
