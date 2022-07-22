import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import { getCSRFToken } from '../../utils/utils';
import { addBenchErrors, clearBenchErrors } from '../errors/errors_slice';

export const createBench = createAsyncThunk(
  'api/benches/create',
  async (bench, { dispatch, rejectWithValue }) => {
    try {
      const csrfToken = getCSRFToken();
      const response = await fetch('/api/benches', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify(bench)
      });
      if (response.ok) {
        const bench = await response.json();
        dispatch(clearBenchErrors());
        return bench;
      } else {
        const errors = await response.json();
        dispatch(addBenchErrors(errors));
        return rejectWithValue(errors);
      }
    } catch (error) {
      return rejectWithValue(error);
    }
  }
)

export const fetchAllBenches = createAsyncThunk(
  'api/benches/all',
  async (arg, { dispatch, rejectWithValue }) => {
    try {
      const response = await fetch('/api/benches');
      if (response.ok) {
        const benches = await response.json();
        dispatch(clearBenchErrors());
        return benches;
      } else {
        const errors = await response.json();
        dispatch(addBenchErrors(errors));
        return rejectWithValue(errors);
      }
    } catch (error) {
      throw error;
    }
  }
)

export const benchesSlice = createSlice({
  name: 'benches',
  initialState: {},
  reducers: {
  },
  extraReducers: {
    [createBench.fulfilled]: (state, action) => {
      state[action.payload.id] = action.payload;
    },
    [fetchAllBenches.fulfilled]: (state, action) => {
      state = action.payload;
      return state;
    }
  }
})

export const {} = benchesSlice.actions;

export default benchesSlice.reducer;
