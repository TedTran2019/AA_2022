class Board {
  constructor() {
    this.board = [[], [], []]
    this.winner = null;
  }

  print() {
    console.log(' 0 1 2');
    for(let y = 0; y < 3; y++) {
      for (let x = 0; x < 3; x++) { 
        if (x === 0) {
          process.stdout.write(`${y}`);
        }
        if (this.board[y][x] === undefined) {
          process.stdout.write('  ');
        } else {
          process.stdout.write(this.board[y][x] + ' ');
        }
      }
      process.stdout.write('\n');
    }
  }

  won() {
    return this.#rowsWon(this.board) || this.#columnsWon(this.board) || this.#diagonalsWon(this.board);
  }

  draw() {
    for(let y = 0; y < 3; y++) {
      for(let x = 0; x < 3; x++) {
        if (this.board[y][x] === undefined) { return false; }
      }
    }
    return true;
  }

  winner() {
    return this.winner;
  }

  empty(pos) {
    let [x, y] = pos;
    return this.board[y][x] === undefined;
  }

  place_mark(pos , mark) {
    if (this.validMove(pos)) {
      let [x, y] = pos;
      this.board[y][x] = mark;
      return true;
    } else { 
      return false; 
    }
  }

  outOfBounds(pos) {
    let [x, y] = pos;
    return x < 0 || y < 0 || x > 2 || y > 2;
  }

  validMove(pos) {
    return !this.outOfBounds(pos) && this.empty(pos);
  }

  #rowWon(row) {
    for (let i = 0; i < 2; i++) { 
      if (row[i] === undefined) { 
        return false; 
      } else if (row[i] !== row[i + 1]) {
        return false;
      }
    }
    this.winner = row[0];
    return true;
  }

  #rowsWon(board) {
    for (let i = 0; i < 3; i++) {
      if (this.#rowWon(board[i])) {
        return true;
      }
    }
    return false;
  }

  #columnsWon(board) {
    let transposed = this.#transpose(board);
    return this.#rowsWon(transposed);
  }

  #transpose(board) {
    let transposed = [];
    for (let y = 0; y < 3; y++) {
      let sub_array = [];
      for (let x = 0; x < 3; x++) {
        sub_array.push(board[x][y]);
      }
      transposed.push(sub_array);
    }
    return transposed;
  }

  #diagonalsWon(board) {
    let diagonal1 = [];
    let diagonal2 = [];
    diagonal1.push(board[0][0]);
    diagonal1.push(board[1][1]);
    diagonal1.push(board[2][2]);
    diagonal2.push(board[0][2]);
    diagonal2.push(board[1][1]);
    diagonal2.push(board[2][0]);
    return this.#rowWon(diagonal1) || this.#rowWon(diagonal2);
  }
}

module.exports = Board;