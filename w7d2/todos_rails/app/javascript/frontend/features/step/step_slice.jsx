import { createSlice } from '@reduxjs/toolkit'

const initialState = [
  { id: 1, title: "ATTAC", body: "with soap", done: false },
  { id: 2, title: "DEFEND", body: "with soap", done: false },
]

// Can write mutating logic because it uses the Immer library
export const stepSlice = createSlice({
  name: 'step',
  initialState,
  reducers: {
    addSteps: (state, action) => {
      state = action.payload
      return state;
    },
    addStep: (state, action) => {
      state.push(action.payload);
      return state;
    },
    removeStep: (state, action) => {
      state = state.filter(step => {
        return step.id !== action.payload
      })
      return state;
    },
    toggleStep: (state, action) => {
      state.forEach(step => {
        if (step.id === action.payload) {
          step.done = !step.done;
          return step;
        }
      })
    }
  }
})

// Action creators generated for each case reducer function
export const { addSteps, addStep, removeStep, toggleStep } = stepSlice.actions

export default stepSlice.reducer
