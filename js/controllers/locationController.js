


// Google map
app.controller('mapCtrl2', function($scope,$http) {

    var url = "http://"+host+"/restful/geocoordinate";
    console.log("url: "+url);

    var geocoder;
    var myLatlng = new google.maps.LatLng(34, -118);
    var map;
    var markers = [];
    var mapOptions = {
        zoom : 12,
        disableDefaultUI : true,
        disableDoubleClickZoom : true
    }
    $scope.map = new google.maps.Map(document.getElementById("map-actual"), mapOptions);
    $scope.map.setCenter(myLatlng);
    geocoder = new google.maps.Geocoder();

    $scope.codeAddress = function() {
        var address = document.getElementById('address').value;
        geocoder.geocode({
            'address' : address
        }, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                $scope.clearMarkers();
                $scope.map.setCenter(results[0].geometry.location);
                $scope.marker = new google.maps.Marker({
                    map : $scope.map,
                    draggable:true,
                    position : results[0].geometry.location,
                    animation : google.maps.Animation.DROP
                });
                markers.push($scope.marker);
                var infoWindow = new google.maps.InfoWindow({
                    content : address
                });

                infoWindow.open($scope.map, $scope.marker);

                // store lat/long params
                $http.post(url+"/setGeoCoordinate").success(
                    $scope.onSubmitLocation = function(response) {
                        $scope.latitude = $scope.marker.getPosition().lat();
                        $scope.longitude = $scope.marker.getPosition().lng();
                    }).error(function(error) {
                        console.log("error with setting geocoordinate!");
                    });

                // fetch lat/long from map marker
                $http.get(url+"/getGeoCoordinate").success(
                    function(response) {

                        $scope.latitude = response[0];
                        $scope.longitude = response[1];
                    }).error(function(error) {
                        console.log("some error occured while getting geocoordinate = " + error);
                    });
            }
            else {
                alert('You have not entered an address yet! Error: ' + status);
            }
        });
    }

    //clears markers array and removes all markers from map
    $scope.clearMarkers = function() {
        for(i = 0; i< markers.length; i++){
            markers[i].setMap(null);
        }
        markers =[];
    }

});


// Google map
app.controller('mapCtrl', function($scope) {

    // var latitude = 34, longitude = -118;
    // var myLatlng = new google.maps.LatLng(latitude, longitude);
    var mapOptions = {
        zoom : 15,
        // center : myLatlng,
        disableDefaultUI : true,
        disableDoubleClickZoom : true
    }
    $scope.map = new google.maps.Map(document.getElementById("map-actual"), mapOptions);

    // To add the marker to the map, use the 'map' property
    // var marker = new google.maps.Marker({
    // position : myLatlng,
    // map : $scope.map,
    // draggable : true,
    // animation : google.maps.Animation.DROP,
    // title : "Map marker for rainmod"
    // });
    //
    // //$scope.pos = "Original Location:" + marker.getPosition().toString();
    //
    // var infoWindow = new google.maps.InfoWindow({
    // content : "Drag to target location"
    // });
    //
    // infoWindow.open($scope.map, marker);


    // Try HTML5 geolocation
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

            // To add the marker to the map, use the 'map' property
            var marker = new google.maps.Marker({
                position : $scope.pos,
                map : $scope.map,
                draggable : true,
                animation : google.maps.Animation.DROP,
                title : "Map marker for rainmod"
            });

            var infoWindow = new google.maps.InfoWindow({
                content : 'You are here'
            });

            infoWindow.open($scope.map, marker);

            $scope.map.setCenter($scope.pos);

            google.maps.event.addListener(marker, 'mouseout', function() {
                infoWindow.close();
            });

            google.maps.event.addListener(marker, 'mouseover', function() {
                mouseDrag($scope.map, marker);
            });

            function mouseDrag(map, marker) {
                infoWindow.setContent("This is your rainmodulator's location!");
                infoWindow.open(map, marker);

                // display current lat/long of marker
                /* alert(marker.getPosition()); */

                if (marker.getAnimation() != null) {
                    marker.setAnimation(null);
                }
                else {
                    marker.setAnimation(google.maps.Animation.BOUNCE);
                }
            }

        }, function() {
            handleNoGeolocation(true);
        });

    } else {
        // Browser doesn't support Geolocation
        handleNoGeolocation(false);
    }

    function handleNoGeolocation(errorFlag) {
        if (errorFlag) {
            var content = 'Error: The Geolocation service failed.';
        }
        else {
            var content = 'Error: Your browser doesn\'t support geolocation.';
        }

        var options = {
            map : $scope.map,
            position : new google.maps.LatLng(34, -118),
            content : content
        };

        var infowindow = new google.maps.InfoWindow(options);
        $scope.map.setCenter(options.position);
    } //end html5 error handles

});


