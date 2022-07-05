import React from 'react';
import { createRoot } from 'react-dom/client'
import Clock from './clock';
import Tabs from './tabs';

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("root");
  const root = createRoot(container);
  root.render(
    <div>
      <Clock 
        days={["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]}
        months={["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]}
      />,
      <Tabs 
        tabs={
          [{title: "Tab1", content: "Content1"},
          {title: "Tab2", content: "Content2"},
          {title: "Tab3", content: "Content3"}]
            }
      />
    </div>);
});
