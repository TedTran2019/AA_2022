const TicTacToe = require('./ticTacToe');

const readline = require('readline');
const HumanPlayer = require('./humanPlayer');
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const completion = function(p1, p2) {
  reader.question('Play again? (y/n): ', answer => {
    if (answer === 'y') {
      g = new TicTacToe(p1, p2);
      g.run(reader, completion);
    } else {
      reader.close();
    }
  })
}

let p1 = new HumanPlayer('O');
let p2 = new HumanPlayer('X');
let t = new TicTacToe(p1, p2);
t.run(reader, () => { completion(p1, p2)} );