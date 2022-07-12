import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

const initialState = []

export const errorSlice = createSlice({
  name: 'error',
  initialState,
  reducers: {
    addError: (state, action) => {
      state.push(action.payload);
      return state;
    },
    clearError: (state, action) => {
      state = []
      return state;
    }
  },
})

export const { addError, clearError } = errorSlice.actions

export default errorSlice.reducer
