import React from 'react';
import { createRoot } from 'react-dom/client';
import { store } from './store/store';
import { Provider } from 'react-redux';
import {
  BrowserRouter,
  Routes,
  Route,
} from "react-router-dom";
import App from './app';
import SessionForm from './components/session/session_form';
import { ProtectedRoute } from './utils/route_util';
import Search from './components/benches/search';
import BenchForm from './components/benches/bench_form';

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("root");
  const root = createRoot(container);
  window.store = store;
  root.render(
    <Provider store={store}>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<App />} >
            <Route path="/login" element={
              <ProtectedRoute>
                <SessionForm formType="login" />
              </ProtectedRoute>
              } />
            <Route path="/signup" element={
              <ProtectedRoute>
                <SessionForm formType="signup" />
              </ProtectedRoute>
              } />
            <Route end path="/" element={<Search />} />
          </Route>
          <Route path="/benches/new" element={<BenchForm />} />
        </Routes>
      </BrowserRouter>
    </Provider>
  )
});
