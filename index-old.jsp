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
<%@page import="javax.servlet.http.HttpServletResponse" %>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel='icon' type='/image/ico' href='/icons/favicon.ico'>

<!-- Bootstrap CSS -->
<link href="/css/bootstrap.min.css" rel="stylesheet">

<link href="/css/flat-button.css" rel="stylesheet">
<link href="http://netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<link href="/css/etabs.css" rel="stylesheet">

<!-- css for weekday toggle -->
<link href="/css/weekday-toggle.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/css/dashboard.css" rel="stylesheet">
<link href="/css/animate.css" rel="stylesheet">

<title>RainModulator Dashboard</title>

</head>

<body>

	<%
  	InetAddress inet = null;
  	double latitude = 0; 
  	double longitude = 0;
  	String ipDefault = "127.0.0.1";

  	String lats = request.getParameter("latitude");
  	String lons = request.getParameter("longitude");
  	String ip = request.getParameter("ip");
  	
  	String deviceName ="";
  	CloudInfoGatherer cig=null;
  	TimeZone tz = null;
  	DateFormat dateFormat = null;
  	Calendar up=null,down=null;
  	
  	try {
	  	deviceName = ServerConfig.getDefaultDeviceName();
	  	
	  	cig = CloudInfoGatherer.getInstance();
	  	
	  	if (ip != null && !"".equals(ip)) {
	  	cig.retrieveInformation(ip);
	  	inet = InetAddress.getByName(ip);
	  	ipDefault = ip;
		  } else {
		  
			  cig.retrieveInformation();
		  ip = cig.getIP();
		  inet = InetAddress.getByName(ip);
		  ipDefault = ip;
		}
		
		if (lats != null && !"".equals(lats)) {
		latitude = Double.parseDouble(lats);
		}
		
		if (lons != null && !"".equals(lons)) {
		longitude = Double.parseDouble(lons);
		}
		 
		if (inet != null && cig.getCurrentCoordinate() != null) {
		latitude = cig.getCurrentCoordinate().getLatitude();
		longitude = cig.getCurrentCoordinate().getLongitude();
		}
		
		tz = TimeZone.getTimeZone(cig.getTimeZone());
		
		dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss z");
		dateFormat.setTimeZone(tz);
		
		 up = SunUpDown.getSunRise(Calendar.getInstance(tz), cig.getCurrentCoordinate());
		 down = SunUpDown.getSunDown(Calendar.getInstance(tz), cig.getCurrentCoordinate());



  	} catch(Exception e) {
  		System.out.println("error in top portion");
  	}
	
	
	%>


	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
					data-target="#navbar" aria-expanded="false" aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Rain Modulator</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#"><i class="fa fa-home"></i> Dashboard</a></li>
					<li><a href="#settings"><i class="fa fa-cog"></i> Settings</a></li>
					<li><a href="#"><i class="fa fa-user"></i> Profile</a></li>
					<li><a href="#"><i class="fa fa-question-circle"></i> Help</a></li>
					<%--<li><a href="/LogoutControllerServlet" >Log Out</a></li>--%>
					<li><a href="../index.jsp?logout=true" >Log Out</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li class="active"><a href="#top">Dashboard <span class="sr-only">(current)</span></a></li>
					<li><a href="#sensor">Sensor Logs</a></li>
					<li><a href="#settings">Advanced Settings</a></li>
					<li><h1 class="page-header"></h1></li>
				</ul>
				<ul class="nav nav-sidebar">
					<li><a href="http://www.regulatedthings.com">Regulated Stuff</a></li>
					<li><a href="http://www.regulatedsolar.com">Regulated Solar</a></li>
					<li><a href="http://www.weather.com">Forecast From Weather.com</a></li>
					<li><a href="http://hadoop.apache.org/">Analytics With Hadoop</a></li>
					<li><h1 class="page-header"></h1></li>
				</ul>
				<ul class="nav nav-sidebar">
					<li><a href="<%= request.getRequestURL().toString() %>?cycleNow=true">Start Water Cycle</a></li>
					<li><a href="../index.jsp?logout=true" >Log Out</a></li>
					<li><h1 class="page-header"></h1></li>
				</ul>
			</div>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<div id="logo-container">				
					<img alt="Rain Modulator Dashboard" src="/img/solar-logo.png" class="animated bounce" id="logo-top">
				</div>
				<h1 class="page-header" id="top"></h1>

				<div class="row placeholders">
					<div id="forecast" class="col-md-6">

						<%
			    // Get the data from userPrograms running.
				String afterDark = "";
		        String cycleNow = "";
		        LocalInfo localInfo = null;
		        String weatherIcon = "";
		        double localTempFahrenheit = 0,localHumidity=0, currentTempFahrenheit=0;
		        boolean isPrecipitating = false;
		        
		        try{
				for (Program prog : RainModulatorResources.getUserPrograms().getScheduledPrograms()) {
					if (prog instanceof AfterDarkRainProgram) {
						afterDark = prog.getCurrentStateDescription();				
					}
					if (prog instanceof CycleSprinklerHeadsProgram) {
						cycleNow = prog.getCurrentStateDescription();				
					}
				}
				
		      	if ("true".equals(request.getParameter("cycleNow")) && "".equals(cycleNow)) {
		      		List<Gizmo> allGizmos = RainModulatorResources.getApplicationGizmos();
					//Set<Gizmo> relays = new HashSet<>();
					List<Gizmo> relays = new ArrayList<Gizmo>(1);
					for (Gizmo gizmo : allGizmos) {
						if (gizmo.getComponentName().equals("RainRelay")) {
							relays.add(gizmo);
						}
					}
					if (relays.size() > 0) {
					    CycleSprinklerHeadsProgram cshp = new CycleSprinklerHeadsProgram(relays, 60);
						RainModulatorResources.getUserPrograms().scheduleProgram(cshp);
					}
					response.sendRedirect(request.getRequestURL().toString());
		      	}
		      
		        // Get the weather data and correct icon.
		        localInfo = new LocalInfo(RainModulatorResources.getApplicationGizmos());
		        localInfo.initialize();
			    weatherIcon = "icons/weather/250x250/na.png";
			    
			    if (localInfo.isDaylight()) {
					weatherIcon = localInfo.isCloudPrecipitating() ? "icons/weather/250x250/rainy.png" : "icons/weather/250x250/sunny.png";
			    } else {
					weatherIcon = localInfo.isCloudPrecipitating() ? "icons/weather/250x250/rainy.png" : "icons/weather/250x250/moon.png";
			    }
			    
			    localTempFahrenheit = (localInfo.getTemperature()*9)/5 + 32;
			    localHumidity = localInfo.getHumidity();
			    currentTempFahrenheit = cig.getCurrentTemperature() - 273.15*9/5 +32;
			    	
			    isPrecipitating = cig.isPrecipitating();
			    
			    
		        }catch(Exception e){
		        	System.out.println("error in program scheduler");
		        }
			    
			  %>
						<div>
							<h2>Current Weather</h2>
							<div>
								<img id="weather-img" src="<%= weatherIcon %>" alt="Weather" />
							</div>
							<div style="text-align: center">
								<p>
									Sensor:
									<%= localTempFahrenheit %>F,
									<%= localHumidity %>% humidity;
									<%= localInfo.isCloudPrecipitating() ? "raining" : "not raining" %>.
								</p>
								<%= afterDark %>
								<%= cycleNow %>
								<p>
									Internet: Temperature:
									<%= (int) currentTempFahrenheit %>F Precipitation:
									<%= isPrecipitating ? "Yes" : "No"%>
								</p>

								<br>
								<!-- <input id="start-water-cycle-btn" type=submit class="RainRelaySwitch" value="Start Water Cycle" > -->
								<a href="<%= request.getRequestURL().toString() %>?cycleNow=true"
									id="start-water-cycle-btn" class="button">Start Water Cycle</a>
								<%-- <a href="<%= request.getRequestURL().toString() %>?cycleNow=true" >Start Water Cycle</a> --%>
							</div>
						</div>
					</div>
					<!-- END FORECAST -->

					<div id="map-div" class="col-md-6">
						<h2>Modulator Location</h2>
						<div id="map-actual"></div>
					</div>
					<!-- END MAP-->
				</div>
				<!--  END PLACEHOLDER -->


				<div class="row placeholders" id="button-panel">
					<div class="col-xs-6 col-sm-3 placeholder">
						<input id="station1-btn" type=submit class="button" value="OFF">
						<form name="input" method="get"></form>
						<h4>Front lawn</h4>
						<span class="text-muted">Zone 1</span>
					</div>
					<div class="col-xs-6 col-sm-3 placeholder">
						<input id="station2-btn" type=submit class="button" value="OFF">
						<form name="input" action="indexOliver2.jsp" method="get"></form>
						<h4>Side flowers</h4>
						<span class="text-muted">Zone 2</span>
					</div>
					<div class="col-xs-6 col-sm-3 placeholder">
						<input id="station3-btn" type=submit class="button" value="OFF">
						<form name="input" action="index-test.jsp" method="get"></form>
						<h4>Backyard lawn</h4>
						<span class="text-muted">Zone 3</span>
					</div>
					<div class="col-xs-6 col-sm-3 placeholder">
						<input id="station4-btn" type=submit class="button" value="OFF">
						<form name="input" action="index-test.jsp" method="get"></form>
						<h4>Backyard garden</h4>
						<span class="text-muted">Zone 4</span>
					</div>
					<div class="col-xs-6 col-sm-3 placeholder">
						<input id="station5-btn" type=submit class="button" value="OFF">
						<form name="input" method="get"></form>
						<h4>Dallas</h4>
						<span class="text-muted">Zone 5</span>
					</div>
					<div class="col-xs-6 col-sm-3 placeholder">
						<input id="station6-btn" type=submit class="button" value="OFF">
						<form name="input" action="indexOliver2.jsp" method="get"></form>
						<h4>Baton Rouge</h4>
						<span class="text-muted">Zone 6</span>
					</div>
					<div class="col-xs-6 col-sm-3 placeholder">
						<input id="station7-btn" type=submit class="button" value="OFF">
						<form name="input" action="index-test.jsp" method="get"></form>
						<h4>Reno</h4>
						<span class="text-muted">Zone 7</span>
					</div>
					<div class="col-xs-6 col-sm-3 placeholder">
						<input id="station8-btn" type=submit class="button" value="OFF">
						<form name="input" action="index-test.jsp" method="get"></form>
						<h4>Tampa</h4>
						<span class="text-muted">Zone 8</span>
					</div>
								</div>
				<!-- END ROW PLACEHOLDERS -->

				<div id= "log-div">
				<h1 class="page-header" id="sensor">Sensor Logs</h1>
					<div id="linechart_material"></div><!-- GCHART GOES HERE -->
				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>File #</th>
								<th>Date</th>
								<th>High temperature/humidity</th>
								<th>Low temperature/humidity</th>
								<th>Average temperature/humidity</th>
								<th>Precipitation</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1,001</td>
								<td>12/12/12</td>
								<td>99/40</td>
								<td>34/20</td>
								<td>70/30</td>
								<td>No</td>
							</tr>
							<tr>
								<td>1,302</td>
								<td>12/12/09</td>
								<td>102/33</td>
								<td>22/50</td>
								<td>65/39</td>
								<td>No</td>
							</tr>
							<tr>
								<td>1,203</td>
								<td>3/14/09</td>
								<td>60/40</td>
								<td>65/50</td>
								<td>70/30</td>
								<td>Yes</td>
							</tr>
							<tr>
								<td>1,701</td>
								<td>12/12/12</td>
								<td>99/40</td>
								<td>34/20</td>
								<td>70/30</td>
								<td>No</td>
							</tr>
							<tr>
								<td>1,602</td>
								<td>1/12/09</td>
								<td>102/33</td>
								<td>22/50</td>
								<td>65/39</td>
								<td>No</td>
							</tr>
							<tr>
								<td>1,903</td>
								<td>3/4/09</td>
								<td>50/20</td>
								<td>-1/-1</td>
								<td>50/20</td>
								<td>Yes</td>
							</tr>
							<tr>
								<td>1,501</td>
								<td>12/12/12</td>
								<td>99/40</td>
								<td>34/20</td>
								<td>70/30</td>
								<td>No</td>
							</tr>
							<tr>
								<td>102</td>
								<td>11/12/99</td>
								<td>102/33</td>
								<td>22/50</td>
								<td>65/39</td>
								<td>No</td>
							</tr>
							<tr>
								<td>100</td>
								<td>3/24/09</td>
								<td>99/99</td>
								<td>1/1</td>
								<td>50/50</td>
								<td>Yes</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- END table responsive-->
				</div>

				<div id="advanced">
					<div>
						<div>
							<%
				String detectedIp = "127.0.0.1";
				// Get the list of devices
				Collection<Device> devices = DeviceFactory.getDevices();
				String relayOnString = "" ,currentTime = "",sunUp="", sunDown="",countryCode="", city="", timeZoneShort="", timeZoneLong="";
				int relayOn = 0;
				double tempC=0,tempF=0;
				
				
			try{
				relayOnString = request.getParameter("relaystatus");
				
				if (relayOnString != null && !"".equals(relayOn)) {
					if (relayOnString.equals("off")) {
						relayOn = -1;
					} else {
						relayOn = Integer.decode(relayOnString);
					}
				}
				if (relayOn != 0) {
					for (Device dev : devices) {
						List<Gizmo> gizmos = dev.getGizmos();
						for (Gizmo giz : gizmos) {
							if (((relayOn == -1) || (giz.getGizmoReference() == relayOn)) && giz.getComponentName().equals("RainRelay")) {
							List<String> onList = new ArrayList<String>(1);
								if (relayOn == -1) {
								onList.add("0");
								} else {						
								onList.add("1");
								}
							((Actuator) giz).setValue(onList);
							}
						}
					}
					response.sendRedirect(request.getRequestURL().toString());
				}
			
				ip = request.getParameter("ip");
			
				cig = CloudInfoGatherer.getInstance();
			
				cig.retrieveInformation();
				detectedIp = cig.getIP();
			
				if (ip != null && !"".equals(ip)) {
					if (ip.indexOf(".") < 0) {
						ip = ip + ".dev.regulatedthings.com";
					}
					cig.retrieveInformation(ip);
					inet = InetAddress.getByName(ip);
					ipDefault = ip;
				} else {
					cig.retrieveInformation();
					ip = cig.getIP();
					inet = InetAddress.getByName(ip);
					ipDefault = ip;
				}
			
				if (inet != null && cig.getCurrentCoordinate() != null) {
					latitude = cig.getCurrentCoordinate().getLatitude();
					longitude = cig.getCurrentCoordinate().getLongitude();
				}
			
				tz = TimeZone.getTimeZone(cig.getTimeZone());
			
				dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss z");
				dateFormat.setTimeZone(tz);
			
				up = SunUpDown.getSunRise(Calendar.getInstance(tz), cig.getCurrentCoordinate());
				down = SunUpDown.getSunDown(Calendar.getInstance(tz), cig.getCurrentCoordinate());
				
				currentTime = dateFormat.format(Calendar.getInstance(tz).getTime());
				sunUp = dateFormat.format(up.getTime());
				sunDown = dateFormat.format(down.getTime());
				
				countryCode =  cig.getCountryCode();
				city = cig.getCity();
				timeZoneShort = tz.getDisplayName(false, TimeZone.SHORT);
				timeZoneLong = tz.getDisplayName(false, TimeZone.LONG);

				tempC = (cig.getCurrentTemperature() - 273.15);
				tempF = (cig.getCurrentTemperature() - 273.15 * 9/5+32);
				
                if(request.getParameter("logout").equals("true") ){
                    System.out.println("logout true");
                    request.getSession().invalidate();
                    //response.sendRedirect("/login.jsp");

                    // New location to be redirected
                    String site = new String("login.jsp");
                    response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", site);


                }

			}catch(Exception e){
				//System.out.println("error in 3rd portion.  " + e);
                e.printStackTrace();
			}
			

			%>
							<h1 class="page-header" id="settings">Rain Modulator Advanced Menu</h1>

							<div>
								<h3>Local network information</h3>

								<pre>Internet visible IP:  <%= detectedIp %></pre>

								<form name="input" action="<%= request.getRequestURL().toString() %>" method="get">
									Test IP host : <input type="text" name="ip" value="<%=ipDefault%>" />
								</form>
								<br>

								<h3>Local information derived from IP address.</h3>
								<h4>Sun up and down (calculated)</h4>
								<pre>
									Current time:         <%= currentTime%>
									Sun up:               <%= sunUp%>
									Sun down:             <%= sunDown%>
								</pre>

								<h4>Geo Information values:</h4>

								<pre>
									IP Host:              <%= ip %><br />
									Latitude / Longitude: <%= latitude %> / <%= longitude %>
									CountryCode:          <%= countryCode  %>
									City:                 <%= city %>
									TimeZone              <%= timeZoneShort  %> (<%= timeZoneLong %>)
								</pre>

								<h4>Current Weather Info</h4>

								<pre>
									Temperature:          <%=(int) tempC%>C / <%= (int) tempF %>F 
									Precipitation:        <%=isPrecipitating ? "Yes" : "No"%>
								</pre>

								<h3>Sensors &amp; Actuators:</h3>
								<% if (devices.size() < 1) { %>
								<h4>No Devices found</h4>
								<% } else { %>
								&nbsp;&nbsp;&nbsp;&nbsp;Devices:
								<% } %>
								<% for (Device dev : devices) { %>
								<form action="<%= request.getRequestURL().toString() %>" method="get">
									<pre>
										Type:                 <%= dev.getDeviceType() %>
										Version:              <%= dev.getDeviceVersion() %>
										<%
										List<Gizmo> gizmos = dev.getGizmos();
										if (gizmos == null || gizmos.size() < 1) {
										%>
										No Gizmos found
										<% } else {
										for (Gizmo giz : gizmos) { 
										if ("RainRelay".equals(giz.getComponentName())) { %>
										<%= giz.getComponentName() %> (<%= giz.getValueType().getDescription() %>)       
										<input type="radio" name="relaystatus" onclick="this.form.submit();"
											value="<%= giz.getGizmoReference() %>"
											<%= ((Boolean) giz.getMeasurement().getValue()) == true ? "checked" : "" %> /><%= giz.getGizmoReference() %>
										<% } else { %> 
										<%= giz.getComponentName() %> (<%= giz.getValueType().getDescription() %>) <%= giz.getMeasurement().getValue() %> <%= giz.getValueType().getSIUnit() %>
										<% } } } %>	
									</pre>
									Clear Relays <input type="radio" name="relaystatus" onclick="this.form.submit();"
										value="off">
								</form>
								<% } %>
							</div>
						</div>
						<!--  end geo-info div-->
					</div>
				</div>
				<!-- end advanced-->
			</div>
			<!--  END col-sm9 -->

		</div>
		<!-- END ROW -->
	</div>
	<!-- END CONTAINER  -->

	<!-- including footer.jsp which  -->
	<jsp:include page="/layout/footer.jsp"></jsp:include>

	<!-- Bootstrap core JavaScript xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -->
	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script> -->
	<script src="/js/jquery-2.1.1.min.js"></script>
	<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.1.js"></script>  -->

	<script src="/js/bootstrap.min.js"></script>
	<%--<script src="/js/docs.min.js"></script>--%>

	<!--google map api -->
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>


	<script src="/js/button-logic.js" type="text/javascript"></script>

	<!-- START GMAP LOGIC -->
	<script>
			var myLatlng = new google.maps.LatLng(<%= latitude %>,<%= longitude %>);
			var mapOptions = {
				zoom: 12,
				center: myLatlng,
				disableDefaultUI: true,
				disableDoubleClickZoom: true
			}
			var map = new google.maps.Map(document.getElementById("map-actual"), mapOptions);
			
			// To add the marker to the map, use the 'map' property
			var marker = new google.maps.Marker({
				position: myLatlng,
				map: map,
				draggable:true,
			    animation: google.maps.Animation.DROP,
				title:"Map marker for rainmod"
		});

		var pos = "Original Location:" + marker.getPosition().toString();

		var infoWindow = new google.maps.InfoWindow({
			content: "Drag to target location"
		});

		infoWindow.open(map, marker);
		
		google.maps.event.addListener(marker, 'mouseout', function() {
			infoWindow.close();
		});
		
		google.maps.event.addListener(marker, 'mouseover', function() {
			mouseDrag(map, marker);
		});
		
		function mouseDrag(map, marker) {
			infoWindow.setContent("This is your rainmodulator's location!");
			infoWindow.open(map, marker);

			//display current lat/long of marker
			/* alert(marker.getPosition()); */

			if (marker.getAnimation() != null) {
				marker.setAnimation(null);
			}
			else {
				marker.setAnimation(google.maps.Animation.BOUNCE);
			}
		}
		
	</script> <!-- END GMAP LOGIC -->
	
</body>
</html>
