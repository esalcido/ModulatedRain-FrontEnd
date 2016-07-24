

// main page
app.controller('weatherWidgetCtrl', function($scope, $http) {

    var url = "http://" + host + "/restful/weather/getWeather";
    console.log("url: " + url);

    //initial call to getWeather
    getW();

    // set refresh interval for updating the frontend program view
    setInterval(
        $apply = function() {
            try {
                getW();
            } finally {
                $scope.$digest();
            }
        }
        ,300000); //update every x minutes

    function getW(){
        $http.get(url).success(function(response) {
            $scope.names = response;
        }).error(function(error) {
            console.log("weatherWidgetCtrl error = " + error);
        })
    }
});


// button logic
app.controller('buttonCtrl', function($scope,$http) {

    //zone buttons json for creation
    $scope.datasets =[
        {name:'station1-btn',isOn:false,station:'1',desc:'Front Lawn'},
        {name:'station2-btn',isOn:false,station:'2',desc:'Front Lawn 2'},
        {name:'station3-btn',isOn:false,station:'3',desc:'Front Lawn 3'},
        {name:'station4-btn',isOn:false,station:'4',desc:'Front Lawn 3'},
        {name:'station5-btn',isOn:false,station:'5',desc:'Front Lawn 3'},
        {name:'station6-btn',isOn:false,station:'6',desc:'Front Lawn 3'},
        {name:'station7-btn',isOn:false,station:'7',desc:'Front Lawn 3'},
        {name:'station8-btn',isOn:false,station:'8',desc:'Front Lawn 3'}

    ];

    //data structure that holds the previous button that was pressed
    var stack = new Array();

    //zone control

    console.log("before stack.length "+stack.length);
    //coming from ng-click
    console.log("coming from before ngclick");


    //function called from the click of the button
    $scope.toggle=function(btn) {

        //get the button status.  initially false which means its off.
        var buttonStatus=Number(btn.isOn);
        console.log("number isOn = "+Number(btn.isOn));


        console.log("coming from after  ngclick.  btn.isOn " + btn.isOn);

        //if stack is empty, if button is off turn it on else turn it off.
        if (stack.length <= 0) {
            console.log("stack.length "+stack.length);

            if (btn.isOn == false) {

               turnOn(btn,buttonStatus);

            }
            else{
              turnOff(btn,buttonStatus);

            }
            //push this button to the stack for later reference
            stack.push(btn);
        }
        else {
            //If stack is not empty,
            if (stack.length > 0) {
                console.log("Stack is not empty " + stack.length);
                //get button from stack.
                var prevButton = stack.pop();
                console.log("previous button: " + prevButton.name);

                //if button is not the same one being pressed, if that button is off, turn off the previous button and turn on current button.  Else turn off the current button.
                if(prevButton.name != btn.name){
                    if (btn.isOn == false) {

                        //turn off prev button
                        turnOff(prevButton,buttonStatus);

                        //turn on current button
                        turnOn(btn,buttonStatus);
                        //url = "http://" + host + "/restful/zone/" + btn.station + "/" + buttonStatus;
                        stack.push(btn);

                    }
                    else{
                        turnOff(btn,buttonStatus);
                    }
                }
                else{
                    turnOff(btn,buttonStatus);
                }
            }
        }
    }

    function turnOn(btn,buttonStatus){
        var url;

        btn.isOn = true;
        buttonStatus = 1;
        console.log("turn on buttonstatus = " + buttonStatus);
        console.log("turn on btn = " + btn.isOn);

        //call to jaxrs
        url = "http://" + host + "/restful/zone/" + btn.station + "/" + buttonStatus;
        console.log("url: " + url);
        $http.get(url)
            .success(function (response) {

            });

    }

    function turnOff(btn,buttonStatus){
        btn.isOn = false;
        buttonStatus = 0;

        var url;

        console.log("turn off buttonstatus = " + buttonStatus);
        console.log("turn off btn = " + btn.isOn);

        //call to jaxrs
        url = "http://" + host + "/restful/zone/" + btn.station + "/" + buttonStatus;
        console.log("url: " + url);

        $http.get(url)
            .success(function (response) {

            });

    }

});


// cycle through
app.controller('cycleNowCtrl',function($scope,$http){

    var stack = new Array();

    $scope.singleModel = "1";

    $scope.turnOn= function(){
       // alert("miopwnf");
        //button testing single toggle button
       if($scope.btncss =="btn-primary"){

           $scope.btncss = "btn-success";
       } else{  $scope.btncss ="btn-primary"}

    }




    //GET STATE================



    var delayFromREST;
    delayFromREST = getDelay();


    function getDelay() {
        var url = "http://" + host + "/restful/zone/1/getState";
        //check status of the button.  is it on or off?
        var delayFromREST1;
        $http.get(url)
            .success(function(data) {
                //if(response.response=='NEXT_SPRINKLER_HEAD'){
                //    $scope.class_name = 'on';
                //   // alert('response is '+response.response);
                //}
                delayFromREST1 = data;
                //alert("response is: " + delayFromREST);


            }).error(function (data) {
                //$scope.class_name = 'off';
                // alert('response is '+response.response);
            });
        return delayFromREST1;

    }








    //on page load set to off
    $scope.class_name="off";
    //toggle depending
    $scope.toggle=function(){

        if($scope.class_name=='off') {
            // alert("it worked");
            $scope.class_name = 'on';
        }else{
            $scope.class_name = 'off';
        }

    }

    $scope.myStyle={};


        // // BUTTON  - when user clicks on the button
        $("#cycleNow").click(function () {


            if($scope.class_name=='off') {
                // call action for this button
                // send
                var url = "http://" + host + "/restful/selector/startCycle/1";
                console.log("url: " + url);
                $http.get(url)
                    .success(function (response) {
                        $scope.class_name = 'on';
                    }).error(function(response){
                        $scope.class_name = 'off';
                    });

                if (stack.length > 0) {

                    //var bn = stack.pop();
                    //turnOffButton(bn);

                }
                // add this button to the stack
                var button = this;
                stack.push(button);

                console.log('class name from on: '+$scope.class_name);
            }
            //if($scope.class_name=='on'){
            else{


                // pop off stack
                stack.pop();


                var url = "http://" + host + "/restful/selector/startCycle/0";
                console.log("url: " + url);
                $http.get(url)
                    .success(function (response) {
                        //change css back to off
                        $scope.class_name = 'off';
                    }).error(function(response){
                        $scope.class_name = 'on';
                    });

                console.log('class name from off: '+$scope.class_name);
            }
        });

});
