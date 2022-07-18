import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

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

export const pokemonSlice = createSlice({
  name: 'pokemon',
  initialState: {},
  reducers: {},
  extraReducers: {
    [fetchAllPokemon.fulfilled]: (state, action) => {
      console.log(state);
      console.log(action.payload);
      state = action.payload;
      return state;
    },
    [fetchOnePokemon.fulfilled]: (state, action) => {
      state[action.payload.pokemon.id] = action.payload.pokemon;
    }
  }
})

export const {} = pokemonSlice.actions;

export default pokemonSlice.reducer;