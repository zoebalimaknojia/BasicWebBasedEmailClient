import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import com.oreilly.servlet.multipart.*;
import user.*;

public class sendmail extends HttpServlet
{
	public void doPost(HttpServletRequest req, HttpServletResponse res)throws ServletException,IOException
	{
		HttpSession sessio = req.getSession(false);
	        	if (sessio == null) {
        	    		res.sendError(404, "Session expired");
	            	return;
	}
		userinfo info=(userinfo)sessio.getAttribute("userinfo");
try
{

		String recipents="";

		InternetAddress[] addressTo=null;

		InternetAddress[] addressTocc=null;
	
      		String cc="null";

		String Attachment="null";

		String contentType=req.getContentType();

		String submit=null;
		
		String subject=null;

		String draft=null;

		String data=null;

		String sendTo="";
		MultipartParser parser = new MultipartParser(req,100000000);
		com.oreilly.servlet.multipart.Part part;
		FilePart filePart = null;
		while((part = parser.readNextPart())!=null)
		{
			String paramName=part.getName();
				if(part.isParam())
				{
				ParamPart paramPart=(ParamPart)part;
				
				if(paramName.equals("sendto"))
				{recipents=(paramPart.getStringValue());}

				if(paramName.equals("cc"))
				{cc=(paramPart.getStringValue());}

				if(paramName.equals("subject"))
				{subject=paramPart.getStringValue();}

				if(paramName.equals("data"))
				{data=paramPart.getStringValue();}

				if(paramName.equals("Submit"))
				{submit=paramPart.getStringValue();}

				if(paramName.equals("Draft"))
				{draft=paramPart.getStringValue();}		

				}
				if(part.isFile())
				{
					filePart=(FilePart)part;
					String fileName=filePart.getFileName();
					Attachment=filePart.getFileName();

					String FilePath=filePart.getFilePath();
				if(fileName!=null)
				{	
					PrintWriter out = res.getWriter();
					File dir= new File("C:\\nikki\\upload\\");
					long size=filePart.writeTo(dir);
					out.flush();
				}//end if
			}//end if
		}//end while

if(recipents.contains(","))
{
	String[] to = recipents.split(",");

		addressTo = new InternetAddress[to.length];
		for (int i = 0; i < to.length; i++)
		{
	    		addressTo[i] = new InternetAddress(to[i]);
		}
}
else
{
addressTo = new InternetAddress[1];
for(int i=0;i<1;i++)
{
	addressTo[i]=new InternetAddress(recipents);
}
}

		// Get system properties
      		Properties props =System.getProperties();	

	      // Setup mail server
      		props.put("mail.smtp.host","127.0.0.1");


	      // Get the default Session object.
      Session session = Session.getInstance(props,null);	

if(submit!=null)
{


      try{
         // Create a default MimeMessage object.

         MimeMessage message = new MimeMessage(session);
         // Set From: header field of the header.

         message.setFrom(new InternetAddress(info.getusername()));

         // Set To: header field of the header.
         message.setRecipients(javax.mail.Message.RecipientType.TO, addressTo); 
	
         // Set Subject: header field
         message.setSubject(subject);

	//set Current date time
	message.setSentDate(new Date());

	//message.setText(data);

	Multipart multipart = new MimeMultipart();

	MimeBodyPart messageBodyPart = new MimeBodyPart();
	//setting the actual message in mime body part
	messageBodyPart.setText(data);
    	multipart.addBodyPart(messageBodyPart);

    // Part two is attachment
	
    	if(Attachment!=null)	
	{
	MimeBodyPart attachmentBodyPart = new MimeBodyPart();
	//attachmentBodyPart.setText("Attachment is not adding my file....i don't know what to do???");
   	String filename="c:\\nikki\\upload\\"+Attachment;
    DataSource source = new FileDataSource(filename);
    attachmentBodyPart.setDataHandler(new DataHandler(source));
    attachmentBodyPart.setFileName(Attachment);
    multipart.addBodyPart(attachmentBodyPart);
	}
	message.setContent(multipart);		
	Transport.send(message);
	Store store=info.getStore();
	Folder f = store.getFolder("Sent");
		// create "Sent" folder if it does not exist
	if (!f.exists()) f.create(Folder.HOLDS_MESSAGES);
		// add message to "Sent" folder
	f.appendMessages(new Message[] {message});
    	
	req.setAttribute("sendmessage","Message sent Successfully");
		getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);

	}catch (Exception mex) {
         
	req.setAttribute("sendmessage","Message Not Sent Error : "+mex.getMessage());
	getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);
      }//end catch

}//end if send

else
{

      try{
         // Create a default MimeMessage object.
         MimeMessage message = new MimeMessage(session);

         // Set From: header field of the header.
         message.setFrom(new InternetAddress(info.getusername()));


         // Set To: header field of the header.
         message.setRecipients(javax.mail.Message.RecipientType.TO, addressTo);

	

         // Set Subject: header field
         message.setSubject(subject);

	//set Current date time
	message.setSentDate(new Date());

         // Now set the actual message
         //message.setText(req.getParameter("data"));

	Multipart multipartsave=new MimeMultipart();
		
	MimeBodyPart messageBodyPartsave = new MimeBodyPart();
	//setting the actual message in mime body part
	messageBodyPartsave.setText(data);
    	multipartsave.addBodyPart(messageBodyPartsave);
	
    // Part two is attachment
	
    	if(Attachment!=null)	
	{
	MimeBodyPart attachmentBodyPartsave = new MimeBodyPart();
   	String filename="c:\\nikki\\upload\\"+Attachment;
    DataSource sourcesave = new FileDataSource(filename);
    attachmentBodyPartsave.setDataHandler(new DataHandler(sourcesave));
    attachmentBodyPartsave.setFileName(Attachment);
    multipartsave.addBodyPart(attachmentBodyPartsave);
	}
	message.setContent(multipartsave);
	message.saveChanges(); // implicit with send()
	Folder folder=info.getFolder();
	if(folder!=null)
	{
	message.setFlag(Flags.Flag.DRAFT, true);
	message.setFlag(Flags.Flag.SEEN, true);
	folder.appendMessages(new Message[] {message});
	}
	req.setAttribute("sendmessage","Message Saved Successfully");
		getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);

	}catch (MessagingException mex) {
         //mex.printStackTrace();
	req.setAttribute("sendmessage","Message Not Sent");
	getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);
      }//end catch
}//end if else


}//end top level try
catch(Exception Ex)
{
	req.setAttribute("sendmessage","Error Over Here :"+Ex.getMessage());
	getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);
}

}
}



	