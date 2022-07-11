import { createSlice } from '@reduxjs/toolkit'

const initialState = [
  { id: 1, title: "wash car", body: "with soap", done: false },
  { id: 2, title: "with dog", body: "with soap", done: false },
]

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
      return state.last;
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
  }
})

// Action creators generated for each case reducer function
export const { addTodos, addTodo, removeTodo, toggleTodo } = todoSlice.actions

export default todoSlice.reducer
