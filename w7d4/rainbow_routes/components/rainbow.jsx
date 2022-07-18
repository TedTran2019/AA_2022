import React from 'react';
import {
  Route,
  Link,
  NavLink,
  Outlet
} from 'react-router-dom';

import Red from './red';
import Green from './green';
import Blue from './blue';
import Violet from './violet';

export default function Rainbow() {
  return (
    <div>
      <h1>Rainbow Router!</h1>
      <Link to="/red">Red</Link>
      <Link to="/green">Green</Link>
      <Link to="/blue">Blue</Link>
      <Link to="/violet">Violet</Link>
      <Outlet />
    </div>
  );
}
