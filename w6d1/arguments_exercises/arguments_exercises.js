const sum = function(...args) {
  let sum = 0;
  args.forEach((arg) => {
    sum += arg;
  })
  return sum;
}
console.log(sum(1, 2, 3, 4));

const sum2 = function() {
  let sum = 0;
  arguments.forEach(arg => {
    sum += arg;
  })
  return sum;
}
console.log(sum(1, 2, 3, 4));

/*
Function.prototype.myBind = function (context) {
  let args = Array.from(arguments);
  let less_args = args.slice(1, args.length);
  let that = this;
  return function() {
    let new_args = Array.from(arguments);
    let all_args = less_args.concat(new_args);
    return that.apply(context, all_args);
  }
}
*/
Function.prototype.myBind = function (context, ...args) {
  return (...moreArgs) => {
    let all_args = args.concat(moreArgs);
    return this.apply(context, all_args);
  }
}

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

class Dog {
  constructor(name) {
    this.name = name;
  }
}

const markov = new Cat("Markov");
const pavlov = new Dog("Pavlov");

markov.says("meow", "Ned");
// Markov says meow to Ned!
// true

// bind time args are "meow" and "Kush", no call time args
markov.says.myBind(pavlov, "meow", "Kush")();
// Pavlov says meow to Kush!
// true

// no bind time args (other than context), call time args are "meow" and "a tree"
markov.says.myBind(pavlov)("meow", "a tree");
// Pavlov says meow to a tree!
// true

// bind time arg is "meow", call time arg is "Markov"
markov.says.myBind(pavlov, "meow")("Markov");
// Pavlov says meow to Markov!
// true

// no bind time args (other than context), call time args are "meow" and "me"
const notMarkovSays = markov.says.myBind(pavlov);
notMarkovSays("meow", "me");
// Pavlov says meow to me!
// true

const curriedSum = function(numArgs) {
  let numbers = [];
  let sum = 0;
  const _curriedSum = function(nbr) {
    numbers.push(nbr);
    if (numbers.length === numArgs) {
      numbers.forEach(num => {
        sum += num;
      })
      return sum;
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum;
}

const summation = curriedSum(4);
console.log(summation(5)(30)(20)(1)); // => 56

Function.prototype.curry = function(numArgs) {
  let args = [];
  let that = this;
  const _curry = function() {
    let func_args = Array.from(arguments);
    args.push(...func_args);
    if (args.length >= numArgs) {
      return that(...(args.slice(0, numArgs)));
    } else {
      return _curry;
    }
  }
  return _curry;
}

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

// you'll write `Function#curry`!
let f1 = sumThree.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
f1 = f1(4); // [Function]
f1 = f1(20); // [Function]
f1 = f1(6); // = 30

// or more briefly:
console.log(sumThree.curry(3)(4)(20)(6)); // == 30