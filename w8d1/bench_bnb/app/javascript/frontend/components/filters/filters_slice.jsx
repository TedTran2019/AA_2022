import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

export const filtersSlice = createSlice({
  name: 'filters',
  initialState: {
    bounds: {},
    min_seating: 1,
    max_seating: 10,
  },
  reducers: {
    setBounds: (state, action) => {
      state.bounds = action.payload;
    },
    setMinSeating: (state, action) => {
      state.min_seating = action.payload;
    },
    setMaxSeating: (state, action) => {
      state.max_seating = action.payload;
    }
  },
  extraReducers: {}
})

export const { setBounds, setMinSeating, setMaxSeating } = filtersSlice.actions;

export default filtersSlice.reducer;
