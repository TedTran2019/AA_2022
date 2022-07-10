import { RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO } from "../actions/todo_actions";

const todosReducer = (state = initialState, action) => {
  switch (action.type) {
    case RECEIVE_TODOS:
      const newState = {};
      action.todos.forEach(todo => {
        newState[todo.id] = todo;
      })
      return newState;
    case RECEIVE_TODO:
      const newTodo = { [action.todo.id]: action.todo };
      return Object.assign({}, state, newTodo);
    case REMOVE_TODO:
      const removeState = {};
      for (let key in state) {
        if (key !== String(action.todo.id)) {
          removeState[key] = state[key];
        }
      }
      return removeState;
    default:
      return state;
  }
};

export default todosReducer;

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
