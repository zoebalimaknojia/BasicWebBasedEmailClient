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
	if(message[messageno].isSet(Flags.Flag.FLAGGED))
	{	message[messageno].setFlag(Flags.Flag.FLAGGED,false);	}
	message[messageno].setFlag(Flags.Flag.ANSWERED, true); // set the USER flag
	folder.close(true);
	store.close();
	
%>
<html>
<body>
Email Restored.
</body>
</html>