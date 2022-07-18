import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import Item from './item';
import { Link, Outlet } from "react-router-dom";

export default function Items () {
  const items = useSelector(state => Object.values(state.entities.items));
  
  return (
    <div>
      <h3 align="center">Items</h3>
      <div className="pokemon-items">{items.map(item => (<Item item={item} key={item.id} />))}</div>
      <Outlet/>
    </div>
  )
}
