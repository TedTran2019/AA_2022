/*
import { configureStore} from '@reduxjs/toolkit';
import rootReducer from './reducer';

const store = configureStore({ reducer: rootReducer });
// Redux-Thunk and Redux DevTools Extension automatically turned on

export default store
*/

import { createStore } from 'redux';
import rootReducer from '../reducers/root_reducer';
import { applyMiddleware } from 'redux';

const configureStore = () => {
  return createStore(rootReducer, applyMiddleware(addLoggingToDispatch));
}

export default configureStore;

const addLoggingToDispatch = store => next => action => {
  console.log(store.getState());
  console.log(action);
  console.log("This is next: ");
  console.log(next);
  next(action);
  console.log(store.getState());
}
