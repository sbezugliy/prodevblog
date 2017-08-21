// This example requires the Places library. Include the libraries=places
// parameter when you first load the API. For example:
// <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">

var map, directionsService, directionsDisplay;
var markerArray = [];

function initMap() {
  var directionsService = new google.maps.DirectionsService;
  var map = new google.maps.Map(document.getElementById('google-map'), {
    center: {lat: 50.4500506, lng: 30.5234797},
    zoom: 15
  });

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      map.setCenter(pos);
    },
    function() {
      notificationBlock.innerHTML = '<p>Error: The Geolocation service failed.</p>'
    });
  } else {
  // Browser doesn't support Geolocation
    notificationBlock.innerHTML = '<p>Error: Your browser doesn\'t support geolocation.</p>';
  }

  var directionsDisplay = new google.maps.DirectionsRenderer({
        draggable: true,
        map: map,
        panel: document.getElementById('google-map-right-panel')
      });

  // Instantiate an info window to hold step text.
  var stepDisplay = new google.maps.InfoWindow;

  var src_input = /** @type {!HTMLInputElement} */(
      document.getElementById('pac-input-src'));
  var dst_input = /** @type {!HTMLInputElement} */(
      document.getElementById('pac-input-dst'));

  var src_types = document.getElementById('type-selector-src').value;
  var dst_types = document.getElementById('type-selector-dst').value;

  var src_autocomplete = new google.maps.places.Autocomplete(src_input);
  src_autocomplete.bindTo('src_bounds', map);
  var dst_autocomplete = new google.maps.places.Autocomplete(dst_input);
  dst_autocomplete.bindTo('dst_bounds', map);

  var src_infowindow = new google.maps.InfoWindow();
  var src_marker = new google.maps.Marker({
    map: map,
    anchorPoint: new google.maps.Point(0, -29)
  });

  var dst_infowindow = new google.maps.InfoWindow();
  var dst_marker = new google.maps.Marker({
    map: map,
    anchorPoint: new google.maps.Point(0, -29)
  });
  //var bounds = new google.maps.LatLngBounds();

  var notificationBlock = document.getElementById('google-map-notification')

  src_autocomplete.addListener('place_changed', function() {
    var bounds = map.getBounds();
    notificationBlock.innerHTML= "<p></p>";
    src_infowindow.close();
    src_marker.setVisible(false);
    var src_place = src_autocomplete.getPlace();
    if (!src_place.geometry) {
      // User entered the name of a Place that was not suggested and
      // pressed the Enter key, or the Place Details request failed.
      notificationBlock.innerHTML = "<p>No details available for input: '" + src_place.name + "'</p>";
      return;
    }

    // If the place has a geometry, then present it on a map.
    src_marker.setIcon(/** @type {google.maps.Icon} */({
      url: src_place.icon,
      size: new google.maps.Size(71, 71),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(35, 35)
    }));
    src_marker.setPosition(src_place.geometry.location);
    src_marker.setVisible(true);

    var src_address = '';
    if (src_place.address_components) {
      src_address = [
        (src_place.address_components[0] && src_place.address_components[0].short_name || ''),
        (src_place.address_components[1] && src_place.address_components[1].short_name || ''),
        (src_place.address_components[2] && src_place.address_components[2].short_name || '')
      ].join(' ');
    }

    src_infowindow.setContent('<div><strong>' + src_place.name + '</strong><br>' + src_address);
    src_infowindow.open(map, src_marker);

    //bounds.extend(src_marker.getPosition());
    markerArray[0] = src_marker
    calculateAndDisplayRoute(directionsDisplay, directionsService, bounds, map);
  });

  dst_autocomplete.addListener('place_changed', function() {
    var bounds = map.getBounds();
    notificationBlock.innerHTML= "<p></p>";
    dst_infowindow.close();
    dst_marker.setVisible(false);
    var dst_place = dst_autocomplete.getPlace();
    if (!dst_place.geometry) {
      // User entered the name of a Place that was not suggested and
      // pressed the Enter key, or the Place Details request failed.
      notificationBlock.innerHTML= "<p>Information about source and/or desination unavailable or one of fields is empty. Please check your input data.</p>";
      return;
    }

    // If the place has a geometry, then present it on a map.
    dst_marker.setIcon(/** @type {google.maps.Icon} */({
      url: dst_place.icon,
      size: new google.maps.Size(71, 71),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(35, 35)
    }));
    dst_marker.setPosition(dst_place.geometry.location);
    dst_marker.setVisible(true);

    var dst_address = '';
    if (dst_place.address_components) {
      dst_address = [
        (dst_place.address_components[0] && dst_place.address_components[0].short_name || ''),
        (dst_place.address_components[1] && dst_place.address_components[1].short_name || ''),
        (dst_place.address_components[2] && dst_place.address_components[2].short_name || '')
      ].join(' ');
    }

    dst_infowindow.setContent('<div><strong>' + dst_place.name + '</strong><br>' + dst_address);
    dst_infowindow.open(map, dst_marker);

    markerArray[1] = dst_marker
    map.fitBounds(bounds);
    calculateAndDisplayRoute(directionsDisplay, directionsService, bounds, map);
  });
  // Sets a listener on a select field to change the filter type on Places
  // Autocomplete.

  function typeChangeHandler(id) {
    var selectField = document.getElementById(id);
    var type = [];
    switch (selectField.value) {
      case 'changetype-all':
        type = []
        break
      case 'changetype-address':
        type = ['address']
        break
      case 'changetype-establishment':
        type = ['establishment']
        break
      case 'changetype-geocode':
        type = ['geocode']
        break
      default:
        type = []
    }
    if (id == 'type-selector-src'){
      src_autocomplete.setTypes(type);
    }
    else if (id == 'type-selector-dst') {
      dst_autocomplete.setTypes(type);
    }
  }

  document.getElementById('type-selector-src').addEventListener('change', function() {
      typeChangeHandler('type-selector-src');
  });

  document.getElementById('type-selector-dst').addEventListener('change', function() {
      typeChangeHandler('type-selector-dst');
  });


  // calculateAndDisplayRoute(directionsDisplay, directionsService, bounds, map);
    // Listen to change events from the start and end lists.
  var travelModeChangeHandler = function() {
      calculateAndDisplayRoute(directionsDisplay, directionsService, bounds, stepDisplay, map);
  };

  document.getElementById('travel-mode').addEventListener('change', function() {
      travelModeChangeHandler();
  });

  function calculateAndDisplayRoute(directionsDisplay, directionsService,
      bounds, stepDisplay, map) {
    notificationBlock.innerHTML= "<p></p>";
    var selectedMode = document.getElementById('travel-mode').value;
    // First, remove any existing markers from the map.
    for (var i = 0; i < markerArray; i++) {
      markerArray[i].setMap(null);
    }

    // Retrieve the start and end locations and create a DirectionsRequest using
    // WALKING directions.
    directionsService.route({
      origin: document.getElementById('pac-input-src').value,
      destination: document.getElementById('pac-input-dst').value,
      travelMode: google.maps.TravelMode[selectedMode]
    }, function(response, status) {
      // Route the directions and pass the response to a function to create
      // markers for each step.
      if (status === 'OK') {
        notificationBlock.innerHTML = '<p>' + response.routes[0].warnings + '</p>'
        directionsDisplay.setDirections(response);
        showSteps(response, ma, map);
      } else {
        notificationBlock.innerHTML = '<p>Direction unavailable. Please try to change travel mode or check source and destination.</p>';
      }
    });
  }

  function showSteps(directionResult, bounds, stepDisplay, map) {
    // For each step, place a marker, and add the text to the marker's infowindow.
    // Also attach the marker to an array so we can keep track of it and remove it
    // when calculating new routes.
    var myRoute = directionResult.routes[0].legs[0];
    for (var i = 0; i < myRoute.steps.length; i++) {
      var marker = bounds[i] || new google.maps.Marker;
      marker.setMap(map);
      marker.setPosition(myRoute.steps[i].start_location);
      attachInstructionText(
            stepDisplay, marker, myRoute.steps[i].instructions, map);
    }
  }

  function attachInstructionText(stepDisplay, marker, text, map) {
    google.maps.event.addListener(marker, 'click', function() {
      // Open an info window when the marker is clicked on, containing the text
      // of the step.
      stepDisplay.setContent(text);
      stepDisplay.open(map, marker);
    });
  }
    $('#routeModal').on('open.zf.reveal', function () {
      console.log("ok");
      google.maps.event.trigger(map, 'resize');
    });
}

var key = "AIzaSyCo4Y2q3GO6_gO-XmE8eqjdO1aah_2RbB0";
prepScript("https://maps.googleapis.com/maps/api/js?key=" + key + "&libraries=places&callback=initMap");
