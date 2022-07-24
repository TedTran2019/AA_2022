import React, { useState } from 'react';
import { useDispatch } from 'react-redux';
import { Navigate } from 'react-router-dom';
import { createBench } from './benches_slice';
import { useNavigate } from 'react-router-dom';

export default function BenchForm () {
  const [bench, setBench] = useState({
    description: '',
    seating: '',
    lat: '',
    lng: '',
  });
  const dispatch = useDispatch();
  const navigate = useNavigate();
  
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
        <input onChange={handleChange} value={bench['lat']} name="lat" type="number" placeholder="latitude"/>
        <input onChange={handleChange} value={bench['lng']} name="lng" type="number" placeholder="langitude" />
        <input onChange={handleChange} value={bench['seating']} name="seating" type="number" placeholder="total seating" />
        <button>Create Bench</button>
      </form>
    </div>
  );
}