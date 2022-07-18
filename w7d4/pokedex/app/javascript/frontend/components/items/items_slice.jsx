import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import { fetchOnePokemon } from '../pokemon/pokemon_slice'; 

export const itemsSlice = createSlice({
  name: 'items',
  initialState: {},
  reducers: {},
  extraReducers: {
    [fetchOnePokemon.fulfilled]: (state, action) => {
      state = action.payload.items;
      return state;
    }
  }
})

export const {} = itemsSlice.actions;

export default itemsSlice.reducer;