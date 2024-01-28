<!-- how to get the map to be "found" by the js -->
<!-- map and coords, learn about ---google nearby searches--- -->

<style scoped>
.post-image {
  max-width: 200px;
  max-height: 200px;
}

.map {
  position: absolute;
  top: 0;
  height: 100%;
  width: 100%;
  flex: 1;
}

.html-content {
  flex: 1;
  display: flex;
  top: 400px;
  height: 100%;
  position: absolute;
  overflow: auto;
}

.mapboxgl-popup {
max-width: 400px;
font: 12px/20px 'Helvetica Neue', Arial, Helvetica, sans-serif;
}
</style>

<template>
  <div id="mapContainer">
    <div id="mapElement" class="map"></div>
  </div>
  <div id="html-content" class="d-flex overflow-scroll bg-primary justify-content-start w-100">
    <div style="max-height: 680px;" class="d-flex flex-column overflow-auto">
      <div class="d-flex flex-column mx-3">
        <a href="/stats" id="gohome" style="text-decoration: none;">
        <div class="card my-3">
          <button type="button" class="btn btn-primary">
          Home
          </button>
        </div>
        </a>
      </div>
      <div class="d-flex flex-column mx-3" v-for="(post, index) in posts" v-cloak>
        <div class="card my-4" style="width: 18rem;">
          <div class="card-body">
            <h5 class="card-title">{{post.title}}</h5>
            <p class="card-text">{{ post.text }}</p>
          </div>
          <ul class="list-group list-group-flush">
            <li class="list-group-item">{{post.coords}} Latitude x Longitude</li>
            <li class="list-group-item">{{convertToLocalTime(post.created_at)}}</li>
          </ul>
          <div class="card-body">
            <a href="/create" class="card-link">Make a post now!</a>
          </div>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
import axios from 'axios';
import mapboxgl from 'mapbox-gl/dist/mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import { DateTime } from 'luxon';

export default {
  data() {
    return {
      posts: [],
    }
  },
  async mounted() {
    //   var map = L.map('map').setView([39.8283, 98.5795], 1.5);
    //   var tiles = L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
    // 	maxZoom: 18,
    // 	attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, ' +
    // 		'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    // 	id: 'mapbox/streets-v11',
    // 	tileSize: 512,
    // 	zoomOffset: -1
    // }).addTo(map);
    let response = await axios.get('api/posts')
    this.posts = response.data
    this.$nextTick(() => {
      let circleMarker = this.$refs.circleMarker
      console.log(this.posts)
      mapboxgl.accessToken = 'pk.eyJ1Ijoia29obGltYXBzIiwiYSI6ImNsbDdmZjd6ODB2NHczZHNzcmVldmc2cGEifQ.Qb3He2e_V5orPqPYF9ygMg';
      console.log(document.getElementById('mapElement'))
      const map = new mapboxgl.Map({
        container: 'mapElement', // container ID
        style: 'mapbox://styles/mapbox/streets-v12', // style URL
        center: [-66.3, -16.02], // starting position [lng, lat]
        zoom: 9 // starting zoom
      })
      console.log(this.posts)
      var geojson = {
        type: "FeatureCollection",

        features: [] };
        for (var index in this.posts) {
          console.log(index)
          var a = {
            type: "Feature",
            properties: {
              message: this.posts[index].title, // has to be populated w/ database
              description: this.posts[index].text,
              iconSize: [60, 60],
              icon: "water",
            },
            geometry: {
              type: "Point",
              coordinates: Array.from(this.posts[index].coords.values()), // has to be populated w/ database
            },
          };
          geojson.features.push(a);
        }
        map.on('load', () => {
        map.loadImage('map_marker.png', (error, image) => {
if (error) throw error;

map.addImage('cat', image);
        map.addSource('places', {"type":"geojson", "data":geojson});
        map.addLayer({
        'id': 'places',
        'type': 'symbol',
        'source': 'places',
        'layout': {
          'icon-image': "cat",
          'icon-size': 0.1,
          'icon-allow-overlap': true
        }
      });
    });
      // When a click event occurs on a feature in the places layer, open a popup at the
      // location of the feature, with description HTML from its properties.
      map.on('click', 'places', (e) => {
        // Copy coordinates array.
        console.log('clicked');
        const coordinates = e.features[0].geometry.coordinates.slice();
        const description = e.features[0].properties.description;
        console.log('coordinates');
        console.log(description);

        // Ensure that if the map is zoomed out such that multiple
        // copies of the feature are visible, the popup appears
        // over the copy being pointed to.
        while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
          coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
        }

        new mapboxgl.Popup()
          .setLngLat(coordinates)
          .setHTML(description)
          .addTo(map);
      });

      // Change the cursor to a pointer when the mouse is over the places layer.
      map.on('mouseenter', 'places', () => {
        map.getCanvas().style.cursor = 'pointer';
      });

      // Change it back to a pointer when it leaves.
      map.on('mouseleave', 'places', () => {
        map.getCanvas().style.cursor = '';
      });
    });
        console.log(geojson);
      });
    },
    methods: {
      test() { console.log },
      convertToLocalTime(dateTimeString) {
        // Parse the input datetime string
        const dateTime = DateTime.fromISO(dateTimeString);
        // Convert to the local time zone
        const localDateTime = dateTime.setZone(DateTime.local().zoneName);
        // Get the current local date
        const currentDate = DateTime.local().startOf('day');
        // Calculate the difference in days
        const daysAgo = currentDate.diff(localDateTime, 'days').toObject().days;
        // Format the local time as HH:MM:SS
        const localTime = localDateTime.toFormat('HH:mm:ss');
        // Format the local date as "X days ago" or "today"
        console.log(daysAgo, daysAgo<1);
        const formattedDate = daysAgo < 1 ? 'today' : `${Math.round(daysAgo)} day${Math.round(daysAgo) === 1 ? '' : 's'} ago`;
        // Return the formatted date and local time
        return `${formattedDate}, ${localTime}`;

      }
    },
}

</script>
