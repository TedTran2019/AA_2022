import React from 'react';
import { Route, Link, NavLink, Outlet } from 'react-router-dom';
import Indigo from './indigo';

export default function Blue() {
  return (
    <div>
      <h2 className="blue"></h2>
      <NavLink to="/blue/indigo">Indigo</NavLink>
      <NavLink end to="/blue">Blue</NavLink>      
      <div>
        <Outlet />
      </div>
    </div>
  );
}
