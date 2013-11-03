import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import user.*;

public class LogoutServlet extends HttpServlet {

	private Folder folder;
	private Store store;
	private URLName url;
	private userinfo info=new userinfo();
	
    public void service(HttpServletRequest req,HttpServletResponse res) throws IOException, ServletException {
        HttpSession session = req.getSession(false);
	try{

	session.invalidate();
	if (session != null)
	{
            session.invalidate();
        }

	Session sess = info.getSession();
	//sess.close();
	folder=info.getFolder();
	store=info.getStore();
	url=info.getUrl();


	if(store != null)
	{
		folder.close(false);
		store.close();
	}
	
        

        folder.close(false);
	store.close();
	info.setusername("");
	info.setpassword("");
	info.setsendfrom("");
	info.setHostname("");
	info.setMessageCount(0);
	info.setUnreadedCount(0);
	

	req.setAttribute("message","Session invalidated properly");
        getServletContext().getRequestDispatcher("/login.jsp").forward(req, res);


	}
	catch(Exception ex)
	{
		req.setAttribute("message","Session was not properly invalidated");
		getServletContext().getRequestDispatcher("/login.jsp").forward(req, res);
	}
    }
}