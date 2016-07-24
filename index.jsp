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

<title>Rain Modulator Dashboard</title>

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



		<script src="js/angularjs/1.3.14/angular.min.js"></script>
		<script src="js/angularjs/1.3.14/angular-route.min.js"></script>
		<script src="js/ui.bootstrap/ui-bootstrap-tpls-0.13.4.min.js"></script>



        <!-- Bootstrap core JavaScript xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -->
        <script src="/js/jquery-2.1.1.min.js"></script>
        <script src="/js/bootstrap.min.js"></script>




		<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>

		<!-- chart api-->
		<script type="text/javascript" src="https://www.google.com/jsapi"></script>


		<script src="js/app.js"></script>

        <!--Controllers -->
        <script src="js/controllers/mainController.js"></script>
		<script src="js/controllers/locationController.js"></script>
		<script src="js/controllers/dataController.js"></script>
		<script src="js/controllers/programController.js"></script>
		<script src="js/controllers/settingsController.js"></script>

        <script src="js/services.js"></script>
        <script src="js/directives.js" ></script>

		<!--button logic js -->
		<script src="/js/jquery.knob.js" type="text/javascript"></script>

	</div>

</body>
</html>