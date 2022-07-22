import React from 'react';
import Greeting from './components/greeting/greeting'
import { Outlet } from 'react-router-dom';
import { useDispatch } from 'react-redux';

export default function App() {
  const dispatch = useDispatch();
  // Fetch all users maybe?
  return (
    <div>
      <header>
        <h1>Bench BnB</h1>
        <Greeting />
      </header>
      <Outlet/>
    </div>
  )
}
