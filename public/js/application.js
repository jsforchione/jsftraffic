$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
});

function get_traffic(){
  var origin_street = $('#origin_street').val();
  var origin_city = $('#origin_city').val();
  var origin_state = $('#origin_state').val();
  var origin_LatLng = '';
  var destination_street = $('#destination_street').val();
  var destination_city = $('#destination_city').val();
  var destination_state = $('#destination_state').val();
  
  var destination_Lat = '';
  var destination_Lng = '';
  var origin_Lat = '';
  var origin_Lng = '';
  
  if (origin_street != '') {
    var origin = origin_street + ' ' +origin_city + ', ' + origin_state;  
  } else {
    var origin = origin_city + ', ' + origin_state;
  }
  if (destination_street != '') {
    var destination = destination_street + ' ' + destination_city + ', ' + destination_state;
  } else {
    var destination = destination_city + ', ' + destination_state;
  }
  

  var geocoder = new google.maps.Geocoder();


  geocoder.geocode({'address': origin}, function(results, status) {
    if (status === 'OK') {

      origin_Lat = results[0].geometry.viewport.f.b;
      origin_Lng = results[0].geometry.viewport.b.b;
      

      geocoder.geocode({'address': destination}, function(results, status) {
        if (status === 'OK') {
          destination_Lat = results[0].geometry.viewport.f.b;
          destination_Lng = results[0].geometry.viewport.b.b;

          var originLatLng = new google.maps.LatLng(origin_Lat, origin_Lng);
          var originAddress = origin_street + ' ' + origin_city + ',' + origin_state;
          var destinationAddress = destination_street + ' ' + destination_city + ',' + destination_state;

          var destinationLatLng = new google.maps.LatLng(destination_Lat, destination_Lng);


          var service = new google.maps.DistanceMatrixService();

          service.getDistanceMatrix(
          {
            origins: [originLatLng, originAddress],
            destinations: [destinationLatLng, destinationAddress],
            travelMode: 'DRIVING',
            unitSystem: google.maps.UnitSystem.IMPERIAL
    // avoidHighways: Boolean,
    // avoidTolls: Boolean,
  }, callback);

          function callback(response, status) {
    // See Parsing the Results for
    // the basics of a callback function.
    var durationValue = response.rows[1].elements[0].duration.value;
    var durationText = response.rows[1].elements[0].duration.text;

    var distanceValue = response.rows[1].elements[0].distance.value;
    var distanceText = response.rows[1].elements[0].distance.text;
    
    
    var data = {
      origin: origin,
      destination: destination,
      duration_value: durationValue,
      duration_text: durationText,
      distance_text: distanceText,
      distance_value: distanceValue
    };


    $.ajax({
      method: 'POST',
      url: '/routes',
      data:data
    });
  };


  } else {
    alert('Geocode was not successful for the following reason: ' + status);
  }
  });
  } else {
    alert('Geocode was not successful for the following reason: ' + status);
  }
  })
}