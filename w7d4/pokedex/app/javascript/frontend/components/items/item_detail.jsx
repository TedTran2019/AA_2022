import React from 'react';
import {
  useParams,
  useNavigate,
  useLocation,
} from "react-router-dom";
import { useSelector, useDispatch } from 'react-redux';

export default function ItemDetail() {
  const itemId = useParams().itemId;
  const item = useSelector(state => state.entities.items[itemId]);
  console.log(item);
  return (
    <div>
      <h2 align="center">{item.name}</h2>
      <h3>Price: {item.price}</h3>
      <h3>Happiness: {item.happiness}</h3>
    </div>
  )
}
