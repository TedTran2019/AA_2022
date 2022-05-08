const TowersOfHanoi = require('./towers_of_hanoi');

const readline = require('readline');
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const completionCallback = (reader) => {
  reader.question('Would you like to play again? (y/n): ', answer => {
    if (answer === 'y') {
      let game = new TowersOfHanoi(reader);
      game.run(() => { completionCallback(reader) });
    } else {
      reader.close();
    }
  })
}

let game = new TowersOfHanoi(reader);
game.run(() => { completionCallback(reader)});