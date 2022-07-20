import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import { fetchAllPokemon, fetchOnePokemon } from '../pokemon/pokemon_slice';

export const loadingSlice = createSlice({
  name: 'loading',
  initialState: {},
  reducers: {},
  extraReducers: {
    [fetchAllPokemon.pending] : (state, action) => {
      state['fetchAll'] = true;
    },
    [fetchAllPokemon.fulfilled] : (state, action) => {
      state['fetchAll'] = false;
    },
    [fetchAllPokemon.rejected] : (state, action) => {
      state['fetchAll'] = false;
    },
    [fetchOnePokemon.pending] : (state, action) => {
      state['fetchOne'] = true;
    },
    [fetchOnePokemon.fulfilled] : (state, action) => {
      state['fetchOne'] = false;
    },
    [fetchOnePokemon.rejected] : (state, action) => {
      state['fetchOne'] = false;
    }
  }
})

export const { } = loadingSlice.actions;

export default loadingSlice.reducer;
