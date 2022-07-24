import React from 'react';
import BenchMap from './bench_map';
import BenchIndex from './bench_index';
import { fetchAllBenches } from './benches_slice';
import { useSelector, useDispatch } from 'react-redux';
import { useEffect } from 'react';

export default function Search () {
  const dispatch = useDispatch();
  const benches = useSelector(state => Object.values(state.entities.benches));
  const filters = useSelector(state => state.ui.filters)

  useEffect(() => {
    dispatch(fetchAllBenches(filters));
  }, [filters]);

  return (
    <div>
      <BenchMap benches={benches} />
      <BenchIndex benches={benches} />
    </div>
  );
}
