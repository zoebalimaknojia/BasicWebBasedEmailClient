<%@ page import="user.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="java.io.*" %>
<%
	String sendmessage=(String)request.getAttribute("sendmessage");
	if(sendmessage==null)
	{
		sendmessage="";
	}

    if (session == null) {
        response.sendError(404, "Session expired");
        return;
    }
	userinfo info = (userinfo)session.getAttribute("userinfo");
	Folder folder=info.getFolder();
	int count = folder.getMessageCount();
	int unread = folder.getUnreadMessageCount();

%>


<html><head>
<title>Home Page</title>
<link rel="stylesheet" type="text/css" href="styleforcomposemail.css" />
</head>
  <body>
<center>
<form action='sendmail' method='post' enctype='multipart/form-data'>
	<table>
	   <tr bgcolor='#800517'>
		<td colspan='2'><b><h3><center>Compose Your Mail Here</center></h3></b></td>
	   </tr>
	   <tr height="15" bgcolor='#CFECEC'>
		<td><b>From :</td>
		<td><label for="login"><%= info.getsendfrom() %></label></td>
	   </tr>
	   <tr height="15" bgcolor='#CFECEC'>
		<td><b>TO :</td>
		<td><input type='text' id="toaddress" name='sendto' /></b>separate addresses with commas</td>
	   </tr>
	   <tr height="15" bgcolor='#CFECEC'>
		<td><b>Subject :</td>
		<td><input type='text' id="subject" name='subject'  /></td>
	   </tr>
	   <tr height="15" bgcolor='#CFECEC'>
		<td><b 	>Attachment :</td>
		<td><input type='file' name='attachment' /></b></td>
	   </tr>
	   <tr bgcolor='#CFECEC'>
		<td colspan='2'><TEXTAREA rows='35' id="data" cols='125' name='data'></TEXTAREA></td>
	   </tr>
	   <tr height="15" bgcolor='#CFECEC'>
		<td colspan='2'><input type='submit' class='button' name='Submit' Onclick="javascript:checkfields()" value='Submit'/>
				<input type='submit' class='button' name='Draft' value='Draft'/>
				<input type='reset' class='button' value='Reset' name='Reset'/>
				<input type='reset' class='button' value='Discard' Onclick="javascript:discardmail()" name='Reset'/>
		</td>
	   </tr>
	</table>
	</form>
  </center>
  </body>
</html>
	