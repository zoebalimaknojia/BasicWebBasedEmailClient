<%@ page import="user.*" %><%@ page import="javax.mail.*" %><%@ page import="javax.mail.internet.*"%><%@ page import="javax.activation.*" %><%@ page import="java.io.*" %>
<%
	userinfo info = (userinfo)session.getAttribute("userinfo");
	Folder folder=info.getFolder();
	Folder[] listfolders = info.getStore().getDefaultFolder().list();
	int unreadedmessages=folder.getUnreadMessageCount();
	out.println(unreadedmessages);
%>