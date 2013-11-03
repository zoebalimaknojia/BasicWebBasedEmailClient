import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import user.*;

public class userauth1 extends HttpServlet
{
	protected Session session;
	userinfo info = null;
	
	private String protocol = "imap";
	private String mbox = "INBOX";	
	private URLName url;
	private Folder folder;
	private Store store;


	
	private String user;
	private String pass;
	private String host;
	public void doPost(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException
	{	
		
		user = req.getParameter("user");
		pass = req.getParameter("pass");
		host = req.getParameter("host");
		if(user=="" || user==null || pass=="" || pass==null || host=="" || host==null)
		{	
		req.setAttribute("message","invalid arguments");
			getServletContext().getRequestDispatcher("/login.jsp").forward(req,res);
			return;
		}
		else
		{
			String logincheck=connect(host,user,pass);				
			if(logincheck.equals("unsuccessful"))
			{
				req.setAttribute("message","invalid login/password");
				getServletContext().getRequestDispatcher("/login.jsp").forward(req,res);
				return;
			}
			HttpSession session = req.getSession(false);
			if(session != null)
			{
				session.invalidate();
			}
		session = req.getSession();
		session.setAttribute("userinfo",info);
		getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);
		}
	}
	public String connect(String hostname,String username,String password)
	{
		try{
		    url = new URLName(protocol, hostname, -1, mbox, username, password);
		    Properties props = new Properties();
		    session = Session.getDefaultInstance(props, null);
		    Store store = session.getStore(url);
            	    store.connect(hostname, username, password);
		    folder = store.getFolder(url);	
		    folder.open(Folder.READ_WRITE);
		    info=new userinfo();
		    info.setUrl(url);
 		    info.setusername(user);
		    info.setpassword(pass);
		    info.setsendfrom(user);
		    info.setStore(store);
		    info.setSession(session);
		    info.setHostname(hostname);
		    info.setFolder(folder);
		     return "successful";
		}
		catch(Exception ex)
		{
			return "unsuccessful";
		}

	}
}
		
		
		
		
		