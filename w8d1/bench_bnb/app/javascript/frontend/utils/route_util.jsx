import React from 'react';
import { useSelector } from 'react-redux';
import { useNavigate } from 'react-router-dom';

export const ProtectedRoute = ({ children }) => {
  const user = useSelector(state => state.session.id);
  const navigate = useNavigate();

  if (user) {
    navigate('/');  
  } else {
    return children;
  }
}
