import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

public class composemail extends HttpServlet
{
	public void service(HttpServletRequest req, HttpServletResponse res)throws ServletException,IOException
	{
	getServletContext().getRequestDispatcher("/composemail.jsp").forward(req,res);
	}
}
