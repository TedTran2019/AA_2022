import React from 'react';
import { createRoot } from 'react-dom/client';
import { store } from './store/store';
import { Provider } from 'react-redux';
import PokemonIndex from './components/pokemon/pokemon_index';

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("root");
  const root = createRoot(container);
  root.render(
    <Provider store={store}>
      <PokemonIndex />
    </Provider>
  )
});
