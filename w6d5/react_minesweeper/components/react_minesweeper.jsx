import React from 'react';
import { createRoot } from 'react-dom/client'

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("root");
  const root = createRoot(container);
  root.render(
    <div>
      <Etc
      />
    </div>);
});
