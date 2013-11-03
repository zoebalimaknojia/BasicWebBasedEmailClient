<%@ page import="user.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.mail.Message.*" %>
<%@ page import="javax.mail.MessagingException.*" %>
<%
	int MailIndex=Integer.parseInt(request.getParameter("MailIndex"));	
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
	Message message = null;
	Message[] messages = folder.getMessages();
%>

<html><head><title>Home Page</title>

<script type="text/javascript">

</script>

</head>
<body>
<center>
<div id="displaymail">
<table>

<tr>
	<td valign="top"></td>
	<td valign="top"><input type='button' onclick="checkUncheck('myForm', true);" class='button2' value='Check All'/><input type='button' class='button2' onclick="checkUncheck('myForm', false);" value='Uncheck All'/><input type="button" class="button2" name="delete" onclick="javascript:deleteselectedmessages()" value="Delete"/></td>
	<td valign="top"></td>
	<td valign="top"></td>
</tr>
<tr>
	
	<td></td>
	<td>From</td>
	<td>Subject</td>
	<td>Date</td>
	
 </tr>

<% for(int i=messages.length-1;i>0;i--){
message=messages[i];
if ((!(message.isSet(Flags.Flag.DRAFT))) && (!(message.isSet(Flags.Flag.DELETED))) && (!(message.isSet(Flags.Flag.FLAGGED))) && (!(message.isSet(Flags.Flag.ANSWERED))))
{
if(message.isSet(Flags.Flag.SEEN))
{
%>
<tr>
	<td  bgcolor="#CFECEC"><input type="checkbox" name="mail" value="<%=i%>" /></td>
	<td  bgcolor="#CFECEC"><button name="Display1" style="background-color:transparent;border:0px" class="displayemailnormal" Onclick="javascript:loaddisplaymessage(<%=i%>)"><%= (InternetAddress.toString(message.getFrom())) %><br/>Message No : <%=message.getMessageNumber()%></button></td>
	<td  bgcolor="#CFECEC"><button name="Display2" style="background-color:transparent;border:0px" class="displayemailnormal" Onclick="javascript:loaddisplaymessage(<%=i%>)"><%= message.getSubject() %></button><%=i%></td>
	<td  bgcolor="#CFECEC"><button name="Display3" style="background-color:transparent;border:0px" class="displayemailnormal" Onclick="javascript:loaddisplaymessage(<%=i%>)"><%= message.getSentDate() %></button></td>
</tr>
<%
}
else
{
%>
<tr>
	<td bgcolor="#C8BBBE"><input type="checkbox" name="mail" value="<%=i%>" /></td>
	<td bgcolor="#C8BBBE"><button name="Display1" style="background-color:transparent;border:0px" class="displayemailbold" Onclick="javascript:loaddisplaymessage(<%=i%>)"><%= (InternetAddress.toString(message.getFrom())) %><br/>Message No : <%=message.getMessageNumber()%></button></td>
	<td bgcolor="#C8BBBE"><button name="Display2" style="background-color:transparent;border:0px" class="displayemailbold" Onclick="javascript:loaddisplaymessage(<%=i%>)"><%= message.getSubject() %></button><%=i%></td>
	<td bgcolor="#C8BBBE"><button name="Display3" style="background-color:transparent;border:0px" class="displayemailbold" Onclick="javascript:loaddisplaymessage(<%=i%>)"><%= message.getSentDate() %></button></td>
</tr>

<%
}

} } %>

	
</table>
</div>
</center>
</body>
</html>
	