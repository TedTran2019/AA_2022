import React, { useEffect, useState } from 'react';
import { Board, Tile } from '../minesweeper.js';
const Minesweeper = { Board, Tile };
import BoardGame from './board.jsx';

function Game(props) {
  const board = new Minesweeper["Board"](9, 10);
  const [boardState, setBoardState] = useState(board);
  const [, updateState] = React.useState();
  const forceUpdate = React.useCallback(() => updateState({}), []);

  const updateGame = (tile, flagged) => {
    if (flagged) {
      tile.toggleFlag();
    } else {
      tile.explore();
    }
    // // It's the same array, so React can't detect differences, so no re-render
    // setBoardState(board.grid); 
    // BUT setState used in React classes will always cause a re-render when used
    forceUpdate();
  }

  const restartGame = () => {
    let newBoard = new Minesweeper["Board"](9, 10);
    setBoardState(newBoard);
  }

  const winOrLose = () => {
    if (boardState.lost() || boardState.won()) {
      let text = boardState.lost() ? 'Loser!' : 'Winner!'
      return (<div className="modal-screen">
        <div className="modal-content">
          <p>{text}</p>
          <button onClick={restartGame}>Play again?</button>
        </div>
      </div>)
    } else {
      return "";
    }
  }

  return (
    <div className="game">
      <h1>Minesweeper</h1>
      <p>Click to explore a tile.</p>
      <p>Alt + click to flag a tile.</p>
      {winOrLose()}
      <BoardGame
        board={boardState}
        updateGame={updateGame}
      />
    </div>
  )
}

export default Game;
