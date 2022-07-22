
import { combineReducers } from 'redux';
import { configureStore } from "@reduxjs/toolkit"
import logger from 'redux-logger';
import thunk from 'redux-thunk';
import sessionReducer from '../components/session/session_slice';
import userReducer from '../components/users/users_slice';
import errorsReducer from '../components/errors/errors_slice';
import benchesReducer from '../components/benches/benches_slice';

let preloadedState = {}

if (window.currentUser) {
  preloadedState['entities'] = {
    users: { [window.currentUser.id]: window.currentUser }
  }
  preloadedState['session'] = { id: window.currentUser.id }
}

const entityReducer = combineReducers({
  users: userReducer,
  benches: benchesReducer
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
  preloadedState,
  middleware: [thunk, logger],
})
