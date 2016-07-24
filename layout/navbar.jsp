<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> 
				<span class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#/main"><img alt="Rain Modulator Dashboard" src="/img/solar-logo.png" class="animated bounce" id="logo-nav"></a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right" ng-controller="tabCtrl">
				<li ng-class="{'active':view_tab =='tab1'}"><a ng-click="changeTab('tab1')" href="#/main"><i class="fa fa-home"></i> Dashboard<span class="sr-only">(current)</span></a></li>
				<li ng-class="{'active':view_tab =='tab2'}"><a ng-click="changeTab('tab2')" href="#/map"><i class="fa fa-map-marker"></i> Location</a></li>
				<li ng-class="{'active':view_tab =='tab3'}"><a ng-click="changeTab('tab3')" href="#/week"><i class="fa fa-clock-o"></i> Programs</a></li>
		     	<li ng-class="{'active':view_tab =='tab5'}"><a ng-click="changeTab('tab5')" href="#/table"><i class="fa fa-list-ol"></i> Data</a></li>
				<li ng-class="{'active':view_tab =='tab7'}"><a ng-click="changeTab('tab7')" href="#/setting"><i class="fa fa-cog fa-spin"></i> Settings</a></li>
				<li><a href="../login.jsp?auth=false"><i class="fa fa-sign-out"></i>Log Out</a></li>
			</ul>
		</div>
	</div>
</nav>