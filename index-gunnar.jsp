<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.regulatedthings.controller.rainmodulator.CycleSprinklerHeadsProgram"%>
<%@page import="com.regulatedthings.controller.rainmodulator.AfterDarkRainProgram"%>
<%@page import="com.regulatedthings.controller.rainmodulator.RainModulatorResources"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.regulatedthings.controller.Program"%>
<%@page import="com.regulatedthings.controller.ProgramScheduler"%>
<%@page import="com.regulatedthings.controller.devices.Gizmo"%>
<%@page import="com.regulatedthings.controller.rainmodulator.LocalInfo"%>
<%@page import="com.regulatedthings.controller.rainmodulator.RainModulatorResources"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="refresh" content="300">
    <title>Rain Modulator</title>
     <style>
	  .BoxDiv {
		border: thin solid #000000;
		margin: 0 auto;
	  }
	 </style>
  </head>
  <body>
      <%
	    // Get the data from userPrograms running.
		String afterDark = "";
        String cycleNow = "";
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
			Set<Gizmo> relays = new HashSet<>();
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
        LocalInfo localInfo = new LocalInfo(RainModulatorResources.getApplicationGizmos()).initialize();
	    String weatherIcon = "icons/weather/250x250/na.png";
	    if (localInfo.isDaylight()) {
			weatherIcon = localInfo.isCloudPrecipitating() ? "icons/weather/250x250/rainy.png" : "icons/weather/250x250/sunny.png";
	    } else {
			weatherIcon = localInfo.isCloudPrecipitating() ? "icons/weather/250x250/rainy.png" : "icons/weather/250x250/moon.png";
	    }
	  %>


      <div class="BoxDiv" style="width:300px;height:500px:">
      <div align="center"><%= localInfo.getCity() %></div>

      <div align="center">
        <img src="<%= weatherIcon %>" alt="Weather" style="width:250px;height:250px"/>
      </div>
      <div style="text-align:center">
        <i>Current Weather<br/>
        <%= (int) (localInfo.getTemperature()*9)/5 + 32 %>F, <%= (int) localInfo.getHumidity() %>% humidity;  
      	<%= localInfo.isCloudPrecipitating() ? "raining" : "not raining" %>.</i><br/><br/>

		<%= afterDark %><br/>
		<%= cycleNow %><br/>
		<br/>
		<a href="<%= request.getRequestURL().toString() %>?cycleNow=true">Start Water Cycle</a><br>
          <a href="/LogoutController">Log out</a>
		</div>
      </div>
   </body>
</html>
