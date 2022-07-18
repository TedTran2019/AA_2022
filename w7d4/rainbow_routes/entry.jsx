import React from 'react';
import { createRoot } from 'react-dom/client';
import {
  BrowserRouter,
  HashRouter,
  Routes,
  Route,
} from "react-router-dom";
import Rainbow from './components/rainbow.jsx';
import Blue from './components/blue.jsx';
import Green from './components/green.jsx';
import Indigo from './components/indigo.jsx';
import Orange from './components/orange.jsx';
import Red from './components/red.jsx';
import Violet from './components/violet.jsx';
import Yellow from './components/yellow.jsx';

// This works for Hashrouter but not BrowserRouter
document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('main');
  const root = createRoot(container);
  root.render(
    <HashRouter>
      <Routes>
        <Route path="/" element={<Rainbow />} >
          <Route path="red" element={<Red />} >
            <Route path="orange" element={<Orange />} />
            <Route path="yellow" element={<Yellow />} />
          </Route>
          <Route path="green" element={<Green />} />
          <Route path="blue" element={<Blue />} >
            <Route path="indigo" element={<Indigo />} />
          </Route>
          <Route path="violet" element={<Violet />} />
        </Route>
      </Routes>
    </HashRouter>
  );
});
