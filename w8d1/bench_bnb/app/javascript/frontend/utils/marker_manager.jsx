// Deleting marker also removes event listener if its garbage collected
export default class MarkerManager {
  constructor(map, navigate) {
    this.map = map;
    this.markers = {};
    this.navigate = navigate;
  }

  updateMarkers(benches) {
    benches.forEach(bench => {
      if (!this.markers[bench.id]) {
        this.createMarkerFromBench(bench);
      }
    })
    const benchesHash = {};
    const newMarkers = {};
    benches.forEach(bench => { benchesHash[bench.id] = bench });
    Object.keys(this.markers).forEach(benchId => {
      if (!benchesHash[benchId]) {
        this.removeMarker(this.markers[benchId]);
      } else {
        newMarkers[benchId] = this.markers[benchId];
      }
    })
    this.markers = newMarkers;
  }

  createMarkerFromBench(bench) {
    const marker = new google.maps.Marker({
      position: { lat: bench.lat, lng: bench.lng },
      map: this.map,
      title: bench.description
    })
    this.markers[bench.id] = marker;
    marker.addListener('click', () => {
      this.navigate(`/benches/${bench.id}`);
    })
  }

  removeMarker(marker) {
    marker.setMap(null);
  }
}
