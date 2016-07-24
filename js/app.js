/**
 * Created by edward on 4/3/15.
 */

var app = angular.module('rain-mod', [ 'ngRoute','ui.bootstrap']);

app.config([ '$routeProvider', function($routeProvider) {
	$routeProvider.when('/main', {
		templateUrl : 'pages/main.jsp',
		controller : 'tabCtrl'
	}).when('/map', {
		templateUrl : 'pages/map.jsp',
		controller : 'mapCtrl2'
	}).when('/chart', {
		templateUrl : 'pages/chart.jsp',
		controller : 'chartCtrl'
	}).when('/table', {
		templateUrl : 'pages/table.jsp',
		controller : 'tableCtrl'
	}).when('/week', {
		templateUrl : 'pages/programs.jsp',
		controller : 'programCtrl'
	}).when('/setting', {
		templateUrl : 'pages/settings.jsp',
		controller : 'settingsCtrl'
	}).otherwise({
	redirectTo:'/main'
	});
} ]);


