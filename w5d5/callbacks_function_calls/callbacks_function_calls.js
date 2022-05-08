/*
window.setTimeout(() => {
  alert('HAMMERTIME');
}, 5000);

const hammerTime = (time) => {
  window.setTimeout(() => {
    alert(`${time} is hammertime!`);
  }, time);
}
*/

const readline = require('readline');
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Naive, this won't work with async.
/*
const teaAndBiscuits = function() {
  let first, second;

  reader.question('Would you like some tea?\n', (res) => {
    first = res;
    console.log(`You replied ${res}.`);
  })

  reader.question('Would you like some biscuits?\n', (res) => {
    second = res;
    console.log(`You replied ${res}.`);
  })
  let firstRes = (first === 'yes') ? 'do' : 'don\'t';
  let secondRes = (second === 'yes') ? 'do' : 'don\'t';
  console.log(`So you ${firstRes} want tea and you ${secondRes} want biscuits.`);
  reader.close();
};
*/

const teaAndBiscuits = function() {
  let first, second;

  reader.question('Would you like some tea?\n', (res) => {
    first = res;
    console.log(`You replied ${first}.`);
    reader.question('Would you like some biscuits?\n', (res) => {
      second = res;
      console.log(`You replied ${second}`);
      let firstRes = (first === 'yes') ? 'do' : 'don\'t';
      let secondRes = (second === 'yes') ? 'do' : 'don\'t';
      console.log(`So you ${firstRes} want tea and you ${secondRes} want biscuits.`);
      reader.close();
    })
  })
}
// teaAndBiscuits();

function Cat() {
  this.name = 'Markov';
  this.age = 3;
}

function Dog() {
  this.name = 'Noodles';
  this.age = 4;
}

Dog.prototype.chase = function (cat) {
  console.log(`My name is ${this.name} and I'm chasing ${cat.name}! Woof!`)
};

const Markov = new Cat();
const Noodles = new Dog();

Noodles.chase(Markov);
Noodles.chase.call(Markov, Noodles);
Noodles.chase.apply(Markov, [Noodles]);