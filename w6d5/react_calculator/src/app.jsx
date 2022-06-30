import React from 'react';
import { createRoot } from 'react-dom/client'
import Calculator from './calculator';

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("root");
  const root = createRoot(container);
  root.render(<Calculator />);
});
