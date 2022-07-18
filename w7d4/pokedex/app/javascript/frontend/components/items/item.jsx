import React from 'react';
import { Link, Outlet } from "react-router-dom";

export default function Item({item}) {
  const link = `/pokemon/${item.pokemonId}/items/${item.id}`;

  return(
    <div>
      <Link to={link}>
        <img height="100" width="100" src={item.imageUrl} />
      </Link>
    </div>
  )
}
