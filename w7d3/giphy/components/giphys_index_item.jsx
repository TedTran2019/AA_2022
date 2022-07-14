import React from 'react';

export default function GiphysIndexItem ( {giphy} ) {
  return (
    <div>
      <img src={giphy.images.fixed_height.url} />
    </div>
  );
}
