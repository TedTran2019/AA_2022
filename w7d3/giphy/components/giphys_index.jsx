import GiphysIndexItem from './giphys_index_item';
import { useDispatch, useSelector } from 'react-redux';
import React from 'react';

export default function GiphysIndex() {
  let giphys = useSelector(state => state.giphy);
  return (
    <div>
      <h1>Giphy's Index!</h1>
      {giphys.map(giphy => {
        return <GiphysIndexItem key={giphy.id} giphy={giphy} />
      })}
    </div>
  );
}
