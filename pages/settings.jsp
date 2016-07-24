
<div id="settings-contain">

	<h1>
		<i class="fa fa-tasks"></i> Rain Modulator Network Settings
	</h1>

	<div class="col-md-12">

		<div class="week">
			<div>
				<h3>Set Time</h3>
				<div ng-controller="TimepickerDemoCtrl" style="border-style: solid; border-width: 2px;padding:3px; ">

					<timepicker ng-model="mytime" ng-change="changed()" hour-step="hstep" minute-step="mstep" show-meridian="ismeridian"></timepicker>

					<pre class="alert alert-info">Time is: {{mytime | date:'shortTime' }}</pre>

					<div class="row">
						<div class="col-xs-6">
							Hours step is:
							<select class="form-control" ng-model="hstep" ng-options="opt for opt in options.hstep"></select>
						</div>
						<div class="col-xs-6">
							Minutes step is:
							<select class="form-control" ng-model="mstep" ng-options="opt for opt in options.mstep"></select>
						</div>
					</div>

					<hr>

					<button type="button" class="btn btn-info" ng-click="toggleMode()">12H / 24H</button>
					<button type="button" class="btn btn-default" ng-click="update()">Set to 14:00</button>
					<button type="button" class="btn btn-danger" ng-click="clear()">Clear</button>

				</div>
				<div ng-controller="settingsCtrl">
					<div class="row">
						<div class="main">
							<form ng-submit="onSubmitHost()">
								<div class="col-sm-12 col-md-6">
									Current Hostname: <br> <i>{{hostname}}</i>
									<div id="hostname">
										New Hostname: <input type="text" ng-model="hostname" name="hostname">
									</div>
									<input type="submit" id="submit" class="btn btn-info" value="Update Host">
								</div>
							</form>

							<form ng-submit="onSubmitDNS()">
								<div class="col-sm-12 col-md-6">
									<div>
										Current DNS1: <i>{{dns1}}</i> <br>
										Current DNS2: <i>{{dns2}}</i> <br>
										<div ng-repeat="dns in dnsList">Updated {{dns.key}}: <i>{{dns.value}}</i> </div>
									</div>
									<div>
										<br>
										New DNS1: <input type="text" ng-model="dns1" name="dns1"> <br>
										New DNS2: <input type="text" ng-model="dns2" name="dns2"> <br>
									</div>
									<br>
									<input type="submit" id="submit" class="btn btn-info" value="Update DNS">
								</div>
							</form>
						</div>
					</div><!-- END ROW -->
					<hr>

					<div class="main">
						Configure IPv4: <select class="dropdown" ng-model="ipv4manually">
							<option value="dhcp">Using DHCP</option>
							<option value="manual-ipv4">Manually</option>
						</select>
						<div class="main" id="auto-ipv4" ng-show="ipv4manually!='manual-ipv4'">
							<div>
								IPv4 address: <i>{{ipaddress}}</i>
							</div>
							<br>

							<div>
								IPv4 gateway: <i>{{ipgateway}}</i>
							</div>
							<br>

							<div>
								IPv4 subnet mask: <i>{{ipmask}}</i>
							</div>
							<br>
						</div>
						<div class="main" id="manual-ipv4" ng-show="ipv4manually=='manual-ipv4'">
							<strong>WARNING:</strong> Changing these settings may temporarily prevent communication!
							<form ng-submit="onSubmitIPv4()">
								<div>
									IPv4 Address: <input type="text" ng-model="ipaddress" name="address" placeholder="address" >
								</div>
								<br>

								<div>
									IPv4 Gateway: <input type="text" ng-model="ipgateway" name="gateway" placeholder="router" >
								</div>
								<br>

								<div>
									IPv4 Subnet Mask: <input type="text" ng-model="ipmask" name="netmask" placeholder="subnet mask" >
								</div>
								<br>
								<input type="submit" id="submit" class="btn btn-info" value="Update IPv4 Settings">
								<div ng-repeat="ip in ip4List">New {{ip.key}}: <i>{{ip.value}}</i></div>
							</form>
						</div>
					</div>


					<hr>

					<div class="main">
						Configure IPv6: 
						<select class="dropdown" ng-model="ipv6manually">
							<option value="dhcp">Automatically</option>
							<option value="manual-ipv6">Manually</option>
						</select>
						<div class="main" id="auto-ipv6" ng-show="ipv6manually!='manual-ipv6'">
							<div>
								IPv6 address: <i>{{ipaddress}}</i>
							</div>
							<br>

							<div>
								IPv6 gateway: <i>{{ipgateway}}</i>
							</div>
							<br>

							<div>
								IPv6 prefix length: <i>{{ipmask}}</i>
							</div>
							<br>
						</div>
						<div class="main" id="manual-ipv6" ng-show="ipv6manually=='manual-ipv6'">
							<strong>WARNING:</strong> Changing these settings may temporarily prevent communication!
							<form ng-submit="onSubmitIPv6()">
								<div>
									IPv6 Address: <input type="text" ng-model="ipaddress" name="address" placeholder="address" >
								</div>
								<br>

								<div>
									IPv6 Gateway: <input type="text" ng-model="ipgateway" name="gateway" placeholder="router" >
								</div>
								<br>

								<div>
									IPv6 Subnet Mask: <input type="text" ng-model="ipmask" name="netmask" placeholder="subnet mask" >
								</div>
								<br>
								<input type="submit" id="submit" class="btn btn-info" value="Update IPv6 Settings">
								<div ng-repeat="ip in ip6List">New {{ip.key}}: <i>{{ip.value}}</i></div>
							</form>
					</div>


						<hr>

				</div>
			</div>
		</div>
	</div>

</div>
</div>
