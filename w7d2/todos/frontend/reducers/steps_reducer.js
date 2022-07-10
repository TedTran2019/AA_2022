import { RECEIVE_STEPS, RECEIVE_STEP, REMOVE_STEP } from "../actions/step_actions";


const stepsReducer = (state = initialState, action) => {
  switch (action.type) {
    case RECEIVE_STEPS:
      const newState = {};
      action.steps.forEach(step => {
        newState[step.id] = step;
      })
      return newState;
    case RECEIVE_STEP:
      const newStep = { [action.step.id]: action.step };
      return Object.assign({}, state, newStep);
    case REMOVE_STEP:
      const removeState = {};
      for (let key in state) {
        if (key !== String(action.step.id)) {
          removeState[key] = state[key];
        }
      }
      return removeState;
    default:
      return state;
  }
};

export default stepsReducer;

const initialState = {
  1: {
    id: 1,
    title: "wash car",
    body: "with soap",
    done: false
  },
  2: {
    id: 2,
    title: "wash dog",
    body: "with shampoo",
    done: true
  }
};