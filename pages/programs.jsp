<div class="jumbo-contain2" ng-controller="programCtrl">

	<div class="row">
		<div class="main">
			<h1>Program Selector Menu</h1>
			<div ng-controller="programCtrl">
				<div class="col-sm-12 col-md-12">
					<div ng-repeat="nd in programNamesDescriptions">{{nd.value}}</div>
				</div>
			</div>
			<hr>

			<div class="placeholder"></div>
			<div class="main">
				<strong>After Dark</strong>
				<p>Days: All. Time: 15 minutes after sunset. Duration: 5 minutes per zone.</p>
				<input type="submit" class="btn btn-primary" value="Set After Dark" id="set-after-dark">
			</div>
			<hr>

			<div class="main">
				<strong>Los Angeles Program</strong>
				<p>Days: Mon/Wed/Fri(even) or Tue/Thu/Sun(odd). Time: 45 minutes after sunset. Duration: 8
					minutes per zone.</p>
				<input type="submit" class="btn btn-primary" value="Set LA Even" id="set-la-even"> <input
					type="submit" class="btn btn-primary" value="Set LA Odd" id="set-la-odd">
			</div>
			<hr>
			<div class="main">
				<strong>Custom Program(WIP)</strong> <input type="checkbox" ng-model="checked" id="set-custom">
				<p>Set your own watering days and times.</p>
			</div>
			<hr>
		</div>
	</div>
	<br>

	<div class="row" id="custom-program" ng-show="checked">
	<div class="col-md-4" id="week">
		<div class="week-column">
			<div class="day">
				<h1>Sunday</h1>
			</div>
			<div class="day">
				<h1>Monday</h1>
			</div>
			<div class="day">
				<h1>Tuesday</h1>
			</div>
			<div class="day">
				<h1>Wednesday</h1>
			</div>
			<div class="day">
				<h1>Thursday</h1>
			</div>
			<div class="day">
				<h1>Friday</h1>
			</div>
			<div class="day">
				<h1>Sunday</h1>
			</div>
		</div>
	</div>
	
	<div class="col-md-8" id="week1">
		<div class="week">
			<div class="start-time">
				<div>
					<div class="start-time">
						<h4>Set Start Time</h4>
						<input type="text" value="1" knob class="dial" data-min="1" data-max="12" data-width="150" data-angleOffset="180" data-fgColor="#1995dc">
						<div>
							<input type="radio" name="am-selector"> AM  
							<input type="radio" name="pm-selector"> PM
						</div>
					</div>
					<div class="duration">
						<h4>Set Water Duration</h4>
						<input type="text" value="2" knob class="dial" data-min="0" data-max="10" data-width="150"
							data-angleOffset="180" data-fgColor="#1995dc">
						<div class="trigger">
							<button type="button" class="btn btn-lg btn-success">Save</button>
						</div>
					</div>
	
				</div>
			</div>
		</div>
	</div>
</div>

</div>