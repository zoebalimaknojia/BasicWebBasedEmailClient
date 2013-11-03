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
	Folder folder = store.getFolder("Sent");	
	folder.open(Folder.READ_WRITE);
	Message[] message = folder.getMessages();
	int count = folder.getMessageCount();
	int unread = folder.getUnreadMessageCount();
	Integer messageno=Integer.parseInt(request.getParameter("messageno"));	
%>


<html><head><title>Home Page</title></head>
  <body>

<table width="940" bgcolor="#GSDFES">
<tr><td><input type="submit" name="button" class="button" onclick="javascript:deletesentmail(<%=messageno%>)" value="Delete Forever"/></td>
<tr><td>From : <%= message[messageno].getFrom()[0]  %></td></tr>
<tr><td>Subject : <%= message[messageno].getSubject() %></td></tr>
<tr><td>Date : <%= message[messageno].getSentDate() %></td></tr>
<tr><td>
<%
Multipart multipart=(Multipart)message[messageno].getContent();

for(int i=0;i<multipart.getCount();i++)
{
	BodyPart bodypart = multipart.getBodyPart(i);
	String disposition = bodypart.getDisposition();
	if(disposition != null && (disposition.equals(BodyPart.ATTACHMENT)))
	{
	String filename=bodypart.getFileName();
	FileWriter outputFileWriter=new FileWriter("C:\\nikki\\apache-tomcat-7.0.23-windows-x86\\apache-tomcat-7.0.23\\webapps\\Email\\download\\"+filename);
	InputStream inputStream=bodypart.getInputStream();
	int ii;
	while((ii=inputStream.read())!=-1)
	{
		outputFileWriter.write(ii);
	}
	outputFileWriter.close();
	String FilePath="/Email/download/"+filename;	
	%><br/><br/><br/><a href="<%=FilePath%>"><%=filename%></a>
	<%
	}else{
	InputStream stream = bodypart.getInputStream();
  	while (stream.available() != 0) {
	char str=((char)stream.read());
	if(str=='\n')
	{	%><br/><% continue;} %>
<%	if(str==' ')
	{	%>&nbsp;<% } %>
<%= str %>
<%
}//while over
}//else over
}//for over
%>
</td></tr>
</table>
<button class="button" onClick="javascript:loadforwardmessage(<%=messageno%>)" name="forward">Forward</button>
  </body>
</html>
	