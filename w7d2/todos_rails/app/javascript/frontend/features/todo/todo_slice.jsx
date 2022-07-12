import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import { getCSRF } from '../../util/csrf_token';
import { addError, clearError } from '../error/error_slice';
import { useDispatch } from 'react-redux';

const initialState = [
  { id: 1, title: "wash car", body: "with soap", done: false },
  { id: 2, title: "with dog", body: "with soap", done: false },
]

export const fetchTodos = createAsyncThunk(
  'api/todos', // Action Type
  async () => { // Callback function
    const response = await fetch('/api/todos')
    return response.json()
  }
)

export const createTodo = createAsyncThunk(
  'api/todos/create',
  async (todo, {dispatch, getState, rejectWithValue, fulfillWithValue}) => {
    try {
      const csrfToken = await getCSRF();
      const response = await fetch('/api/todos', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify(todo)
      })
      if (response.ok) {
        dispatch(clearError());
        return response.json(); // Returns Todo
      } else {
        dispatch(addError(response.statusText));
        return rejectWithValue(response.status); // Returns failed promise to trigger createTodo.rejected
      }
    } catch(error) {
      dispatch(addError(error.message));
      return rejectWithValue(error);
    }
  }
)

// Can write mutating logic because it uses the Immer library
export const todoSlice = createSlice({
  name: 'todo',
  initialState,
  reducers: {
    addTodos: (state, action) => {
      state = action.payload
      return state;
    },
    addTodo: (state, action) => {
      state.push(action.payload);
      return state;
    },
    removeTodo: (state, action) => {
      state = state.filter(todo => {
        return todo.id !== action.payload
      })
      return state;
    },
    toggleTodo: (state, action) => {
      state.forEach(todo => {
        if (todo.id === action.payload) {
          todo.done = !todo.done;
          return todo;
        }
      })
    }
  },
  // Can use builder or object[key] notation like here
  extraReducers: {
    [fetchTodos.pending]: (state, action) => {
      console.log('Promise pending!');
    },
    [fetchTodos.fulfilled]: (state, action) => {
      console.log('Promise fulfilled!');
      state = action.payload;
      return state;
    },
    [fetchTodos.rejected]: (state, action) => {
      console.log('Promise rejected!');
    },
    [createTodo.pending]: (state, action) => {
      console.log('Todo creation promise pending!');
    },
    [createTodo.fulfilled]: (state, action) => {
      console.log('Todo creation promise fulfilled!');
      state.push(action.payload);
      return state;
    },
    [createTodo.rejected]: (state, action) => {
      console.log('Failed to create Todo!');
    }
  }
})

// Action creators generated for each case reducer function
export const { addTodos, addTodo, removeTodo, toggleTodo } = todoSlice.actions

export default todoSlice.reducer
