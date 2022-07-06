import React from 'react';
import { createRoot } from 'react-dom/client'
import Clock from './clock';
import Tabs from './tabs';
import Weather from './weather';
import AutoComplete from './autocomplete';

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("root");
  const root = createRoot(container);
  root.render(
    <div>
      <Clock 
        days={["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]}
        months={["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]}
      />
      <Weather 
        
      />
      <div className="tabs-autocomplete">
        <Tabs 
          tabs={
            [{title: "Tab1", content: "Content1"},
            {title: "Tab2", content: "Content2"},
            {title: "Tab3", content: "Content3"}]
              }
        />
        <AutoComplete   
          // Ensure names are unique
          names={['Ted', 'Helen', 'Brian', 'Bill', 'Poitier', 'Steven', 'Luke']}
        />
      </div>
    </div>);
});
