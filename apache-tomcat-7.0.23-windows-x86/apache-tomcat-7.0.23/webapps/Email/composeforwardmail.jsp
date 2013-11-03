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
	Folder folder=info.getFolder();
	int count = folder.getMessageCount();
	int unread = folder.getUnreadMessageCount();
	Integer messageno=Integer.parseInt(request.getParameter("messageno"));
	Message[] message = folder.getMessages();
	//String subject=message[messageno].getSubject();

%>
<html><head>
<title>Home Page</title>
<link rel="stylesheet" type="text/css" href="styleforcomposemail.css" />
</head>
  <body>
<center>
<form action='ForwardMail' method='post' enctype='multipart/form-data'>
<input type="hidden" name="messageno" value="<%=messageno%>"/>
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
		<td><input type='text' name='sendto' class='Large' value='' /></b>separate addresses with commas</td>
	   </tr>
	   <tr height="15" bgcolor='#CFECEC'>
		<td><b>Subject : messagno<%=messageno%></td>
		<td><input type='text' name='subject' class='Large' value='FWD : <%=message[messageno].getSubject()%>' /></td>
	   </tr>
<% 
Multipart multipart=(Multipart)message[messageno].getContent();

for(int i=0;i<multipart.getCount();i++)
{
	BodyPart bodypart = multipart.getBodyPart(i);

	String disposition = bodypart.getDisposition();

	if(disposition != null && (disposition.equals(BodyPart.ATTACHMENT)))
	{
		String FileName=bodypart.getFileName();
		String FileDownloadPath="\\Email\\download\\"+FileName;
%>
		<tr>
		<td><b>Attachment : </b>
		<td><a href="<%=FileDownloadPath%>"><%=FileName%></a>
		
	<%}
	else
	{
%>
	   <tr bgcolor='#CFECEC'>
		
		<td colspan='2'><TEXTAREA rows='32' cols='135' name='data'><%=bodypart.getContent()%></TEXTAREA></td>
	   </tr>
<%} }%>
	   <tr height="15" bgcolor='#CFECEC'>
		<td colspan='2'><input type='submit' class='button' name='Submit' value='Submit'/>
				<input type='submit' class='button' name='Draft' value='Draft'/>
				<input type='reset' class='button' value='Reset' name='Reset'/>
				<input type='reset' class='button' value='Discard' name='Reset'/>
		</td>
	   </tr>
	</table>
	</form>
  </center>
  </body>
</html>
	