import React from 'react';
import { useState, useEffect } from 'react';
import { useDispatch } from 'react-redux';
import { fetchSearchGiphys } from './giphy_slice';
import GiphysIndex from './giphys_index';

export default function giphySearch () {
  const [searchTerm, setSearchTerm] = useState('');
  const dispatch = useDispatch();

  const handleSearch = (e) => {
    e.preventDefault();
    dispatch(fetchSearchGiphys(searchTerm));
  }

  const handleTextSearchChange = (e) => {
    setSearchTerm(e.target.value);
  }

  return (
    <div>
      <form onSubmit={handleSearch}>
        <input onChange={handleTextSearchChange} type="text" value={searchTerm} placeholder="Search" />
        <button type="submit">Search Giphy</button>
      </form>
      <GiphysIndex />
    </div>
  );
}
