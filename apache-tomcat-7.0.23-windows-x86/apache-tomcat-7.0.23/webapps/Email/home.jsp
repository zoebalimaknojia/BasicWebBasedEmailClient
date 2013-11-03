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
	
%>


<html><head>
<title>Home Page</title>
<link rel="stylesheet" type="text/css" href="styleforhome.css" />

<script type="text/javascript">
function checkfields()
{
	to=document.getElementById("toaddress").value;
	if(to=="")
	{alert("Enter All Fields");
	return false;
	}
	subject=document.getElementById("subject").value;
	if(subject=="")
	{
	alert("Enter All Fields");
	return false;
	}
	data=document.getElementById("data").value;
	if(data=="")
	{
	alert("Enter All Fields");
	return false;
	}	
}

function discardmail()
{
loadhomepage();
}

function deletemailforever(i)
 {
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();

}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
xmlhttp.onreadystatechange=function()
	{
		
	if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById("tableview").innerHTML=xmlhttp.responseText;	
	}
	}
	
	
	xmlhttp.open("POST","DeleteMailForever.jsp?messageno="+i,true);
	xmlhttp.send();
}


function restoremail(i)
{
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();

}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
xmlhttp.onreadystatechange=function()
	{
	document.getElementById("tableview").innerHTML=xmlhttp.responseText;	
	if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById("tableview").innerHTML=xmlhttp.responseText;	
	}
	}
	
	xmlhttp.open("POST","RestoreMailMessage.jsp?messageno="+i,true);
	xmlhttp.send();
}
function restoreselectedmessages()
{
	var c = document.getElementsByTagName('input');
    for (var i = 0; i < c.length; i++) {
        if (c[i].type == 'checkbox') {
          if(  c[i].checked ){
		
		restoremail(c[i].value);
		}
        }
    }
}

function deletesentselectedmailforever(i)
{
	var c = document.getElementsByTagName('input');
    for (var i = 0; i < c.length; i++) {
        if (c[i].type == 'checkbox') {
          if(  c[i].checked ){
		deletesentmail(c[i].value);
		}
        }
    }
}

function deletesentmail(i)
{
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();

}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
xmlhttp.onreadystatechange=function()
	{
		
	if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById("tableview").innerHTML=xmlhttp.responseText;	
	}
	}
	
	xmlhttp.open("POST","DeleteSentMail.jsp?messageno="+i,true);
	xmlhttp.send();
}


function deletemail(i)
{
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();

}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
xmlhttp.onreadystatechange=function()
	{
		
	if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById("tableview").innerHTML=xmlhttp.responseText;	
		getUnreadMessagesNumber();
	}
	}
	
	xmlhttp.open("POST","DeleteMail.jsp?messageno="+i,true);
	xmlhttp.send();
}

function checkUncheck(form, setTo) {
    var c = document.getElementsByTagName('input');
    for (var i = 0; i < c.length; i++) {
        if (c[i].type == 'checkbox') {
            c[i].checked = setTo;
        }
    }
}


function deleteselectedmessages()
{
var c = document.getElementsByTagName('input');
    for (var i = 0; i < c.length; i++) {
        if (c[i].type == 'checkbox') {
          if(  c[i].checked ){
		deletemail(c[i].value);
		}
        }
    }
}

function deleteselectedmessagesforever()
{
var c = document.getElementsByTagName('input');
    for (var i = 0; i < c.length; i++) {
        if (c[i].type == 'checkbox') {
          if(  c[i].checked ){
		deletemailforever(c[i].value);
		}
        }
    }
}
function loadreplymessage(i)
{
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();
}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
xmlhttp.onreadystatechange=function()
	{
	document.getElementById("tableview").innerHTML=xmlhttp.responseText;
	if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById("tableview").innerHTML=xmlhttp.responseText;
	}
	}

xmlhttp.open("POST","composereplymail.jsp?messageno="+i,true);
xmlhttp.send();
}

function loadforwardmessage(i)
{
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();
}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
xmlhttp.onreadystatechange=function()
	{
	document.getElementById("tableview").innerHTML=xmlhttp.responseText;
	if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById("tableview").innerHTML=xmlhttp.responseText;
	}
	}

xmlhttp.open("POST","composeforwardmail.jsp?messageno="+i,true);
xmlhttp.send();
}
function loadsenddraftmessage(i)
{
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();
}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
xmlhttp.onreadystatechange=function()
	{
	document.getElementById("tableview").innerHTML=xmlhttp.responseText;
	if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById("tableview").innerHTML=xmlhttp.responseText;
	}
	}

xmlhttp.open("POST","composedraftmail.jsp?messageno="+i,true);
xmlhttp.send();
}
function loadhomepage()
{

if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();

}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
xmlhttp.onreadystatechange=function()
	{
	if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById("homepg").innerHTML=xmlhttp.responseText;
		getUnreadMessagesNumber();
	}
	}
xmlhttp.open("POST","home.jsp",true);
xmlhttp.send();
}
function loadcomposemail()
{

if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();

}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
xmlhttp.onreadystatechange=function()
	{
	if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById("tableview").innerHTML=xmlhttp.responseText;
	}
	}

xmlhttp.open("POST","composemail.jsp",true);
xmlhttp.send();
}
function loadlogout()
{

if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();
}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
xmlhttp.onreadystatechange=function()
	{
	if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById("homepg").innerHTML=xmlhttp.responseText;
		getUnreadMessagesNumber();
	}
	}
xmlhttp.open("POST","logout",true);
xmlhttp.send();
}
var MailIndex=0;

function loadRequestedPage(RequestedPage,MailIndexparam)
{

MailIndex=MailIndexparam;
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();	
}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
xmlhttp.onreadystatechange=function()
	{
	document.getElementById("tableview").innerHTML=xmlhttp.responseText;	
	if(xmlhttp.readyState==4 && xmlhttp.status==200)
	{
		document.getElementById("tableview").innerHTML=xmlhttp.responseText;
		getUnreadMessagesNumber();
	}
	}
xmlhttp.open("POST",RequestedPage+".jsp?MailIndex="+MailIndex,true);
xmlhttp.send();
}

function loadnext(requestedpage)
{
	MailIndex=MailIndex+50;
	loadRequestedPage(requestedpage,MailIndex);
}
function loadprevious(requestedpage)
{
	MailIndex=MailIndex-50;
	loadRequestedPage(requestedpage,MailIndex);
}
function loadFirstFifty(requestedpage)
{
	MailIndex=0;
	loadRequestedPage(requestedpage,MailIndex);
}
function loadLastFifty(requestedpage)
{
	MailIndex=-1;
	loadRequestedPage(requestedpage,MailIndex);
}
function loadsentdisplaymessage(i)
{
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();
}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
	xmlhttp.onreadystatechange=function()
	{
		document.getElementById("tableview").innerHTML=xmlhttp.responseText;
		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			document.getElementById("tableview").innerHTML=xmlhttp.responseText;			
		}
	}
	xmlhttp.open("POST","DisplaySentMessage.jsp?messageno="+i,true);
	xmlhttp.send();
}

function loaddisplaytrashmessage(i)
{
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();
}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
	xmlhttp.onreadystatechange=function()
	{
		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			
			document.getElementById("displaymail").innerHTML=xmlhttp.responseText;
		}
	}
	
	xmlhttp.open("POST","DisplayTrashMessage.jsp?messageno="+i,true);
	xmlhttp.send();
}


function loaddisplaymessage(i)
{
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();
}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
	xmlhttp.onreadystatechange=function()
	{
		document.getElementById("displaymail").innerHTML=xmlhttp.responseText;
		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{	
			document.getElementById("displaymail").innerHTML=xmlhttp.responseText;
			getUnreadMessagesNumber();
			
		}
	}
	
	xmlhttp.open("POST","DisplayMessage.jsp?messageno="+i,true);
	xmlhttp.send();
}

function loaddisplaysearchmessage(i)
{
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();
}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
	xmlhttp.onreadystatechange=function()
	{
		document.getElementById("displaymail").innerHTML=xmlhttp.responseText;
		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{	
			document.getElementById("displaymail").innerHTML=xmlhttp.responseText;
			getUnreadMessagesNumber();
			
		}
	}
	searchparameter=document.getElementById("Search").value;
	xmlhttp.open("POST","DisplaySearchMessage.jsp?parameter="+searchparameter+"&Messageno="+i,true);
	xmlhttp.send();
}




function getUnreadMessagesNumber()
{
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();
}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
	xmlhttp.onreadystatechange=function()
	{
		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			document.getElementById("InboxButton").value="Inbox("+xmlhttp.responseText.replace(/^\s+|\s+$/g, '')+")";	
		}
	}
	
	xmlhttp.open("POST","CalculateUnreaded.jsp",true);
	xmlhttp.send();	
}
function loaddisplaymessagedraft(i)
{

if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();
}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
	xmlhttp.onreadystatechange=function()
	{
		document.getElementById("displaymail").innerHTML=xmlhttp.responseText;
		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			
			document.getElementById("displaymail").innerHTML=xmlhttp.responseText;
		}
	}
	
	xmlhttp.open("POST","DisplayDraftMessage.jsp?messageno="+i,true);
	xmlhttp.send();
}
function searchmail()
{
searchparameter=document.getElementById("Search").value;
	if(searchparameter=="")
	return;
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();
}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
	xmlhttp.onreadystatechange=function()
	{
		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			document.getElementById("tableview").innerHTML=xmlhttp.responseText;
		}
	}
	
	xmlhttp.open("POST","SearchMessage.jsp?parameter="+searchparameter+"&MailIndex="+MailIndex,true);
	xmlhttp.send();
}

function displayElements(number)
{
if(number=='2')
{
	var fname=prompt("Please enter your name:","Your name");
}
if(window.XMLHttpRequest)
{
	xmlhttp=new XMLHttpRequest();
}
else
{
	xmlhttp=new ActiveXObject(Microsoft.XMLHTTP);	
}
	xmlhttp.onreadystatechange=function()
	{
		if(xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			
		}
	}
	xmlhttp.open("POST","CreateFolder.jsp?foldername="+fname,true);
	xmlhttp.send();
}   
</script>

</head>
<body onload=getUnreadMessagesNumber()>
<center>
<div id="homepg">
<div id="homepageview">
<table bgcolor="#B5EAAA" width="1200">
<tr>
	<td colspan="2" align="right"><b>Welcome <%= info.getusername() %></b></td>
	
</tr>


<tr bgcolor="#CFECEC">
	<td  colspan="2" >
 
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="1200" height="100">
<param name="movie" value="banner.swf" />
<param name="quality" value="high" />
<embed src="banner.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" play="true" type="application/x-shockwave-flash" height="100"></embed>
                </object>
 
</td>
</tr>
<tr bgcolor="#CFECEC" align="right">	
	<td colspan="2"><p align="left"><%= sendmessage %></p><input type="text" id="Search"/><input type="button" Onclick="javascript:searchmail()" class="button" id="search" name="search" value="Search"/><input type="button" name="Logout" class="button" Onclick="javascript:loadlogout()" value="Logout"/></td>
</tr>
<tr style="background-color:white" height="800">
	<td valign="top">	
	<ul>
			<li><button name="HomePage" class="button" Onclick="javascript:loadhomepage()">Home</button></li>
			<li><button name="ComposeMail" class="button" Onclick="javascript:loadcomposemail()">Compose Mail</button></li>
			<li><input type="button" name="InboxButton" id="InboxButton" class="button" Onclick="javascript:loadRequestedPage('inbox',0)" value="Inbox" /></li>
			<li><button name="SentMail" class="button" Onclick="javascript:loadRequestedPage('SentMail',0)">Sent Mail</button></li>
			<li><button name="Draft" class="button" Onclick="javascript:loadRequestedPage('draft',0)">Draft</button></li>
			<li><button name="Trash" class="button" Onclick="javascript:loadRequestedPage('Trash',0)">Trash</button></li>
			<li><button name="RestoredMail" class="button" Onclick="javascript:loadRequestedPage('RestoredMail',0)">Restored Mail</button></li>
			
	</ul>
        
	</td>
	<td valign="top" style="width:1100px;"><div id="tableview"><center><h1>Home</h1><br/><br/>
	</center></div></td>
</tr>
<tr bgcolor="#TAFESS"><td colspan="2">Copyright ©Maharaja Sayajirao University Of Baroda</td></tr>
</table>
</div>
</div>   
</center>
</body>
</html>
	