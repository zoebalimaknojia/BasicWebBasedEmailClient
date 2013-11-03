<%@ page language="java" session="false" contentType="text/html" %>
<%
    String message=(String)request.getAttribute("message");
    if(message==null) {
        message="";
    }
%>
<html>
<head>
<title>Login Page</title>
<link rel="shortcut icon" href="/favicon.ico">
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
<%= message %><br/>
<center>
    <form id="login-form" action="userauth" method="post">
	<fieldset>
		<legend>Log in</legend>
			
			<label for="login">Server Address</label>
			<input type="text" id="host" name="host"/>
			<div class="clear"></div>
		
			<label for="login">Email</label>
			<input type="text" id="login" name="user"/>
			<div class="clear"></div>
			
			<label for="password">Password</label>
			<input type="password" id="password" name="pass"/>
			<div class="clear"></div>
					
			<br/>
			
			<input type="submit" style="margin: -15px 0 0 278px;" class="button" name="commit" value="Log in"/>	
	</fieldset>
    </form>
	</center><br/><br/><br/><br/>
	<FONT SIZE='4' FACE='courier' COLOR=blue><MARQUEE WIDTH=100% BEHAVIOR=ALTERNATE BGColor=yellow>BCA Fifth Semester Project</MARQUEE></FONT>
</body>
    
  
</html>
