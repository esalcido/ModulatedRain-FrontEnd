<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.TimeZone"%>
<%@page import="com.regulatedthings.controller.rainmodulator.CloudInfoGatherer"%>
<%@page import="com.regulatedthings.controller.devices.gizmos.RainRelayActuator"%>
<%@page import="com.regulatedthings.controller.devices.RainDevice"%>
<%@page import="com.regulatedthings.controller.devices.DeviceFactory"%>
<%@page import="com.regulatedthings.controller.devices.Device"%>
<%@page import="com.regulatedthings.controller.devices.Gizmo"%>
<%@page import="com.regulatedthings.controller.devices.Actuator"%>
<%@page import="com.regulatedthings.controller.SunUpDown"%>
<%@page import="java.net.InetAddress,com.regulatedthings.controller.*"%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.regulatedthings.controller.rainmodulator.CycleSprinklerHeadsProgram"%>
<%@page import="com.regulatedthings.controller.rainmodulator.AfterDarkRainProgram"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.regulatedthings.controller.Program"%>
<%@page import="com.regulatedthings.controller.ProgramScheduler"%>
<%@page import="com.regulatedthings.controller.devices.Gizmo"%>
<%@page import="com.regulatedthings.controller.rainmodulator.LocalInfo"%>
<%@page import="com.regulatedthings.controller.rainmodulator.RainModulatorResources"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="/css/flat-button.css" rel="stylesheet">
<link href="/css/etabs.css" rel="stylesheet">

<!-- css for weekday toggle -->
<link href="/css/weekday-toggle.css" rel="stylesheet">

<!-- Bootstrap core CSS -->
<link href="/css/bootstrap.min.css" rel="stylesheet">

<link href="http://netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">

<!-- Custom styles for this template -->
<link href="/css/dashboard.css" rel="stylesheet">
<link href="/css/animate.css" rel="stylesheet">

<title>Index Angular</title>

</head>
<body ng-app="rain-mod">
	<%--<body>--%>
	<div class="container">
		<!--nav bar-->
		<div ng-include="'layout/navbar.jsp'"></div>

		<div class="container-fluid">
			<div class="row">

				<!--main content -->
				<div class="col-md-12 main">

					<div ng-view></div>

					<div ng-include="'layout/footer.jsp'"></div>
				</div>
				<!--  end main content col-sm-9  -->
			</div>
			<!-- end class row -->
		</div>
		<!--End container -->

		<!-- Bootstrap core JavaScript xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -->
		<script src="/js/jquery-2.1.1.min.js"></script>
		<script src="/js/bootstrap.min.js"></script>

		<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular-route.min.js"></script>

		<!--google map api -->
		<%--<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>--%>
		<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>

		<!-- chart api-->
		<script type="text/javascript" src="https://www.google.com/jsapi"></script>

		<!--button logic js -->
		<%--<script src="/js/button-logic_with-stack.js" type="text/javascript"></script>--%>

		<script src="js/app.js"></script>
		<script src="js/controllers.js"></script>
		<script src="js/services.js"></script>

		<!--button logic js -->
		<script src="/js/jquery.knob.js" type="text/javascript"></script>

	</div>

</body>
</html>