import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import { getCSRF } from '../../util/csrf_token';
import { addError, clearError } from '../error/error_slice';

const initialState = [
  { id: 1, title: "ATTAC", body: "with soap", done: false },
  { id: 2, title: "DEFEND", body: "with soap", done: false },
]

export const fetchSteps = createAsyncThunk(
  'api/steps/index',
  async () => {
    const response = await fetch('/api/steps')
    return response.json();
  }
)

export const createStep = createAsyncThunk(
  'api/steps/create',
  async (step, { dispatch, getState, rejectWithValue, fulfillWithValue }) => {
    const csrfToken = await getCSRF();
    const response = await fetch('/api/steps', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify(step)
    })
    if (response.ok) {
      dispatch(clearError());
      return response.json(); 
    } else {
      dispatch(addError(response.statusText));
      return rejectWithValue(response.status);
    }
  }
)

export const deleteStep = createAsyncThunk(
  'api/steps/delete',
  async (step_id, { dispatch, getState, rejectWithValue, fulfillWithValue }) => {
    const csrfToken = await getCSRF();
    const response = await fetch(`/api/steps/${step_id}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
    })
    if (response.ok) {
      dispatch(clearError());
      return response.json(); // Response from Rails controller returns json object 
    } else {
      dispatch(addError(response.statusText));
      return rejectWithValue(response.status);
    }
  }
)

export const updateStep = createAsyncThunk(
  'api/steps/update',
  async (step, { dispatch, getState, rejectWithValue, fulfillWithValue }) => {
    const csrfToken = await getCSRF();
    const response = await fetch(`/api/steps/${step.id}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({done: !step.done})
    })
    if (response.ok) {
      dispatch(clearError());
      return response.json(); // Response from Rails controller returns json object 
    } else {
      dispatch(addError(response.statusText));
      return rejectWithValue(response.status);
    }
  }
)

// Can write mutating logic because it uses the Immer library
export const stepSlice = createSlice({
  name: 'step',
  initialState,
  reducers: {
    addSteps: (state, action) => {
      state = action.payload
      return state;
    },
    addStep: (state, action) => {
      state.push(action.payload);
      return state;
    },
    removeStep: (state, action) => {
      state = state.filter(step => {
        return step.id !== action.payload
      })
      return state;
    },
    toggleStep: (state, action) => {
      state.forEach(step => {
        if (step.id === action.payload) {
          step.done = !step.done;
          return step;
        }
      })
    }
  },
  extraReducers: {
    [fetchSteps.fulfilled]: (state, action) => {
      state = action.payload
      return state;
    },
    [createStep.fulfilled]: (state, action) => {
      state.push(action.payload);
    },
    [deleteStep.fulfilled]: (state, action) => {
      state = state.filter(step => {
        return step.id !== action.payload.id
      })
      return state;
    },
    [updateStep.fulfilled]: (state, action) => {
      state.forEach(step => {
        if (step.id === action.payload.id) {
          step.done = action.payload.done;
          return step;
        }
      })
    }
  }
})

// Action creators generated for each case reducer function
export const { addSteps, addStep, removeStep, toggleStep } = stepSlice.actions

export default stepSlice.reducer
