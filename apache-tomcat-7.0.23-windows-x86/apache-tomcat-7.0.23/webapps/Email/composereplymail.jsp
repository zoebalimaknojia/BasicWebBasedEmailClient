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

	Session sessio = info.getSession();
	Store store = sessio.getStore("imap");
        store.connect(info.getHostname(),info.getusername(),info.getpassword());
	Folder folder = store.getFolder(info.getUrl());	
	folder.open(Folder.READ_WRITE);
	Integer messageno=Integer.parseInt(request.getParameter("messageno"));
	Message[] message = folder.getMessages();
	String subject=message[messageno].getSubject();
	

%>
<html><head>
<title>Home Page</title>
<link rel="stylesheet" type="text/css" href="styleforcomposemail.css" />
</head>
  <body>
<center>
<form action='ReplyMail' method='post' enctype='multipart/form-data'>
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
		<td><input type='text' name='sendto' class='Large' value='<%= message[messageno].getFrom()[0]  %>' /></b>separate addresses with commas</td>
	   </tr>
	   <tr height="15" bgcolor='#CFECEC'>
		<td><b>Subject :</td>
		<td><input type='text' name='subject' class='Large' value='Re : <%=subject%>' /></td>
	   </tr>
	   <tr height="15" bgcolor='#CFECEC'>
		<td><b>Attachment :</td>
		<td><input type='file' name='attachment'/></td>
	   </tr>
<% 
Multipart multipart=(Multipart)message[messageno].getContent();

for(int i=0;i<multipart.getCount();i++)
{
	BodyPart bodypart = multipart.getBodyPart(i);

	String disposition = bodypart.getDisposition();

	if(disposition != null && (disposition.equals(BodyPart.ATTACHMENT)))
	{
	}
	else
	{
%>
	   <tr bgcolor='#CFECEC'>
		<td colspan='2'><textarea id="textAreaa" rows='32' cols='135' name='data'><%=bodypart.getContent()%></textarea></td>
	   </tr>
	<%} }%>
	   <tr height="15" bgcolor='#CFECEC'>
		<td colspan='2'><input type='submit' class='button' name='Submit' value='Submit'/>
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
	