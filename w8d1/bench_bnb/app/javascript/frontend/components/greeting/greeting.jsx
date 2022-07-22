import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import {
  Link,
  useNavigate,
  useLocation,
} from "react-router-dom";
import { logoutUser } from '../session/session_slice';

export default function Greeting() {
  const currentUserId = useSelector(state => state.session.id);
  const currentUser = useSelector(state => state.entities.users[currentUserId]);
  const navigate = useNavigate();
  const dispatch = useDispatch();
  const location = useLocation().pathname;

  const logout = () => {
    // Reducers = pass in function
    // ExtraReducers = pass in object
    dispatch(logoutUser('ok'));
    navigate("/");
  }

  const loggedInGreeting = () => (
    <div>
      <h2>Welcome, {currentUser.username}!</h2>
      <button onClick={logout}>Logout</button>
    </div>
  )

  const bothLinks = () => (
    <div>
      <Link to={"/login"} >Login</Link>
      <Link to={"/signup"} >Sign up</Link>
    </div>
  )

  const loginLink = () => (
    <div>
      <Link to={'/login'}>Login</Link>
    </div>
  )

  const signupLink = () => (
    <div>
      <Link to={'/signup'}>Signup</Link>
    </div>
  )

  const loggedOutGreeting = () => {
    if (location === "/login") {
      return signupLink();
    } else if (location === "/signup") {
      return loginLink();
    } else {
      return bothLinks();
    }
  }

  return (
    currentUser ? loggedInGreeting() : loggedOutGreeting()
  )
}
