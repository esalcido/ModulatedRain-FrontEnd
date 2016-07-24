<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="javax.servlet.ServletException"%>

<!DOCTYPE HTML>
<html>
<head>

<link rel='icon' type='/image/ico' href='/icons/favicon.ico'>

<!-- Bootstrap core CSS -->
<link href="/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/css/signin.css" rel="stylesheet">
<link href="/css/animate.css" rel="stylesheet">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Rain Modulator Login</title>
</head>

<body>
	<%
		String loginStatus = "Please Log In";
		if ("try_again".equals(request.getParameter("auth"))) {
			loginStatus = "Invalid Credentials Please Try Again";
		} else if ("false".equals(request.getParameter("auth"))) {
			//user logged out -> invalidate session
			HttpSession hs = request.getSession(false);
			hs.invalidate();
			loginStatus = "Welcome Back";
		}
	%>

	<div class="form-signin-container">
		<div id="logo-container">
			<img alt="Rain Modulator Login" src="/img/solar-logo.png" class="animated bounce" id="logo-top">
			<h3><%=loginStatus%></h3>
		</div>
		<form action="j_security_check" method="POST">
			<input type="text" id="j_username" class="form-input" name="j_username" placeholder="Enter your Username" required="required" /> 
				<input type="password"
				id="j_password" class="form-input" name="j_password" placeholder="Enter your Password"
				required="required" />
			<button class="btn btn-lg btn-primary btn-block" type="submit"> Sign In <i class="fa fa-sign-in"></i></button>
		</form>
	</div>

</body>
</html>

