
google.load('visualization', '1.1', {
    packages : [ 'line' ]
});
// google.setOnLoadCallback(function(){
// angular.bootstrap(document.body,['rain-mod']);
// });




// tab js
app.controller('tabCtrl', function($scope, $http) {

    $scope.changeTab = function(tab) {
        $scope.view_tab = tab;
    }
});

// table
app.controller('tableCtrl', function() {

});

// chart
app.controller('chartCtrl', function($scope) {

    // google.load('visualization', '1.1', {packages: ['line']});
    // google.setOnLoadCallback(drawChart);

    var data;

    data = new google.visualization.DataTable();
    data.addColumn('number', 'Day');
    data.addColumn('number', 'Temperature');
    data.addColumn('number', 'Humidity');
    data.addColumn('number', 'Precipitation');

    for (i = 0; i < 32; i++) {
        fillArray(data);
    }

    var options = {
        chart : {
            title : 'Monthly temperature/humidity Chart',
            subtitle : 'Shown in degrees fahrenheit'
        },
        width : 1200,
        height : 600

    };

    var chart = new google.charts.Line(document.getElementById('linechart_material'));

    chart.draw(data, options);

    function fillArray(array) {
        randomT = Math.random() * 150 + 1;
        randomH = Math.random() * 100 + 1;
        randomP = Math.random() * 100 + 1;
        array.addRows([ [ i, randomT, randomH, randomP ] ]);
    }
});