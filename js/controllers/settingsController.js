

//host variable
var host = window.location.host;
console.log(host);

//timepicker ctrl
//ngular.module('ui.bootstrap').controller('TimepickerDemoCtrl', function ($scope, $log) {
app.controller('TimepickerDemoCtrl', function ($scope, $log) {
    $scope.mytime = new Date();

    $scope.hstep = 1;
    $scope.mstep = 15;

    $scope.options = {
        hstep: [1, 2, 3],
        mstep: [1, 5, 10, 15, 25, 30]
    };

    $scope.ismeridian = true;
    $scope.toggleMode = function() {
        $scope.ismeridian = ! $scope.ismeridian;
    };

    $scope.update = function() {
        var d = new Date();
        d.setHours( 14 );
        d.setMinutes( 0 );
        $scope.mytime = d;
    };

    $scope.changed = function () {
        $log.log('Time changed to: ' + $scope.mytime);
    };

    $scope.clear = function() {
        $scope.mytime = null;
    };
});

// host settings page for adjusting network settings
app.controller('settingsCtrl', function($scope, $http) {


    var url = "http://"+host+"/restful/network";
    console.log("url: "+url);

    $http.get(url+"/getHostname").success(function(response) {
        $scope.hostname = response;
    }).error(function(error) {
        console.log("settingsCtrl some error occured. error = " + error);
    });


    console.log("url: "+url);
    // store all host param
    $http.post(url+"/setHostname").success(
        $scope.onSubmitHost = function(response) {
            $scope.hostname = response;
        }).error(function(error) {
            console.log("settingsCtrl store host param some error occured. error = " + error);
        });


    console.log("url: "+url);
    $http.get(url+"/getDNS").success(function(response) {
        $scope.dns1 = response.primaryDNS;
        $scope.dns2 = response.secondaryDNS;
    }).error(function(error) {
        console.log("settingsCtrl get dns some error occured. error = " + error);
    });

    // store all host params inside json array called host
    $http.post(url+"/setDNS").success(
        $scope.onSubmitDNS = function(response) {
            $scope.dnsList = [ {
                key : "DNS1",
                value : $scope.dns1
            }, {
                key : "DNS2",
                value : $scope.dns2
            } ];
        }).error(function(error) {
            console.log("settingsCtrl set DNS some error occured. error = " + error);
        });

    $http.get(url+"/getIP4info").success(function(response) {
        $scope.ipaddress = response.ipAddress;
        $scope.ipgateway = response.ipGateway;
        $scope.ipmask = response.ipSubnetMask;
    }).error(function(error) {
        console.log("settingsCtrl get  ip4 some error occured. error = " + error);
    });

    // store all ipv4 params inside json array called ipv4list
    $http.post(url+"/setIP4info").success(
        $scope.onSubmitIPv4 = function() {
            $scope.ip4List = [ {
                key : "IPv4 Address",
                value : $scope.ipAddress
            }, {
                key : "IPv4 Gateway",
                value : $scope.ipGateway
            }, {
                key : "IPv4 Subnet Mask",
                value : $scope.ipSubnetMask
            } ];
        }).error(function(error) {
            console.log("ERROR setting ipv4");
        });

    $http.get(url+"/getIP6info").success(function(response) {
        $scope.ipaddress = response.ipAddress;
        $scope.ipgateway = response.ipGateway;
        $scope.ipmask = response.ipSubnetMask;
    }).error(function(error) {
        console.log("settingsCtrl getip6 some error occured. error = " + error);
    });

    // store all ipv6 params inside json array called ipv6list
    $http.post(url+"/setIP6info").success(
        $scope.onSubmitIPv6 = function() {
            $scope.ip6List = [ {
                key : "IPv6 Address",
                value : $scope.ipAddress
            }, {
                key : "IPv6 Gateway",
                value : $scope.ipGateway
            }, {
                key : "IPv6 Subnet Mask",
                value : $scope.ipSubnetMask
            } ];
        }).error(function(error) {
            console.log("ERROR WITH setting IPV6");
        });

    // used to work with dropdown to hide each section
    manual4 = false;
    manual6 = false;

    goManual = function() {
        var man4 = ipv4manually;
        if(man4 == 'manual-ipv4'){
            manual4 = true;
        } else {
            manual4 = false;
        }

        var man6 = ipv6manually;
        if(man6 == 'manual-ipv6'){
            manual6 = true;
        } else {
            manual6 = false;
        }

    };

    $scope.networkisVisible=true;
    $scope.userisVisible = false;
    //$scope.showHide = function(value){
    //
    //    if(value=='network') {
    //        $scope.networkisVisible = $scope.isVisible ? false : true;
    //    }
    //    if(value=='user'){
    //        $scope.userisVisible = $scope.isVisible ? false : true;
    //    }
    //}


});//end settings controller


app.controller('resetPasswordCtrl', function($scope, $http){

    var user="test";
    var url = "http://"+host+"/restful/";
    console.log("url: "+url);

    //get the user password from form
    $scope.user = {};
    $scope.user.password = "enter old password";
    $scope.newPassword = "enter new password";
    $scope.confirmPassword = "confirm new passrod";


    //this runs from user clicking submit
    $scope.resetPassword = function(){


        //get user from rest call
        $http.get(url+"user/getUser").success(function(response){

            //getting the user from rest
            $scope.userfbe = response.name;
            $scope.userpwfbe = response.password;

            //check to see if old pw matches the pw from the Backend
            if($scope.user.password == $scope.userpwfbe){
                //change to new password
                alert('old password matches with what we have on record');

                changePassword($scope.userfbe,$scope.newPassword);


            }
            else{
                alert('pw do not match. try again');
            }

            //alert('userfbe: '+ $scope.userfbe + ' user pw from be: '+ $scope.userpwfbe);

            function changePassword( uId,  newPw){
                $http.get(url+"user/changePW/"+uId+"/"+newPw).success(function(response){


                });

            }


        });



    };


});//end reset password ctrlr