import React from 'react';
import { createRoot } from 'react-dom/client';
import { store } from './store/store';
import { Provider } from 'react-redux';
import PokemonIndex from './components/pokemon/pokemon_index';
import PokemonDetail from './components/pokemon/pokemon_detail';
import ItemDetail from './components/items/item_detail';
import {
  BrowserRouter,
  Routes,
  Route,
} from "react-router-dom";

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("root");
  const root = createRoot(container);
  // window.store = store;
  root.render(
    <Provider store={store}>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<PokemonIndex/>} >
            <Route path="/pokemon/:pokemonId" element={<PokemonDetail/>} >
              <Route path="/pokemon/:pokemonId/items/:itemId" element={<ItemDetail />} />
            </Route>
          </Route>
        </Routes>
      </BrowserRouter>
    </Provider>
  )
});
