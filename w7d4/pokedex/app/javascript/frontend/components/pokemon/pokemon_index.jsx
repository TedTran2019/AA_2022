import React, { useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import PokemonIndexItem from './pokemon_index_item';
import { fetchAllPokemon } from './pokemon_slice';
import { Link, Outlet } from "react-router-dom";

export default function PokemonIndex() {
  const pokemon = useSelector(state => Object.values(state.entities.pokemon));
  const dispatch = useDispatch();
  
  useEffect(() => {
    dispatch(fetchAllPokemon());
  }, []);

  return (
    <div>
      <h1>Pokemon Index</h1>
      <ul>
        {pokemon.map(poke => (
          <PokemonIndexItem key={poke.id} pokemon={poke} />
        ))}
      </ul>
      <Outlet/>
    </div>
  );
}
