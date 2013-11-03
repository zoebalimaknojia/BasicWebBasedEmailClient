import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import user.*;

public class homeservlet extends HttpServlet
{
	public void service(HttpServletRequest req, HttpServletResponse res)throws ServletException,IOException
	{	
	getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);
	}
}
