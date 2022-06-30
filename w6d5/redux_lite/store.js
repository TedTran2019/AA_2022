class Store {
  constructor(rootReducer, appliedMiddleware) {
    this.rootReducer = rootReducer;
    this.appliedMiddleware = appliedMiddleware;
    this.state = rootReducer({});
    this.subscriptions = [];

    this.getState = this.getState.bind(this);
    this.dispatch = this.dispatch.bind(this);
    this.subscribe = this.subscribe.bind(this);
  }

  getState() {
    return this.deepDup(this.state);
  }

  deepDup(obj) {
    const copy = {};

    for (const key in obj) {
      if (typeof obj[key] === 'object' && obj[key] !== null) {
        copy[key] = this.deepDup(obj[key]);
      } else {
        copy[key] = obj[key];
      }
    }
    return copy;
  }

  dispatch(actions) {
    //this.state = this.appliedMiddleware(this, this.rootReducer)(actions);
    this.appliedMiddleware(this, actions => {
      this.state = this.rootReducer(this.state, actions, this.subscriptions);
      return this.state;
    })(actions);
  }

  subscribe(callback) {
    this.subscriptions.push(callback);
  }
}

const createStore = (...args) => new Store(...args);

const combineReducers = config => {
  return (prevState, action, subscriptions) => {
    const nextState = {};
    let stateChanged = false;
    Object.keys(config).forEach(k => {
      if (!action) {
        const args = [, { type: "__initialize" }];
        nextState[k] = config[k](...args);
        stateChanged = true;
      } else {
        const next = config[k](prevState[k], action);
        if (next !== prevState[k]) {
          stateChanged = true;
        }
        nextState[k] = next;
      }
    });
    if (stateChanged) {
      if (subscriptions) {
        subscriptions.forEach(callback => callback(nextState));
      }
      return nextState;
    }
    return prevState;
  }
}

const applyMiddleware = (...middlewares) => {
  return (store, rootReducer) => {
    return (action) => {
      const middlewareDup = [...middlewares];
      const invokeNextMiddleware = (action) => {
        const nextMiddleware = middlewareDup.shift();
        if (nextMiddleware) {
          return nextMiddleware(store)(invokeNextMiddleware)(action);
        } else {
          return rootReducer(action);
        }
      }
      return invokeNextMiddleware(action);
    }
  }
}

// const myNoiseReducer = (prevState = "peace and quiet", action) => {
//   switch (action.type) {
//     case "noisy action":
//       return action.noise;
//     default:
//       return prevState;
//   }
// };

// const myNoisyAction = {
//   type: "noisy action",
//   noise: "Car alarm"
// };

// const myInconsequentialAction = {
//   type: "a type no one cares about",
//   data: {
//     thisThing: "will not get used anyway"
//   }
// };

// const myInitialState = {
//   noise: "peace and quiet"
// };

// const myRootReducer = combineReducers({
//   noise: myNoiseReducer,
// });

// let newState = myRootReducer(myInitialState, myInconsequentialAction);
// // => { noise: "peace and quiet" }
// console.log(newState);
// newState = myRootReducer(newState, myNoisyAction)
// // => { noise: "Car alarm" }
// console.log(newState);
// myRootReducer(newState, myInconsequentialAction)
// // => { noise: "Car alarm" }
// console.log(newState);

// // define a reducer for user:
// const userReducer = (oldUser = null, action) => {
//   if (action.type === "new user") {
//     return action.user;
//   }
//   return oldUser;
// };

// // create a rootReducer:
// const rootReducer = combineReducers({
//   user: userReducer
// });

// // create a store using the rootReducer:
// const store = new Store(rootReducer);

// // get the state:
// store.getState(); // => {}

// // invoke the dispatch function to update the user key:
// const action = {
//   type: "new user",
//   user: "Jeffrey Fiddler"
// };

// store.dispatch(action);
// store.getState(); // => { user: "Jeffrey Fiddler" }
// console.log(store.getState());

// const actionCreator1 = value => ({
//   type: "add",
//   value
// });

// const actionCreator2 = value => ({
//   type: "subtract",
//   value
// });

// const actionCreator3 = value => ({
//   type: "no change",
//   value
// });

// const numberReducer = (num = 0, action) => {
//   switch (action.type) {
//     case "add":
//       return num + action.value;
//     case "subtract":
//       return num - action.value;
//     default:
//       return num;
//   }
// }

// const rootReducer = combineReducers({
//   number: numberReducer
// });

// const store = new Store(rootReducer);

// store.getState() // => { number: 0 }

// const announceStateChange = nextState => {
//   console.log(`That action changed the state! Number is now ${nextState.number}`);
// }

// store.subscribe(announceStateChange);

// store.dispatch(actionCreator1(5)); // => "That action changed the state! Number is now 5"
// store.dispatch(actionCreator1(5)); // => "That action changed the state! Number is now 10"
// store.dispatch(actionCreator2(7)); // => "That action changed the state! Number is now 3"
// store.dispatch(actionCreator3(7)); // => Nothing should happen! The reducer doesn't do anything for type "no change"
// store.dispatch(actionCreator1(0)) // => Nothing should happen here either. Even though the reducer checks for the "add" action type, adding 0 to the number won't result in a state change.
// console.log(store.getState()); // => { number: 3 }

const logger = store => next => action => {
  const prevState = store.getState();
  const nextState = next(action);

  console.log("%c prevState: ", "color: purple; font-size: 20px;");
  console.log(prevState);
  console.log("%c action: ", "color: blue; font-size: 20px;");
  console.log(action);
  console.log("%c nextState: ", "color: green; font-size: 20px;")
  console.log(nextState);
}
