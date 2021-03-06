class Clock {
  constructor() {
    let date = new Date();
    this.hours = date.getHours();
    this.minutes = date.getMinutes();
    this.seconds = date.getSeconds();
    this.printTime();
    setInterval(this._tick.bind(this), 1000);
  }

  _tick() {
    this.seconds++;
    if (this.seconds === 60) {
      this.seconds = 0;
      this.minutes++;
    }
    if (this.minutes === 60) {
      this.minutes = 0;
      this.hours++;
    }
    if (this.hours === 24) { 
      this.hours = 0;
    }
    this.printTime();
  }

  printTime() {
    console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
  }
}

// const clock = new Clock();

const readline = require('readline');
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const addNumbers = function(sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question('Enter a number!', num => {
      sum += parseInt(num);
      console.log(sum);
      addNumbers(sum, numsLeft - 1, completionCallback);
    })
  } else if (numsLeft === 0) {
    completionCallback(sum);
    reader.close();
  } else {
    throw 'Invalid numsLeft';
  }
}

// addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));

const askIfGreaterThan = function(el1, el2, callback) {
  reader.question(`Is ${el1} greater than ${el2}?`, answer => {
    if (answer === 'yes') {
      callback(true);
    } else if (answer === 'no') {
      callback(false);
    }
  });
}

const innerBubbleSortLoop = function(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i], arr[i + 1], (isGreaterThan) => {
      if (isGreaterThan) {
        [arr[i], arr[i + 1]] = [arr[i + 1], arr[i]];
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
    })
  } else {
    outerBubbleSortLoop(madeAnySwaps);
  }
}
const absurdBubbleSort = function(arr, sortCompletionCallback) {
  const outerBubbleSortLoop = function(madeAnySwaps) {
    if (madeAnySwaps) { 
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }
  outerBubbleSortLoop(true);
}

/*
askIfGreaterThan(2, 1, (answer) => {
  console.log(answer);
})
*/

/*
absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
*/

Function.prototype.myBind = function(context) {
  return () => { this.apply(context); }
}

class Lamp {
  constructor() {
    this.name = "a lamp";
  }
}

const turnOn = function () {
  console.log("Turning on " + this.name);
};

const lamp = new Lamp();

// turnOn(); // should not work the way we want it to

const boundTurnOn = turnOn.bind(lamp);
const myBoundTurnOn = turnOn.myBind(lamp);

// boundTurnOn(); // should say "Turning on a lamp"
// myBoundTurnOn(); // should say "Turning on a lamp"

Function.prototype.myThrottle = function(interval) {
  let tooSoon = false;

  return () => {
    if (!tooSoon) {
      tooSoon = true;
      setTimeout(() => {
        tooSoon = false;
      }, interval);
      this();
    }
  }
}  

class Neuron {
  fire() {
    console.log("Firing!");
  }
}

const neuron = new Neuron();
// When we create a new Neuron,
// we can call #fire as frequently as we want

/*
// The following code will try to #fire the neuron every 10ms. Try it in the console:
const interval = setInterval(() => {
  neuron.fire();
}, 10);
*/
// You can use clearInterval to stop the firing:
// clearInterval(interval);
// Using Function#myThrottle, we should be able to throttle
// the #fire function of our neuron so that it can only fire
// once every 500ms:

neuron.fire = neuron.fire.myThrottle(500);

/*
const interval = setInterval(() => {
  neuron.fire();
}, 10);
*/
// This time, if our Function#myThrottle worked correctly,
// the Neuron#fire function should only be able to execute
// every 500ms, even though we're still trying to invoke it
// every 10ms!

class SearchBar {
  constructor() {
    this.query = "";

    this.type = this.type.bind(this);
    this.search = this.search.bind(this);
  }

  type(letter) {
    this.query += letter;
    this.search();
  }

  search() {
    console.log(`searching for ${this.query}`);
  }
}

const searchBar = new SearchBar();

const queryForHelloWorld = () => {
  searchBar.type("h");
  searchBar.type("e");
  searchBar.type("l");
  searchBar.type("l");
  searchBar.type("o");
  searchBar.type(" ");
  searchBar.type("w");
  searchBar.type("o");
  searchBar.type("r");
  searchBar.type("l");
  searchBar.type("d");
};

Function.prototype.myDebounce = function(interval) {
  let invokedEarly;
  return (...args) => {
    const functionCall = () => {
      invokedEarly = null; // Invalid ids fail silently, so not necessary
      this(...args);
    }

    clearTimeout(invokedEarly);
    invokedEarly = setTimeout(functionCall, interval);
  }
}

searchBar.search = searchBar.search.myDebounce(500);
queryForHelloWorld();