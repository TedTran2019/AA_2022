import React from 'react';
import { Link } from 'react-router-dom';

export default function BenchIndex ({benches}) {
  return (
    <div>
      <h1>Benches</h1>
      <ul>
        {benches.map(bench => <li key={bench.id}><Link to={`benches/${bench.id}`}>{bench.description}</Link></li> )}
      </ul>
    </div>
  );
}
