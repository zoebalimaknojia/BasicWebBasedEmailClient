/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.23
 * Generated at: 2012-01-04 18:09:24 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import user.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import java.io.*;
import java.util.*;
import javax.mail.Message.*;
import javax.mail.MessagingException.*;

public final class SentMail_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

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
	Folder folder = store.getFolder("Sent");	
	folder.open(Folder.READ_WRITE);
	//Message[] message = folder.getMessages();
	Message message = null;
	Message[] messages = folder.getMessages();
	


      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<html><head><title>Home Page</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<center>\r\n");
      out.write("<div id=\"displaymail\">\r\n");
      out.write("<table>\r\n");
      out.write("<tr>\r\n");
      out.write("\t<td valign=\"top\"></td>\r\n");
      out.write("\t<td valign=\"top\"><input type='button' onclick=\"checkUncheck('myForm', true);\" class='button2' value='Check All'/><input type='button' class='button2' onclick=\"checkUncheck('myForm', false);\" value='Uncheck All'/><input type=\"button\" class=\"button2\" name=\"delete\" onclick=\"javascript:deletesentselectedmailforever()\" value=\"Delete Forever\"/></td>\r\n");
      out.write("\t<td valign=\"top\"></td>\r\n");
      out.write("\t<td valign=\"top\"></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("\t<td></td>\r\n");
      out.write("\t<td>To</td>\r\n");
      out.write("\t<td>Subject</td>\r\n");
      out.write("\t<td>Date</td>\r\n");
      out.write(" </tr>\r\n");
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
for(i=MailIndex;i<messages.length;i++){
message=messages[i];
count++;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

List<String> toAddresses = new ArrayList<String>();
Address[] recipients = message.getRecipients(Message.RecipientType.TO);
for (Address address : recipients) {
toAddresses.add(address.toString());
}

      out.write("\r\n");
      out.write("\r\n");
      out.write("<tr>\r\n");
      out.write("\t<td WIDTH=\"1%\" bgcolor=\"#CFECEC\"><input type=\"checkbox\" name=\"mail\" value=\"");
      out.print(i);
      out.write("\" /></td>\r\n");
      out.write("\t<td WIDTH=\"10%\" bgcolor=\"#CFECEC\"><button name=\"Display1\" style=\"background-color:transparent;border:0px\" class=\"displayemailnormal\" Onclick=\"javascript:loadsentdisplaymessage(");
      out.print(i);
      out.write(')');
      out.write('"');
      out.write('>');
      out.print(toAddresses);
      out.write("</button></td>\r\n");
      out.write("\t<td WIDTH=\"10%\" bgcolor=\"#CFECEC\"><button name=\"Display2\" class=\"displayemailnormal\" style=\"background-color:transparent;border:0px\" Onclick=\"javascript:loadsentdisplaymessage(");
      out.print(i);
      out.write(')');
      out.write('"');
      out.write('>');
      out.print( message.getSubject() );
      out.write("</button></td>\r\n");
      out.write("\t<td WIDTH=\"10%\" bgcolor=\"#CFECEC\"><button name=\"Display3\" class=\"displayemailnormal\" style=\"background-color:transparent;border:0px\" Onclick=\"javascript:loadsentdisplaymessage(");
      out.print(i);
      out.write(')');
      out.write('"');
      out.write('>');
      out.print( message.getSentDate() );
      out.write("</button></td>\r\n");
      out.write("\r\n");
      out.write("</tr>\r\n");

if(count>=50) break;

 } 
      out.write("\r\n");
      out.write("\t<td><input type=\"button\" class=\"button\" name=\"first\" value=\"First\" onclick=\"javascript:loadFirstFifty('SentMail')\"/></td>\r\n");
      out.write("\t<td>\r\n");
      out.write("\t");
 
	if(lastMailIndex<messages.length)
	{
	
      out.write("\r\n");
      out.write("\t<input type=\"button\" class=\"button\" name=\"next\" value=\"Next\" onclick=\"javascript:loadnext('SentMail')\"/>\r\n");
      out.write("\t");

	} 
	
      out.write("\r\n");
      out.write("\t</td>\r\n");
      out.write("\t<td>\r\n");
      out.write("\t");
if(MailIndex>49){
      out.write("\r\n");
      out.write("\t<input type=\"button\" class=\"button\" name=\"previous\" value=\"Previous\" onclick=\"javascript:loadprevious('SentMail')\"/>\r\n");
      out.write("\t");
}
      out.write("\r\n");
      out.write("\t</td>\r\n");
      out.write("\t<td>\r\n");
      out.write("\t<input type=\"button\" class=\"button\" name=\"last\" value=\"Last\" onclick=\"javascript:loadLastFifty('SentMail')\"/>\r\n");
      out.write("\t</td>\r\n");
      out.write("</table>\r\n");
      out.write("</div>\r\n");
      out.write("</center>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
      out.write("\t");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
