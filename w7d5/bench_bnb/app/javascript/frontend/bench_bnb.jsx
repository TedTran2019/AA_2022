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

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("root");
  const root = createRoot(container);
  window.store = store;
  root.render(
    <Provider store={store}>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<App />} >
            <Route path="/login" element={<SessionForm formType="login" />} />
            <Route path="/signup" element={<SessionForm formType="signup" />} />
          </Route>
        </Routes>
      </BrowserRouter>
    </Provider>
  )
});
