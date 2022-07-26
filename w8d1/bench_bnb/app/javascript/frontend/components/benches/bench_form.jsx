import React, { useState, useEffect } from 'react';
import { useDispatch } from 'react-redux';
import { Navigate } from 'react-router-dom';
import { createBench } from './benches_slice';
import { useNavigate } from 'react-router-dom';
import { useLocation } from 'react-router-dom';

export default function BenchForm () {
  const [bench, setBench] = useState({
    description: '',
    seating: '',
    lat: '',
    lng: '',
    rating: '',
    comment: ''
  });
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const location = useLocation();
  
  useEffect (() => {
    setBench({...bench, lat: location.state.lat, lng: location.state.lng});
  }, [])

  const handleChange = (e) => {
    setBench({ ...bench, [e.target.name]: e.target.value });
  }

  const handleSubmit = (e) => {
    e.preventDefault();
    dispatch(createBench({bench}))
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
      <h1>Bench Form</h1>
      <form onSubmit={handleSubmit}>
        <textarea onChange={handleChange} value={bench['description']} placeholder="description" 
        name="description" cols="30" rows="10"></textarea>
        <input onChange={handleChange} value={bench['lat']} name="lat" type="number" placeholder="latitude" disabled />
        <input onChange={handleChange} value={bench['lng']} name="lng" type="number" placeholder="langitude" disabled />
        <input onChange={handleChange} value={bench['seating']} name="seating" type="number" placeholder="total seating" />
        <input onChange={handleChange} min="1" max="5" value={bench['rating']} name="rating" type="number" placeholder="rating" />
        <input onChange={handleChange} value={bench['comment']} name="comment" type="text" placeholder="comment" />
        <button>Create Bench</button>
      </form>
    </div>
  );
}