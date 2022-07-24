import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

export const filtersSlice = createSlice({
  name: 'filters',
  initialState: {
    bounds: {},
  },
  reducers: {
    setBounds: (state, action) => {
      state.bounds = action.payload;
    }
  },
  extraReducers: {}
})

export const { setBounds } = filtersSlice.actions;

export default filtersSlice.reducer;
