import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

export const errorsSlice = createSlice({
  name: 'errors',
  initialState: {
    session: [],
    users: [],
  },
  reducers: {
    addSessionErrors: (state, action) => {
      state['session'] = action.payload;
    },
    clearSessionErrors: (state) => {
      state['session'] = [];
    },
    addUserErrors: (state, action) => {
      state['users'] = action.payload;
    },
    clearUserErrors: (state) => {
      state['users'] = [];
    },
    addBenchErrors: (state, action) => {
      state['benches'] = action.payload;
    },
    clearBenchErrors: (state) => {
      state['benches'] = [];
    },
    clearAllErrors: (state) => {
      state['session'] = [];
      state['users'] = [];
    }
  },
  extraReducers: {}
})

export const { 
  addSessionErrors, clearSessionErrors, 
  addUserErrors, clearUserErrors,
  addBenchErrors, clearBenchErrors,
  clearAllErrors,
} = errorsSlice.actions;

export default errorsSlice.reducer;
