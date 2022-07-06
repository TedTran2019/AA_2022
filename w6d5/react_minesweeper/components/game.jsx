import React, { useEffect, useState } from 'react';
import { Board, Tile } from '../minesweeper.js';
const Minesweeper = { Board, Tile };
import BoardGame from './board.jsx';

function Game(props) {
  const board = new Minesweeper["Board"](9, 10);
  const [boardState, setBoardState] = useState(board.grid);

  const updateGame = function(tile, flagged) {
    if (flagged) {
      tile.toggleFlag();
    } else {
      tile.explore();
    }
    console.log(board);
    setBoardState(board);
  }

  return (
    <div className="game">
      <h1>Minesweeper</h1>
      <p>Click to explore a tile.</p>
      <p>Alt + click to flag a tile.</p>
      <BoardGame
        board={boardState}
        updateGame={updateGame}
      />
    </div>
  )
}

export default Game;
