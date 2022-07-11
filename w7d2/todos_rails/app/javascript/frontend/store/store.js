import { configureStore } from '@reduxjs/toolkit'
import todoReducer from '../features/todo/todo_slice'
import stepReducer from '../features/step/step_slice'

export const store = configureStore({
  reducer: {
    todos: todoReducer,
    steps: stepReducer
  },
})
