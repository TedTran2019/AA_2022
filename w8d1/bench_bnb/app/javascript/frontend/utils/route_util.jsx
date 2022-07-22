import React from 'react';
import { useSelector } from 'react-redux';
import { useNavigate } from 'react-router-dom';
import { useEffect } from 'react';

export const ProtectedRoute = ({ children }) => {
  const user = useSelector(state => state.session.id);
  const navigate = useNavigate();

  useEffect(() => {
    if (user) {
      navigate('/');
    }
  })

  if (!user) {
    return children;
  }
}
