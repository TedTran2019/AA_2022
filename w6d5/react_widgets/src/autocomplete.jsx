import React, { useEffect, useState } from 'react';

function AutoComplete(props) {
  const [searchedNames, setSearchedNames] = useState(props.names);
  const [searchString, setSearchString] = useState("");

  const changeSearchString = (event) => {
    let search = event.target.value.toLowerCase();
    let searched = props.names.filter(name => {
      return name.toLowerCase().startsWith(search);
    })
    setSearchString(event.target.value);
    setSearchedNames(searched);
  }

  const searchStringExists = () => {
    return <input className="search-bar" placeholder="Search..."
    onChange={changeSearchString} type="text" value={searchString} />
  }

  return (
    <div className="autocomplete">
      <h1>Autocomplete</h1>
      <div className="autocomplete-body">
        {
          searchStringExists()
        }
        <ul className="searched-names">
          {searchedNames.map((name, index) => {
            return <li key={name}>{name}</li>
          })}
        </ul>
      </div>
    </div> 
  )
}

export default AutoComplete;
