function mysteryScoping1() {
  var x = 'out of block';
  if (true) {
    var x = 'in block';
    console.log(x);
  }
  console.log(x);
}

function mysteryScoping2() {
  const x = 'out of block';
  if (true) {
    const x = 'in block';
    console.log(x);
  }
  console.log(x);
}

/*
function mysteryScoping3() {
  const x = 'out of block';
  if (true) {
    var x = 'in block';
    console.log(x);
  }
  console.log(x);
}
*/

function mysteryScoping4() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  }
  console.log(x);
}

/*
function mysteryScoping5() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  }
  let x = 'out of block again';
  console.log(x);
}
*/

mysteryScoping1()
mysteryScoping2()
// mysteryScoping3()
mysteryScoping4()
// mysteryScoping5()

const madlib = function(verb, adjective, noun) {
  return (`We shall ${verb.toUpperCase()} the ${adjective.toUpperCase()} ${noun.toUpperCase()}.`)
};
console.log(madlib('make', 'best', 'guac'));

const isSubstring = function(searchString, subString) {
  return searchString.includes(subString);
};

console.log(isSubstring("time to program", "time"))
console.log(isSubstring("Jump for joy", "joys"))

const fizzBuzz = function(array) {
  let numbers = [];
  array.forEach(function (el) {
    if (el % 3 == 0 ^ el % 5 == 0) {
      numbers.push(el)
    };
  });
  return numbers
};

let numbersArray = []
for (let i = 0; i < 31; i++) {
  numbersArray.push(i);
};
console.log(fizzBuzz(numbersArray))

const isPrime = function(number) {
  if (number < 2) {
    return false;
  }

  for (i = 2; i < number; i++) {
    if (number % i == 0) {
      return false;
    };
  }
  return true;
};

console.log(isPrime(2))
console.log(isPrime(10))
console.log(isPrime(15485863))
console.log(isPrime(3548563))

const sumOfNPrimes = function(number) {
  let n_primes = [];
  let i = 2;
  while (n_primes.length < number) {
    if (isPrime(i)) {
      n_primes.push(i)
    };
    i++;
  }
  let sum = 0;
  n_primes.forEach((el) => {
    sum += el;
  });
  return sum;
};

console.log(sumOfNPrimes(0))
console.log(sumOfNPrimes(1))
console.log(sumOfNPrimes(4))