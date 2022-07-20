import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

export const errorsSlice = createSlice({
  name: 'errors',
  initialState: [],
  reducers: {
    addErrors: (state, action) => {
      state.push(...action.payload);
    },
    clearErrors: (state) => {
      state = [];
    }
  },
  extraReducers: {}
})

export const { addErrors, clearErrors } = errorsSlice.actions;

export default errorsSlice.reducer;