import React from 'react';
import BenchMap from './bench_map';
import { useSelector } from 'react-redux';
import { useParams } from  'react-router-dom';

export default function BenchShow () {
  const { benchId } = useParams();
  const bench = useSelector(state => state.entities.benches[benchId]);

  return (
    <div>
      <h2>BenchShow</h2>
      <BenchMap benches={[bench]}/>
      <div>
        <ul>
          <li>{bench.description}</li>
          <li>Lat: {bench.lat}</li>
          <li>Lng: {bench.lng}</li>
          <li>Seating: {bench.seating}</li>
        </ul>
      </div>
    </div>
  );
}
