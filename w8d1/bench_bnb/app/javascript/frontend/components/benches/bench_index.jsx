import React from 'react';

export default function BenchIndex ({benches}) {
  return (
    <div>
      <h1>Benches</h1>
      <ul>
        { benches.map(bench => <li key={bench.id}>{bench.description}</li>) }
      </ul>
    </div>
  );
}
