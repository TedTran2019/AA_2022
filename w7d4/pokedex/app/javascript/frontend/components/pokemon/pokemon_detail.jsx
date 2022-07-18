import React, { useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import {
  useParams,
  useNavigate,
  useLocation,
} from "react-router-dom";
import { fetchOnePokemon } from './pokemon_slice';
import Items from '../items/items';

export default function PokemonDetail() {
  const params = useParams();
  const dispatch = useDispatch();
  useEffect(() => {
    dispatch(fetchOnePokemon(params.pokemonId));
  }, [params.pokemonId]);

  const pokemon = useSelector(state => state.entities.pokemon[params.pokemonId]);
  const moves = useSelector(state => Object.values(state.entities.moves));

  const pokemonData = () => (
    <div>
      <img src={pokemon.imageUrl} />
      <h1>{pokemon.name}</h1>
      <h3>Type: {pokemon.pokeType}</h3>
      <h3>Attack: {pokemon.attack}</h3>
      <h3>Defense: {pokemon.defense}</h3>
      <h3>Moves: {moves.map(move => move.name).join(', ')}</h3>
      {<Items />}
    </div>
  )

  return (
    <div>
      { pokemon ? pokemonData() : <div>Loading...</div> }
    </div>
  );
}
