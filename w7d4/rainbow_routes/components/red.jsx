import React from 'react';
import { Route, Link, NavLink, Outlet } from 'react-router-dom';
import Orange from './orange';
import Yellow from './yellow';

export default function Red () {
  return (
    <div>
      <h2 className="red"></h2>
      <NavLink to="/red/orange">Orange</NavLink>
      <NavLink to="/red/yellow">Yellow</NavLink>
      <NavLink end to="/red">Red</NavLink>
      <Outlet/>
    </div>
  );
}
