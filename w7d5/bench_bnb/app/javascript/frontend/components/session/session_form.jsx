import React from 'react';
import { useState, useEffect } from 'react';
import { loginUser } from './session_slice';
import { createUser } from '../users/users_slice';
import { useDispatch, useSelector } from 'react-redux';
import { useNavigate, useLocation } from 'react-router-dom';
import { clearAllErrors } from '../errors/errors_slice';

export default function SessionForm({formType}) {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const location = useLocation();

  useEffect(() => {
    dispatch(clearAllErrors());
    setUsername('');
    setPassword('');
  }, [location])

  let errors = useSelector(state => state.ui.errors);
  if (formType === 'login') {
    errors = errors['session'];
  } else {
    errors = errors['users'];
  }

  const handleUsernameChange = (e) => {
    setUsername(e.target.value);
  }

  const handlePasswordChange = (e) => {
    setPassword(e.target.value);
  }

  const handleSubmit = (e) => {
    e.preventDefault();
    const func = formType == "login" ? loginUser : createUser;
    dispatch(func({'user': {username, password}}))
    .then(response => {
      if (response.payload.id) {
        navigate('/');
      } else {
        console.log(response.payload);
      }
    })
  }

  return (
    <div>
      <h2>SessionForm</h2>
      <ul>
        { errors.map(error => <li key={error}>{error}</li>) }
      </ul>
      <form onSubmit={handleSubmit}>
        <input onChange={handleUsernameChange} type="text" placeholder="username" value={username} />
        <input onChange={handlePasswordChange} type="password" placeholder="password" value={password} />
        <button>{formType}</button>
      </form>
    </div>
  )
}
