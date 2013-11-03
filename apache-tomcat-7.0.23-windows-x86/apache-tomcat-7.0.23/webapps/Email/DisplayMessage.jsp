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
	Message[] message = folder.getMessages();
	Integer messageno=Integer.parseInt(request.getParameter("messageno"));
	message[messageno].setFlag(Flags.Flag.SEEN,true);
%>

</script>

<html><head><title>Home Page</title></head>
  <body>

<table width="940" bgcolor="#GSDFES">
<tr><td><input type="submit" name="button" class="button" onclick="javascript:deletemail(<%=messageno%>)" value="Delete"/></td>
<tr><td>Message No : <%=messageno%></td></tr>
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

        //saveFile(bodypart.getFileName(),bodypart.getInputStream());
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
	BufferedReader br = new BufferedReader(new InputStreamReader(stream));
	String oneLine = "";
	while ( (oneLine = br.readLine()) !=  null )
    	{
		%><%=oneLine%><br/>
<%
}
}
}
%>
<br/><br/><br/>
</td></tr>
</table>
<button class="button" name="reply" onClick="javascript:loadreplymessage(<%=messageno%>)">Reply</button><button class="button" onClick="javascript:loadforwardmessage(<%=messageno%>)" name="forward">Forward</button>
  </body>
</html>

	