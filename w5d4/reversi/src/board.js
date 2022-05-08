// DON'T TOUCH THIS CODE
if (typeof window === 'undefined'){
  var Piece = require("./piece");
}
// DON'T TOUCH THIS CODE

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid () {
  let new_grid = new Array(8);
  for (let i = 0; i < 8; i++) {
    new_grid[i] = new Array(8);
  }
  new_grid[3][4] = new Piece('black');
  new_grid[4][3] = new Piece('black');
  new_grid[3][3] = new Piece('white');
  new_grid[4][4] = new Piece('white');
  return new_grid;
}

/**
 * Constructs a Board with a starting grid set up.
 */
function Board () {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [ 0,  1], [ 1,  1], [ 1,  0],
  [ 1, -1], [ 0, -1], [-1, -1],
  [-1,  0], [-1,  1]
];

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) {
  let x = pos[0];
  let y = pos[1];
  return (x > -1 && x < 8 && y > -1 && y < 8)
};

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  let x = pos[0];
  let y = pos[1];
  if (!this.isValidPos(pos)) { throw new Error('Not valid pos!')};
  return this.grid[x][y];
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  let x = pos[0];
  let y = pos[1];
  if (this.grid[x][y] === undefined) { return false };

  return this.grid[x][y].color === color;
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function (pos) {
  let x = pos[0];
  let y = pos[1];
  return this.grid[x][y] !== undefined;
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns an empty array if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns empty array if it hits an empty position.
 *
 * Returns empty array if no pieces of the opposite color are found.
 */
Board.prototype._positionsToFlip = function(pos, color, dir, piecesToFlip){
  let x = pos[0];
  let y = pos[1];
  if (!this.isValidPos(pos)) { return [] };
  let toFlip = [];
  while (true) {
    x += dir[0];
    y += dir[1];
    if (!this.isValidPos([x, y])) {
      return [];
    }
    else if (this.grid[x][y] === undefined) {
      return [];
    } else if (this.grid[x][y].color !== color) {
      toFlip.push([x, y]);
    } else {
      return toFlip;
    }
  }
};

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  let x = pos[0];
  let y = pos[1];
  if (this.isOccupied(pos)) { return false };
  let toFlip = [];
  Board.DIRS.forEach((dir) => {
    toFlip = toFlip.concat(this._positionsToFlip(pos, color, dir, []));
  })
  if (toFlip.length === 0) { return false };
  return true;
};

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
  if (!this.validMove(pos, color)) { throw new Error('Invalid move!') };
  let toFlip = [];
  Board.DIRS.forEach((dir) => {
    toFlip = toFlip.concat(this._positionsToFlip(pos, color, dir, []));
  })
  let x = pos[0];
  let y = pos[1];
  this.grid[x][y] = new Piece(color);
  toFlip.forEach((pos) => {
    let x = pos[0];
    let y = pos[1];
    this.grid[x][y].flip();
  })
};

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function (color) {
  let validPos = [];
  for (let x = 0; x < 8; x++) {
    for (let y = 0; y < 8; y++) {
      let pos = [x, y];
      if (this.validMove(pos, color)) {
        validPos.push(pos);
      }
    }
  }
  return validPos;
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function (color) {
  return (this.validMoves(color).length === 0 ? false : true);
};



/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {
  return !(this.hasMove('white') || this.hasMove('black'));
};


/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
};


// DON'T TOUCH THIS CODE
if (typeof window === 'undefined'){
  module.exports = Board;
}
// DON'T TOUCH THIS CODE
