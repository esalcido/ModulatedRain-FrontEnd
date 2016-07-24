

// programs selector and viewer
app.controller('programCtrl', function($scope, $http) {

    var url = "http://"+host+"/restful/selector/getProgramNamesDescriptions";
    console.log("url: "+url);

    //set refresh interval for updating the frontend program view
    setInterval(function() {
        $scope.$apply(
            // fill json object with after dark and cycle now program status
            $http.get(url).success(
                function(response) {
                    $scope.programNamesDescriptions = [ {
                        key : "After Dark",
                        value : response[0]
                    }, {
                        key : "Cycle Now",
                        value : response[1]
                    } ];
                }).error(function(error) {
                    console.log("programCtrl some error occured. error = " + error);
                }));
    }, 1000); //1 second interval to update div
});


// knob controller on programs view
app.controller('knobCtrl', function($scope) {
    $scope.number = 24;
});

app.directive('knob', function() {
    return {
        restrict : 'A',
        link : function(scope, element, attrs) {
            $(element).val(scope.number).knob();
        }
    };
});
