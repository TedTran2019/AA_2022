import React, { useEffect, useState } from 'react';

function Tabs(props) {
  const [activeTab, setActiveTab] = useState(0);

  return (
    <div className="tabs">
      <h1>Tabs</h1>
      <div className="tab-content">
        <ul className="tab-headers">
          {props.tabs.map((tab, index) => {
            if (index === activeTab) {
              return <li id="tab-selected" key={index}><h1><b>{tab.title}</b></h1></li>
            } else {
              return <li key={index} onClick={() => {setActiveTab(index)}}>
                  <h1>{tab.title}</h1>
                </li>
            }
          })}
        </ul>
        <article>
          {props.tabs[activeTab].content}
        </article>
      </div>
    </div>
  )
}

export default Tabs;