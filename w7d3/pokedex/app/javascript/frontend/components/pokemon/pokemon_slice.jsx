import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

export const fetchAllPokemon = createAsyncThunk(
  'api/pokemon/index',
  async () => {
    const response = await fetch('/api/pokemon');
    return response.json();
  }
)

export const pokemonSlice = createSlice({
  name: 'pokemon',
  initialState: {},
  reducers: {},
  extraReducers: {
    [fetchAllPokemon.fulfilled]: (state, action) => {
      state = action.payload;
      return state;
    }
  }
})

export const {} = pokemonSlice.actions;

export default pokemonSlice.reducer;