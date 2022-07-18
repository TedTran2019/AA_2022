import React from 'react';
import { createRoot } from 'react-dom/client';
import { BrowserRouter } from "react-router-dom";
import Rainbow from './components/rainbow.jsx';

const Root = () => (
  <BrowserRouter>
    <Rainbow />
  </BrowserRouter>
);

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('main');
  const root = createRoot(container);
  root.render(<Root />);
});
