import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

export const errorsSlice = createSlice({
  name: 'errors',
  initialState: [],
  reducers: {},
  extraReducers: {}
})

export const { } = errorsSlice.actions;

export default errorsSlice.reducer;