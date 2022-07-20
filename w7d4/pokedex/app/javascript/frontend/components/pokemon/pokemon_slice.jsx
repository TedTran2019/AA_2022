import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import { addErrors, clearErrors } from '../errors/errors_slice';
import React from 'react';

const getCSRFToken = () => {
  const csrfToken = document.querySelector('meta[name="csrf-token"]');
  return csrfToken.getAttribute('content');
}

export const fetchAllPokemon = createAsyncThunk(
  'api/pokemon/index',
  async () => {
    const response = await fetch('/api/pokemon');
    return response.json();
  }
)

// When more info is needed, fetchOne grabs more info and adds it into Pokemon state
// Items/Moves only correlate to a single Pokemon's since that's all we need
export const fetchOnePokemon = createAsyncThunk(
  'api/pokemon/show',
  async (id) => {
    const response = await fetch(`/api/pokemon/${id}`);
    return response.json();
  }
)

export const createPokemonQuery = (pokemon) => {
  const csrfToken = getCSRFToken();
  return fetch('/api/pokemon', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify(pokemon)
  })
}

// Returns the pokemon instead
export const createPokemonTwo = (pokemon) => (dispatch) => async () => {
  const response = await createPokemonQuery(pokemon);
  if (response.ok) {
    const newPokemon = await response.json();
    dispatch(addPokemon(newPokemon));
    dispatch(clearErrors());
    return newPokemon;
  } else {
    const error = await response.json();
    dispatch(addErrors(error));
    return false;
  }
}

export const createPokemon = createAsyncThunk(
  'api/pokemon/create',
  async (pokemon, {dispatch, getState, rejectWithValue, fulfillWithValue}) => {
    try {
      const csrfToken = await getCSRFToken();
      const response = await fetch('/api/pokemon', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify(pokemon)
      })
      if (response.ok) {
        const newPokemon = await response.json();
        dispatch(clearErrors);
        return newPokemon;
      } else {
        const error = await response.json();
        dispatch(addErrors(error));
        return rejectWithValue(error);
      }
    } catch (error) {
      return rejectWithValue(error);
    }
  }
)

export const pokemonSlice = createSlice({ 
  name: 'pokemon',
  initialState: {},
  reducers: {
    addPokemon: (state, action) => {
      state[action.payload.pokemon.id] = action.payload.pokemon;
    }
  },
  extraReducers: {
    [fetchAllPokemon.fulfilled]: (state, action) => {
      state = Object.assign({}, action.payload, state); // Stop overwriting more-info entries
      return state;
    },
    [fetchOnePokemon.fulfilled]: (state, action) => {
      state[action.payload.pokemon.id] = action.payload.pokemon;
    },
    [createPokemon.fulfilled]: (state, action) => {
      state[action.payload.pokemon.id] = action.payload.pokemon;
    },
    [createPokemon.rejected]: (state, action) => {
      console.log('Failed to create Pokemon!');
    }
  }
})

export const { addPokemon } = pokemonSlice.actions;

export default pokemonSlice.reducer;