import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import { fetchOnePokemon } from '../pokemon/pokemon_slice';

export const movesSlice = createSlice({
  name: 'moves',
  initialState: {},
  reducers: {},
  extraReducers: {
    [fetchOnePokemon.fulfilled]: (state, action) => {
      state = action.payload.moves;
      return state;
    }
  }
})

export const { } = movesSlice.actions;

export default movesSlice.reducer;