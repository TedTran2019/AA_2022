import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

export const loadingSlice = createSlice({
  name: 'loading',
  initialState: {},
  reducers: {},
  extraReducers: {}
})

export const { } = loadingSlice.actions;

export default loadingSlice.reducer;