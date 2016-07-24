<div class="jumbo-contain">

	<!--top container for forecast and map-->
	<div class="row">
		<!--current weather -->
		<div id="forecast" class="col-md-6" ng-controller="weatherWidgetCtrl">
			<h2>
				<i class="fa fa-sun-o"></i> Current Weather
			</h2>
			<img alt="Weather Image not available" src="{{names.weatherImage}}">
			<p>Temperature: {{names.temperature}}&deg; F</p>
			<p>Humidity: {{names.humidity}}&#37; </p>


            <div id="cycleNowPlaceholder" ng-controller="cycleNowCtrl" >
                <button id="cycleNow" ng-class="{on:'btn btn-success',off:'btn btn-danger'}[class_name]"  ng-click="toggle()">Cycle Now</button>
                <%--<button id="stopCycleNow" class="btn btn-info">Stop Cycle Now</button>--%>
					<br>
				<%--<button type="button" class="btn btn-primary" ng-model="singleModel"  ng-class="btncss"  ng-click="turnOn()" btn-checkbox btn-checkbox-true="1" btn-checkbox-false="0">{{singleModel}}</button>--%>
            </div>


			<br>

			<div class="row">
				<div ng-controller="programCtrl">
					<div ng-repeat="nd in programNamesDescriptions">{{nd.value}}</div>
				</div>

			</div>
			<!-- end row -->

		</div><!-- END current weather -->

		<!-- button-panel -->
		<div id="button-panel" ng-controller="buttonCtrl">

			<div class="col-xs-12 col-sm-12 col-md-6">
				<h2><i class="fa fa-power-off"></i> Manual Zone Controls</h2>

				<div  ng-repeat="zone in datasets" >

						<div class="col-xs-12 col-sm-12 col-md-6 placeholder">

						<button id="{{ zone.name }}"  ng-class="{true:'btn btn-success',false:'btn btn-danger'}[zone.isOn]" type=submit ng-click="toggle(zone);">{{zone.isOn}}</button>
							<h4>{{zone.desc}}</h4>
						<span class="text-muted">Zone {{ zone.station}}</span>
					</div>
				<%--</div>--%>
				</div>
			</div>
				<%--<div class="col-xs-12 col-sm-12 col-md-6 placeholder">
					<input id="station1-btn"  type=submit class="btn btn-danger" value="OFF">
					<form name="input" method="get"></form>
					<h4>Front lawn</h4>
					<span class="text-muted">Zone 1</span>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 placeholder">
					<input id="station2-btn" type=submit class="btn btn-danger" value="OFF">
					<form name="input" method="get"></form>
					<h4>Side flowers</h4>
					<span class="text-muted">Zone 2</span>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 placeholder">
					<input id="station3-btn" type=submit class="btn btn-danger" value="OFF">
					<form name="input" method="get"></form>
					<h4>Backyard lawn</h4>
					<span class="text-muted">Zone 3</span>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 placeholder">
					<input id="station4-btn" type=submit class="btn btn-danger" value="OFF">
					<form name="input" method="get"></form>
					<h4>Backyard garden</h4>
					<span class="text-muted">Zone 4</span>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 placeholder">
					<input id="station5-btn" type=submit class="btn btn-danger" value="OFF">
					<form name="input" method="get"></form>
					<h4>Dallas</h4>
					<span class="text-muted">Zone 5</span>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 placeholder">
					<input id="station6-btn" type=submit class="btn btn-danger" value="OFF">
					<form name="input" method="get"></form>
					<h4>Baton Rouge</h4>
					<span class="text-muted">Zone 6</span>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 placeholder" >
					<input id="station7-btn" type=submit class="btn btn-danger" value="OFF">
					<form name="input" method="get"></form>
					<h4>Reno</h4>
					<span class="text-muted">Zone 7</span>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-6 placeholder">--%>
					<%--<input id="station8-btn" type=submit class="btn btn-danger" value="OFF">--%>
					<%--<form name="input" method="get"></form>--%>
					<%--<h4>Tampa</h4>--%>
					<%--<span class="text-muted">Zone 8</span>--%>
				<%--</div>--%>


		</div>

    </div><!--end row -->



</div>