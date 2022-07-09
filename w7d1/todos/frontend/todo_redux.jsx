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
