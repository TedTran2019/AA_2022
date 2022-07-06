import React, { useEffect, useState } from 'react';

function Tile(props) {
  let tileClass = "";
  let text = "";

  const handleClick = (event) => {
    let flagged = event.altKey ? true : false;
    props.updateGame(props.tile, flagged);
  }
  
  if (props.tile.explored) {
    if (props.tile.bombed) {
      text = "\u2622"
      tileClass = "flagged";
    } else {
      let bombCount = props.tile.adjacentBombCount();
      tileClass = "safe";
      if (bombCount !== 0) {
        text = bombCount; 
      }
    }
  } else if (props.tile.flagged) {
    tileClass = "flagged";
    text = "\u2691";
  } 

  return (
    <div key={props.tileKey} 
    onClick={handleClick}
    className={`tile ${tileClass}`}>
      {text}
    </div>
  )
}

export default Tile;
