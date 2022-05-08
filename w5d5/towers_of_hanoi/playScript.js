const TowersOfHanoi = require('./towers_of_hanoi');

const readline = require('readline');
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

game = new TowersOfHanoi(reader);
game.run(() => {
  reader.close();
});