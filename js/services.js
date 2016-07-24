/*Angular service used to transfer data between controllers
 * 
 */

app.service('location-service',['$location'], function(){
	this.pi = 3.14159;
	
	this.area = function(radius){
		return radius * radius * this.pi;
	};
	
	this.circumference = function(radius){
		return 2 * radius * this.pi;
	};
});

//describe('testing the location-service', function(){
//	beforeEach(module('app'));
//});