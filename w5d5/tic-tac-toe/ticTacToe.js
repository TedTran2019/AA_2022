const Board = require('./board');
const HumanPlayer = require('./humanPlayer');

class TicTacToe {
  constructor(player1, player2) {
    this.board = new Board();
    this.player1 = player1;
    this.player2 = player2;
    this.currentPlayer = player1;
  }

  run(reader, completionCallback) {
    this.currentPlayer.promptMove(reader, this.board, (pos) => {
      if (!this.board.place_mark(pos, this.currentPlayer.mark)) {
        console.log('Invalid position!');
      } else {
        this.swapCurrentPlayer();
      }
      if (this.board.won()) {
        this.board.print();
        console.log('You win!');
        completionCallback();
      } else if (this.board.draw()) {
        this.board.print();
        console.log('Game is a draw!');
        completionCallback();
      } else {
        this.run(reader, completionCallback);
      }
    })
  }

  swapCurrentPlayer() {
    this.currentPlayer = (this.currentPlayer === this.player1 ? this.player2 : this.player1 )
  }
}

module.exports = TicTacToe;