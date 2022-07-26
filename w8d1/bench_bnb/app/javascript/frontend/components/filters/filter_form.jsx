import React from 'react';
import { useState, useEffect } from 'react';
import { useDispatch } from 'react-redux';
import { setMinSeating, setMaxSeating } from './filters_slice';

export default function FilterForm() {
  const [min, setMin] = useState(1);
  const [max, setMax] = useState(10);
  const dispatch = useDispatch();

  const handleMin = (e) => {
    let min = e.target.value;
    if (min !== '') {
      let min = parseInt(e.target.value, 10);
      dispatch(setMinSeating(min));
    }    
    setMin(min);
  }

  const handleMax = (e) => {
    let max = e.target.value;
    if (max !== '') {
      let max = parseInt(e.target.value, 10);
      dispatch(setMaxSeating(max));
    }
    setMax(max);
  }

  return (
    <div>
      <h2>FilterForm</h2>
      <form>
        <input onChange={handleMin} value={min} type="number" placeholder="min seating" />  
        <input onChange={handleMax} value={max} type="number" placeholder="max seating" />
      </form>        
    </div>
  );
}