import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import user.*;

public class DeleteMail extends HttpServlet
{
	public void doPost(HttpServletRequest req, HttpServletResponse res)throws ServletException,IOException
	{
		HttpSession sessio = req.getSession(false);
	        	if (sessio == null) {
        	    		res.sendError(404, "Session expired");
	            	return;
	}
	userinfo info=(userinfo)sessio.getAttribute("userinfo");

	String Messageno = req.getParameter("messageno");	
try
{
	Folder folder=info.getFolder();
	if(folder!=null)
	{
	Message message = folder.getMessage(Integer.parseInt(Messageno));
	message.setFlag(Flags.Flag.DELETED, true);
	folder.appendMessages(new Message[] {message});
	}

		req.setAttribute("sendmessage","Message Deleted Successfully");
		getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);

}
catch (MessagingException mex)
{
         //mex.printStackTrace();
	req.setAttribute("sendmessage","Message Not Deleted");
	getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);
}   

}
}
	

