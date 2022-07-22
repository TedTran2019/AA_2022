import React, { useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { fetchAllBenches } from './benches_slice';

export default function BenchIndex () {
  const dispatch = useDispatch();
  const benches = useSelector(state => Object.values(state.entities.benches));
  console.log(benches);

  useEffect(() => {
    dispatch(fetchAllBenches());
  }, []);

  return (
    <div>
      <h1>Benches</h1>
      <ul>
        { benches.map(bench => <li key={bench.id}>{bench.description}</li>) }
      </ul>
    </div>
  );
}
