import React, { useEffect, useState } from 'react';
import TileGame from './tile.jsx';

function Board(props) {
  return (
    <div className="grid">
      {
        props.board.grid.map((row, rowIndex) => {
          return <div key={rowIndex} className="row">
            {row.map((tile, tileIndex) => {
              return <TileGame
                tileKey={`${rowIndex}-${tileIndex}`}
                rowIndex={rowIndex}
                tileIndex={tileIndex}
                tile={tile}
                updateGame={props.updateGame}
              />
            })}
          </div>
        })
      }
    </div>
  )
}

export default Board;
