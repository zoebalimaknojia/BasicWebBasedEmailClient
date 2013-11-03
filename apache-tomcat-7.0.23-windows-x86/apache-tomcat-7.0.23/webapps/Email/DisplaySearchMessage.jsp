<%@ page import="user.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.search.*" %>
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
	Integer messageno=Integer.parseInt(request.getParameter("Messageno"));
	String searchterm=request.getParameter("parameter");
	Session sessio = info.getSession();
	Store store = sessio.getStore("imap");
        	store.connect(info.getHostname(),info.getusername(),info.getpassword());
	Folder folder = store.getFolder(info.getUrl());	
	folder.open(Folder.READ_WRITE);
	SearchTerm st = new OrTerm(new SubjectTerm(searchterm), new FromStringTerm(searchterm));
	//new RecipientStringTerm(searchterm),new BodyTerm(searchterm), new SentDateTerm(searchterm));
	Message[] messages = folder.search(st);
	Message message = messages[messageno];
%>

<html><head><title>Home Page</title></head>
  <body>

<table width="940" bgcolor="#GSDFES">
<tr><td><input type="submit" name="button" class="button" onclick="javascript:deletemail(<%=messageno%>)" value="Delete"/></td>
<tr><td>Message No : <%=messageno%></td></tr>
<tr><td>From : <%= message.getFrom()[0]  %></td></tr>
<tr><td>Subject : <%= message.getSubject() %></td></tr>
<tr><td>Date : <%= message.getSentDate() %></td></tr>
<tr><td>
<%
Multipart multipart=(Multipart)message.getContent();
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

	