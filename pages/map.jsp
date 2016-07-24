<div class="jumbo-contain">

	<h2>
		<i class="fa fa-globe"></i> Rain Modulator Location
	</h2>
	<h4>Please enter approximate location of rainmodulator</h4>

	<div class="row">
		<!-- gmap -->
		<div class="col-md-12" ng-controller="mapCtrl2">

			<div id="location-panel">
				<form ng-submit="onSubmitLocation()">
					<div>
						Enter your location here: <input id="address" type="text" placeholder="City or ZipCode"> 
						<input type="button" class="btn btn-success" value="Drop a marker" ng-click="codeAddress()"> 
						<input type="button" class="btn btn-warning" value="Clear marker" ng-click="clearMarkers()">
						<input type="submit" class="btn btn-primary" value="Get Marker Location"> 
					</div>
					<div>
						<i>{{latitude}} {{longitude}}</i>
					</div>
				</form>
			</div>
			<div id="map-actual"></div>
		</div> 
	</div>
</div>