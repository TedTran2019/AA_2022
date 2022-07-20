import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { useState, useEffect } from 'react';
import { createPokemonTwo, createPokemon } from './pokemon_slice';
import { useNavigate } from 'react-router-dom';

export default function PokemonForm () {
  const [name, setName] = useState('');
  const [image_url, setImageUrl] = useState('');
  const [poke_type, setPokeType] = useState('');
  const [attack, setAttack] = useState('');
  const [defense, setDefense] = useState('');
  const [moveOne, setMoveOne] = useState('');
  const [moveTwo, setMoveTwo] = useState('');
  const types = ["bug", "dragon", "electric", "fighting", "fire", "flying", "ghost",
                "grass", "ground", "ice", "normal", "poison", "psychic", "rock",
                "steel", "water"]
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const errors = useSelector(state => state.ui.errors);

  const handleCreatePokemon = (e) => {
    e.preventDefault();
    // const pokemon = createPokemonTwo({name, image_url, poke_type, attack, defense})(dispatch)()
    // .then(pokemon => {console.log(pokemon)});
    dispatch(createPokemon({name, image_url, poke_type, attack, defense, move_one: moveOne, move_two: moveTwo}))
    .then(response => {
      if (response.payload.pokemon) {
        navigate(`/pokemon/${response.payload.pokemon.id}`)
      } else {
        console.log(response.payload)
      }
    });
  }

  const handleNameChange = (e) => {
    setName(e.target.value);
  }

  const handleImageUrlChange = (e) => {
    setImageUrl(e.target.value);
  }

  const handleSetPokeType = (e) => {
    setPokeType(e.target.value);
  }

  const handleAttackChange = (e) => {
    setAttack(e.target.value);
  }

  const handleDefenseChange = (e) => {
    setDefense(e.target.value);
  }

  const handleMoveOneChange = (e) => {
    setMoveOne(e.target.value);
  }

  const handleMoveTwoChange = (e) => {
    setMoveTwo(e.target.value);
  }
  
  return (
    <div>
      <h1>Pokemon Form</h1>
      {errors.map(error => <p>{error}</p>)}
      <form onSubmit={handleCreatePokemon}>
        <input onChange={handleNameChange} type="text" placeholder="Name" value={name} />
        <input onChange={handleImageUrlChange} type="text" placeholder="Image Url" value={image_url} />
        <select onChange={handleSetPokeType} value={poke_type} >
          <option key="0" value="" disabled>Select a type</option>
          {types.map(pokeType => <option key={pokeType} value={pokeType}>{pokeType}</option>)}
        </select>
        <input onChange={handleAttackChange} type="number" placeholder="Attack" value={attack} />
        <input onChange={handleDefenseChange} type="number" placeholder="Defense" value={defense} />
        <input onChange={handleMoveOneChange} type="text" placeholder="Move 1" value={moveOne} />
        <input onChange={handleMoveTwoChange} type="text" placeholder="Move 2" value={moveTwo} />
        <button>Create Pokemon</button>
      </form>
    </div>
  );
}
