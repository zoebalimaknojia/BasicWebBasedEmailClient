/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.23
 * Generated at: 2012-01-04 16:25:42 UTC
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
import javax.mail.Message.*;
import javax.mail.MessagingException.*;

public final class Trash_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\t<td valign=\"top\"><input type='button' onclick=\"checkUncheck('myForm', true);\" class='button2' value='Check All'/><input type='button' class='button2' onclick=\"checkUncheck('myForm', false);\" value='Uncheck All'/><input type=\"button\" class=\"button2\" onclick=\"javascript:deleteselectedmessagesforever()\" name=\"deleteforever\" value=\"Delete Forever\"/><input type=\"button\" class=\"button2\" onclick=\"javascript:restoreselectedmessages()\" name=\"restore\" value=\"Restore\"/></td>\r\n");
      out.write("\t<td valign=\"top\"></td>\r\n");
      out.write("\t<td valign=\"top\"></td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr>\r\n");
      out.write("\t<td></td>\r\n");
      out.write("\t<td>From</td>\r\n");
      out.write("\t<td>Subject</td>\r\n");
      out.write("\t<td>Date</td>\r\n");
      out.write(" </tr>\r\n");
 
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
for(i=messages.length-1;i>MailIndex;i--){
message=messages[i];
if ((message.isSet(Flags.Flag.FLAGGED)))
{
count++;

      out.write("\r\n");
      out.write("\r\n");
      out.write("<tr>\r\n");
      out.write("\t<td WIDTH=\"1%\" bgcolor=\"#CFECEC\"><input type=\"checkbox\" name=\"mail\" value=\"");
      out.print(i);
      out.write("\"/></td>\r\n");
      out.write("\t<td WIDTH=\"10%\" bgcolor=\"#CFECEC\"><button name=\"Display1\" style=\"background-color:transparent;border:0px\" class=\"displayemailnormal\" Onclick=\"javascript:loaddisplaytrashmessage(");
      out.print(i);
      out.write(')');
      out.write('"');
      out.write('>');
      out.print( (InternetAddress.toString(message.getFrom())) );
      out.write(' ');
      out.write(' ');
      out.print(i);
      out.write("</button></td>\r\n");
      out.write("\t<td WIDTH=\"10%\" bgcolor=\"#CFECEC\"><button name=\"Display2\" style=\"background-color:transparent;border:0px\" class=\"displayemailnormal\" Onclick=\"javascript:loaddisplaytrashmessage(");
      out.print(i);
      out.write(')');
      out.write('"');
      out.write('>');
      out.print( message.getSubject());
      out.print(count);
      out.write("</button></td>\r\n");
      out.write("\t<td WIDTH=\"10%\" bgcolor=\"#CFECEC\"><button name=\"Display3\" style=\"background-color:transparent;border:0px\" class=\"displayemailnormal\" Onclick=\"javascript:loaddisplaytrashmessage(");
      out.print(i);
      out.write(')');
      out.write('"');
      out.write('>');
      out.print( message.getSentDate() );
      out.write("</button></td>\r\n");
      out.write("\r\n");
      out.write("</tr>\r\n");

if(count>=50) break;

}  } 
      out.write("\r\n");
      out.write("\t<td><input type=\"button\" class=\"button\" name=\"first\" value=\"First\" onclick=\"javascript:loadFirstFifty('Trash')\"/></td>\r\n");
      out.write("\t<td>\r\n");
      out.write("\t");
 
	if(lastMailIndex<messages.length)
	{
	
      out.write("\r\n");
      out.write("\t<input type=\"button\" class=\"button\" name=\"next\" value=\"Next\" onclick=\"javascript:loadnext('Trash')\"/>\r\n");
      out.write("\t");

	} 
	
      out.write("\r\n");
      out.write("\t</td>\r\n");
      out.write("\t<td>\r\n");
      out.write("\t");
if(MailIndex>49){
      out.write("\r\n");
      out.write("\t<input type=\"button\" class=\"button\" name=\"previous\" value=\"Previous\" onclick=\"javascript:loadprevious('Trash')\"/>\r\n");
      out.write("\t");
}
      out.write("\r\n");
      out.write("\t</td>\r\n");
      out.write("\t<td>\r\n");
      out.write("\t<input type=\"button\" class=\"button\" name=\"last\" value=\"Last\" onclick=\"javascript:loadLastFifty('Trash')\"/>\r\n");
      out.write("\t</td>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
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
