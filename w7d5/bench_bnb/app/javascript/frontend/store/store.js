
import { combineReducers } from 'redux';
import { configureStore } from "@reduxjs/toolkit"
import logger from 'redux-logger';
import thunk from 'redux-thunk';
import sessionReducer from '../components/session/session_slice';
import userReducer from '../components/users/users_slice';
import errorsReducer from '../components/errors/errors_slice';

const entityReducer = combineReducers({
  users: userReducer,
})

const uiReducer = combineReducers({
  errors: errorsReducer,
})

export const store = configureStore({
  reducer: {
    entities: entityReducer,
    ui: uiReducer,
    session: sessionReducer,
  },
  middleware: [thunk, logger],
})
