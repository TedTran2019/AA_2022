import React, { useEffect, useState, } from 'react';
import { CSSTransition, TransitionGroup, } from 'react-transition-group';

function AutoComplete(props) {
  const [searchedNames, setSearchedNames] = useState(props.names);
  const [searchString, setSearchString] = useState("");

  const changeSearchString = (event) => {
    let search = event.target.value.toLowerCase();
    let searched = props.names.filter(name => {
      return name.toLowerCase().startsWith(search);
    })
    if (searched.length === 0) {
      searched.push('No matches');
    }
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
          {searchedNames.map((name, index) => (
            <li key={name}>{name}</li>
          ))}
        </ul>
      </div>
    </div> 
  )
}

export default AutoComplete;

{/* <TransitionGroup className="search-transiton-group">
  {searchedNames.map((name, index) => (
    <CSSTransition
      key={name}
      timeout={{ enter: 500, exit: 300 }}
      classNames="search"
    >
      <li key={name}>{name}</li>
    </CSSTransition>
  ))}
</TransitionGroup> */}