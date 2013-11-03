<%@ page import="user.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
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
	//Message[] message = folder.getMessages();
	Message message = null;
	Message[] messages = folder.getMessages();
%>


<html><head><title>Home Page</title>
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
	<td>To</td>
	<td>Subject</td>
	<td>Date</td>
 </tr>
<% 
if(MailIndex>messages.length)
MailIndex=messages.length;

if(MailIndex==-1)
MailIndex=messages.length-50;

if(MailIndex<-1)
MailIndex=0;

int lastMailIndex=MailIndex+50;

if(lastMailIndex>messages.length)
lastMailIndex=messages.length;

int i;
int count=0;
for(i=messages.length-1;i>MailIndex;i--){
message=messages[i];
if((message.isSet(Flags.Flag.DRAFT))&&(!(message.isSet(Flags.Flag.FLAGGED)))&&(!(message.isSet(Flags.Flag.ANSWERED))))
{
count++;
%>


<%
List<String> toAddresses = new ArrayList<String>();
Address[] recipients = message.getRecipients(Message.RecipientType.TO);
for (Address address : recipients) {
toAddresses.add(address.toString());
}
%>

<tr>
	<td WIDTH="1%" bgcolor="#CFECEC"><input type="checkbox" name="mail[i]" value=<%=i%> /></td>
	<td WIDTH="10%" bgcolor="#CFECEC"><button name="Display1" style="background-color:transparent;border:0px" class="displayemailnormal" Onclick="javascript:loaddisplaymessagedraft(<%=i%>)"><%=toAddresses%></button></td>
	<td WIDTH="10%" bgcolor="#CFECEC"><button name="Display2" style="background-color:transparent;border:0px" class="displayemailnormal" Onclick="javascript:loaddisplaymessagedraft(<%=i%>)"><%= message.getSubject() %></button></td>
	<td WIDTH="10%" bgcolor="#CFECEC"><button name="Display3" style="background-color:transparent;border:0px" class="displayemailnormal" Onclick="javascript:loaddisplaymessagedraft(<%=i%>)"><%= message.getSentDate() %></button></td>

</tr>
<%
if(count>=50) break;
} } %>
	<td><input type="button" class="button" name="first" value="First" onclick="javascript:loadFirstFifty('draft')"/></td>
	<td>
	<% 
	if(lastMailIndex<messages.length)
	{
	%>
	<input type="button" class="button" name="next" value="Next" onclick="javascript:loadnext('draft')"/>
	<%
	} 
	%>
	</td>
	<td>
	<%if(MailIndex>49){%>
	<input type="button" class="button" name="previous" value="Previous" onclick="javascript:loadprevious('draft')"/>
	<%}%>
	</td>
	<td>
	<input type="button" class="button" name="last" value="Last" onclick="javascript:loadLastFifty('draft')"/>
	</td>
</table>

</div>
</center>
</body>
</html>
	