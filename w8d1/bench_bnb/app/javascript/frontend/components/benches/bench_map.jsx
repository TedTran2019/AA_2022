import React, { useEffect, useRef, useState } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import MarkerManager from '../../utils/marker_manager';
import { setBounds } from '../filters/filters_slice';
import { useNavigate } from 'react-router-dom';

// Using @googlemaps/react-wrapper here would make things really simple...
export default function BenchMap({benches}) {
  const ref = useRef(null);
  const [map, setMap] = useState();
  const [markerManager, setMarkerManager] = useState();
  const dispatch = useDispatch();
  const navigate = useNavigate();

  useEffect (() => {
    const mapOptions = {
      center: { lat: 37.7758, lng: -122.435 }, // SF
      zoom: 13
    }
    if (ref.current && !map) {
      let googMap = new google.maps.Map(ref.current, mapOptions);
      setMap(googMap);
      setMarkerManager(new MarkerManager(googMap));
      googMap.addListener('idle', () => {
        const { north, south, east, west } = googMap.getBounds().toJSON();
        const bounds = {
          "northEast": { lat: north, lng: east },
          "southWest": { lat: south, lng: west }
        };
        dispatch(setBounds(bounds));
      })
      googMap.addListener('click', (e) => {
        const lat = e.latLng.lat();
        const lng = e.latLng.lng();
        navigate('/benches/new', { state: { lat, lng } });
      })
    }
  }, [ref, map]);

  useEffect(() => {
    if (map) {
      markerManager.updateMarkers(benches);
    }
  }, [benches])

  return (
    <div id="map" ref={ref}>
    </div>
  );
}
