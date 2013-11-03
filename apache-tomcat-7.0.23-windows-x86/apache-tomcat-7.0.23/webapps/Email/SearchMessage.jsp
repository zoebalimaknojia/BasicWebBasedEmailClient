<%@ page import="user.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="javax.mail.search.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.mail.Message.*" %>
<%@ page import="javax.mail.MessagingException.*" %>
<%
   int MailIndex=Integer.parseInt(request.getParameter("MailIndex"));
    if (session == null) {
        response.sendError(404, "Session expired");
        return;
    }
               userinfo info = (userinfo)session.getAttribute("userinfo");
	String searchterm=request.getParameter("parameter");
	Session sessio = info.getSession();
	Store store = sessio.getStore("imap");
        	store.connect(info.getHostname(),info.getusername(),info.getpassword());
	Folder folder = store.getFolder(info.getUrl());	
	folder.open(Folder.READ_WRITE);
	SearchTerm st = new OrTerm(new SubjectTerm(searchterm), new FromStringTerm(searchterm));
	//new RecipientStringTerm(searchterm),new BodyTerm(searchterm), new SentDateTerm(searchterm));
	Message[] messages = folder.search(st);
	Message message = null;
	//Message[] messages = folder.getMessages();

%>

<html><head><title>Home Page</title>

</head>
<body>
<center>
<div id="displaymail">
<table>

<tr>
	<td valign="top"></td>
	<td valign="top"><input type='button' onclick="checkUncheck('myForm', true);" class='button2' value='Check All'/><input type='button' class='button2' onclick="checkUncheck('myForm', false);" value='Uncheck All'/><input type="button" class="button2" name="delete" value="Delete"/></td>
	<td valign="top"></td>
	<td valign="top"></td>
</tr>
<tr>
	<td></td>
	<td>From</td>
	<td>Subject</td>
	<td>Date</td>
</tr>
<% 
if(MailIndex>messages.length)
MailIndex=messages.length;
if(MailIndex==-1)
{
int x=(int)(messages.length/50);
MailIndex=messages.length-(x*messages.length);
}

if(MailIndex<-1)
MailIndex=0;

int lastMailIndex=MailIndex+50;

if(lastMailIndex>messages.length)
lastMailIndex=messages.length;
int i;
int count=0;
for(i=MailIndex;i<messages.length;i++){
message=messages[i];
%><tr>
	<td WIDTH="10%" bgcolor="#FFFFF#"><input type="checkbox" name="mail" value="mail[i]" /></td>
	<td WIDTH="10%" bgcolor="#FFFFF#"><button name="Display1" style="background-color:transparent;border:0px" class="button1" Onclick="javascript:loaddisplaysearchmessage(<%= i %>)"><%= (InternetAddress.toString(message.getFrom())) %></button></td>
	<td WIDTH="10%" bgcolor="#FFFFF#"><button name="Display2" style="background-color:transparent;border:0px" class="button1" Onclick="javascript:loaddisplaysearchmessage(<%= i %>)"><%= message.getSubject() %></button></td>
	<td WIDTH="10%" bgcolor="#FFFFF#"><button name="Display3" style="background-color:transparent;border:0px" class="button1" Onclick="javascript:loaddisplaysearchmessage(<%= i %>)"><%= message.getSentDate() %></button></td>
</tr>
<%
if(i==50)
{
%>	<td></td>
	<td></td>
	<td></td>
	<td><input type="button" class="button" name="first" value="First"/><input type="button" class="button" name="next" value="Next"/><input type="button" class="button" name="previous" value="Previous"/><input t<input type="button" class="button" name="last" value="Last"/></td>
<%break;}
 } %>
</table>

</div>
</center>
</body>
</html>
	