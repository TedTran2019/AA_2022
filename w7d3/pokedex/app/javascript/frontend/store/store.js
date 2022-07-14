import { combineReducers } from 'redux';
import { configureStore } from "@reduxjs/toolkit"
import logger from 'redux-logger';
import thunk from 'redux-thunk';
import pokemonReducer from '../components/pokemon/pokemon_slice';
import movesReducer from '../components/moves/moves_slice';
import itemsReducer from '../components/items/items_slice';
import errorsReducer from '../components/errors/errors_slice';
import loadingReducer from '../components/loading/loading_slice';

const entityReducer = combineReducers({
  pokemon: pokemonReducer,
  moves: movesReducer,
  items: itemsReducer,
})

const uiReducer = combineReducers({
  errors: errorsReducer,
  loading: loadingReducer,  
})

export const store = configureStore({
  reducer: { 
    entities: entityReducer,
  },
  middleware: [thunk, logger],  
})
