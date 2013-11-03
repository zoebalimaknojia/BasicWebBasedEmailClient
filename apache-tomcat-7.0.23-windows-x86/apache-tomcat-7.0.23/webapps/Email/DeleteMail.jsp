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
	if(message[messageno].isSet(Flags.Flag.DRAFT))
	{	message[messageno].setFlag(Flags.Flag.DRAFT,false);	}
	if(message[messageno].isSet(Flags.Flag.ANSWERED))
	{	message[messageno].setFlag(Flags.Flag.ANSWERED,false);	}
	message[messageno].setFlag(Flags.Flag.FLAGGED, true); // set the FLAGGED flag
	message[messageno].setFlag(Flags.Flag.SEEN, true);
	folder.close(true);
	store.close();
	
%>
<html>
<body>
Message<br/>
Your Mail has been deleted and sent to Trash.<br/>
If you Finally want to delete it from ur mail box....go to Trash and Delete it.!!
</body>
</html>