import React from 'react';
import { createRoot } from 'react-dom/client'
import Game from './game.jsx';

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("root");
  const root = createRoot(container);
  root.render(
    <div>
      <Game
      />
    </div>);
});
