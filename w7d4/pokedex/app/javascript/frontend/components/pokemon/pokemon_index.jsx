import React, { useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import PokemonIndexItem from './pokemon_index_item';
import { fetchAllPokemon } from './pokemon_slice';
import { Link, Outlet } from "react-router-dom";

export default function PokemonIndex() {
  const pokemon = useSelector(state => Object.values(state.entities.pokemon));
  const dispatch = useDispatch();
  const loading = useSelector(state => state.ui.loading['fetchAll']);
  
  useEffect(() => {
    dispatch(fetchAllPokemon());
  }, []);

  const pokemonBody = () => (
    <div className="pokemon-body">
      <ul>
        {pokemon.map(poke => (
          <PokemonIndexItem key={poke.id} pokemon={poke} />
        ))}
      </ul>
      <Outlet />
    </div>
  )

  const pokemonSpinner = () => (
    <div id="loading-pokeball-container">
      <div id="loading-pokeball"></div>
    </div>
  )

  return (
    loading ? pokemonSpinner() : pokemonBody()
  );
}
