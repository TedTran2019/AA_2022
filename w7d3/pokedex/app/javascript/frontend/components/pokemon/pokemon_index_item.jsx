import React from 'react';

export default function PokemonIndexItem({pokemon}) {
  return (
    <div>
      <li>{pokemon.name}</li>
      <img src={pokemon.imageUrl} />
    </div>
  )
}