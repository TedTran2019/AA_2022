import React, { useEffect, useState } from 'react';

function Clock(props) { 
  const [date, setDate] = useState(new Date());
  const [days, months] = [props.days, props.months];

  useEffect(() => {
    const tick = setInterval(() => {
        setDate(new Date());
    }, 1000);
    return () => clearInterval(tick); //Cleanup function
  }, []);
  // Callback, filters (changes when elements in array change)
  // Callback can return cleanup function, equiv of. unMount

  let day = date.getDate().length > 1 ? date.getDate() : "0" + date.getDate();
  let seconds = ("0" + date.getSeconds()).slice(-2);
  let minutes = ("0" + date.getMinutes()).slice(-2);
  let hours = ("0" + date.getHours()).slice(-2);

  return(
    <div className="clock">
      <h1>Clock</h1>
      <div className="dateTime">
        <div className="time">
          <h1>Time:</h1>
          <h1>{hours}:{minutes}:{seconds} PDT</h1>
        </div>
        <div className="date">
          <h1>Date:</h1>
          <h1>{days[date.getDay()]} {months[date.getMonth()]} {day} {date.getFullYear()}</h1>
        </div>
      </div>
    </div>
  )
}

export default Clock;