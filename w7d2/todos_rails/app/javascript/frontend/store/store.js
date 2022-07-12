import { configureStore } from '@reduxjs/toolkit'
import todoReducer from '../features/todo/todo_slice'
import stepReducer from '../features/step/step_slice'
import badThunk from '../middleware/thunk'
import logger from 'redux-logger'
import thunk from 'redux-thunk'
import errorReducer from '../features/error/error_slice'

export const store = configureStore({
  reducer: {
    todos: todoReducer,
    steps: stepReducer,
    errors: errorReducer,
  },
  middleware: [badThunk, logger] // Using hand rolled thunk instead of redux-thunk
})
