import React from 'react';
import {
  Route,
  Link,
  NavLink
} from 'react-router-dom';

import Red from './red';
import Green from './green';
import Blue from './blue';
import Violet from './violet';

export default function Rainbow() {
  return (
    <div>
      <h1>Rainbow Router!</h1>
      {/* Your links should go here */}

      <div id="rainbow">
        {/* Your routes should go here */}
      </div>
    </div>
  );
}
