import React, { useEffect, useState } from 'react';

function Weather(props) {
  const [location, setLocation] = useState("");
  const [weather, setWeather] = useState(0);
  const [isLoaded, setLoaded] = useState(false);

  const weatherCall = async function(data) {
    let lat = data.coords.latitude;
    let lon = data.coords.longitude;
    let call = `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&units=imperial&appid=${process.env.WEATHER}`
    // Using XMLHttpRequest
    // let weatherRequest = new XMLHttpRequest();
    // weatherRequest.open('GET', call, true);
    // weatherRequest.onload = () => {
    //   if (weatherRequest.status >= 200 && weatherRequest.status < 400) {
    //     console.log(weatherRequest.response);
    //   } else {
    //     console.log('Error');
    //   }
    // }
    // weatherRequest.send();
    // Using fetch
    // fetch(call)
    //   .then(response => response.json())
    //   .then(data => console.log(data));
    // Using fetch with async await
    const response = await fetch(call);
    const json = await response.json();
    setLoaded(true);
    setLocation(json.name);
    setWeather(json.main.temp);
  }

  const fetchLocation = function() {
    navigator.geolocation.getCurrentPosition(weatherCall, () => {
      console.log("Failure to fetch location!");
    })
  }

  useEffect(() => {
    fetchLocation();
    const intervalId = setInterval(() => {
      fetchLocation();
    }, 60 * 60 * 1000);
    return () => clearInterval(intervalId);
  }, [])

  // Could also if (isLoaded) return x else return y
  return (
    <div className="weather">
      <h1>Weather</h1>
      {
        (() => {
          if (isLoaded) {
            return (<div className="weather-body">
              <h1>{location}</h1>
              <h1>{weather}</h1>
            </div>)
          } else {
            return (<div className="weather-body loading">
              <h1>loading weather...</h1>
            </div>)
          }
        })()
      }
    </div>
  )
}

export default Weather;
