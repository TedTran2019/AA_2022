import { configureStore } from '@reduxjs/toolkit'
import thunk from 'redux-thunk';
import logger from 'redux-logger'
import giphyReducer from '../components/giphy_slice'
const store = configureStore({
  reducer: {
    giphy: giphyReducer
  },
  middleware: [thunk, logger]
});

export default store;
