import React from 'react';
import { Link, Outlet } from "react-router-dom";

export default function PokemonIndexItem({pokemon}) {
  const link = `/pokemon/${pokemon.id}`;
  return (
    <div>
      <Link to={link}>
        <li>{pokemon.name}</li>
        <img width="50" height="50" src={pokemon.imageUrl} />
      </Link>
    </div>
  )
}
