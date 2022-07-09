/*
import { configureStore} from '@reduxjs/toolkit';
import rootReducer from './reducer';

const store = configureStore({ reducer: rootReducer });
// Redux-Thunk and Redux DevTools Extension automatically turned on

export default store
*/

import { createStore } from 'redux';
import rootReducer from '../reducers/root_reducer';

const configureStore = () => {
  return createStore(rootReducer);
}

export default configureStore;
