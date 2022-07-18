import React, { useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import {
  useParams,
  useNavigate,
  useLocation,
} from "react-router-dom";
import { fetchOnePokemon } from './pokemon_slice';

export default function PokemonDetail() {
  const params = useParams();
  const dispatch = useDispatch();
  dispatch(fetchOnePokemon(params.pokemonId));
  
  return (
    <div>
      Hi
    </div>
  );
}
