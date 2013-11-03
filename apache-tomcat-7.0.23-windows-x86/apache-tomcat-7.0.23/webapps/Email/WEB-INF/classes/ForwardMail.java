import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import com.oreilly.servlet.multipart.*;
import user.*;

public class ForwardMail extends HttpServlet
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
		String FileStoredPath="";

		String recipents="null";

		InternetAddress[] addressTo=null;

	
      		String cc="null";

		String Attachment="null";

		String contentType=req.getContentType();

		String submit=null;
		
		String subject=null;

		String draft=null;

		String data=null;

		int messageno=0;

		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		out.println("<html><body>Outside Conditions<br/>");
		String sendTo="";
		out.println("<br/>Content Type : "+contentType+"<br/>");
    		out.println("1");

		MultipartParser parser = new MultipartParser(req,100000000);
		com.oreilly.servlet.multipart.Part part;
		FilePart filePart = null;
		while((part = parser.readNextPart())!=null)
		{
			String paramName=part.getName();
			out.println("<br/>"+paramName);

				if(part.isParam())
				{
				ParamPart paramPart=(ParamPart)part;

				
				if(paramName.equals("messageno"))
				{messageno=Integer.parseInt(paramPart.getStringValue());}
				
				if(paramName.equals("sendto"))
				{recipents=(paramPart.getStringValue());}

				if(paramName.equals("subject"))
				{subject=paramPart.getStringValue();}

				if(paramName.equals("data"))
				{data=paramPart.getStringValue();}

				if(paramName.equals("Submit"))
				{submit=paramPart.getStringValue();}

				if(paramName.equals("Draft"))
				{draft=paramPart.getStringValue();}		

				out.println(paramPart.getStringValue());
				}
				if(part.isFile())
				{
					filePart=(FilePart)part;
					String fileName=filePart.getFileName();
					Attachment=filePart.getFileName();

					String FilePath=filePart.getFilePath();
					out.println("<br/><br/>File Name is : "+fileName+"<br/><br/>");
					out.println("<br/><br/>File Path is : "+FilePath+"<br/><br/>");
				if(fileName!=null)
				{	
					//PrintWriter out = res.getWriter();
					File dir= new File("C:\\nikki\\upload\\");
					long size=filePart.writeTo(dir);
					out.flush();
				}//end if
			}//end if
		}//end while

out.println("<br/>2");

if(recipents.contains(","))
{
	String[] to = recipents.split(",");

		addressTo = new InternetAddress[to.length];
		for (int i = 0; i < to.length; i++)
		{
			out.println("<br/>3");
	    		addressTo[i] = new InternetAddress(to[i]);
			out.println("<br/>no of recipients : " +i);
		}
}
else
{
addressTo = new InternetAddress[1];
for(int i=0;i<1;i++)
{
	out.println("<br/>4");
	addressTo[i]=new InternetAddress(recipents);
	out.println(addressTo[i]);
}
}

		
		out.println("<br/> Setting System Properites <br/>");

		// Get system properties
      		Properties props =System.getProperties();
		
		out.println("Default Properties Set");		

	      // Setup mail server
      		props.put("mail.smtp.host","127.0.0.1");


	      // Get the default Session object.
      Session session = Session.getInstance(props,null);
	out.println("<br/>Session : "+session);

Session ses=info.getSession();
Store storee=ses.getStore("imap");
storee.connect(info.getHostname(),info.getusername(),info.getpassword());
Folder folderr = storee.getFolder(info.getUrl());
folderr.open(Folder.READ_WRITE);
Message[] messagee=folderr.getMessages();
Multipart multipartt=(Multipart)messagee[messageno].getContent();

for(int i=0;i<multipartt.getCount();i++)
{
	BodyPart bodypart=multipartt.getBodyPart(i);
	String disposition=bodypart.getDisposition();
	if(disposition!=null && (disposition.equals(BodyPart.ATTACHMENT)))
	{
		String filename=bodypart.getFileName();
		Attachment=filename;
		FileWriter outputFileWriter=new FileWriter("C:\\nikki\\apache-tomcat-7.0.23-windows-x86\\apache-tomcat-7.0.23\\webapps\\Email\\ForwardDownload\\"+filename);
		FileStoredPath="C:\\nikki\\apache-tomcat-7.0.23-windows-x86\\apache-tomcat-7.0.23\\webapps\\Email\\ForwardDownload\\"+filename;
		InputStream inputStream=bodypart.getInputStream();
		int ii;
		while((ii=inputStream.read())!=-1)
		{
			outputFileWriter.write(ii);
		}
		outputFileWriter.close();
	 }
	
}

out.println("To : "+recipents+"<br/>cc : "+cc+"<br/>Subject : "+subject+"<br>Attachment : "+Attachment+"<br/>Data : "+data+"<br/>Submit : "+submit+"<br/>Draft : "+draft);

if(submit!=null)
{


      try{
		out.println("<br/>4");
         // Create a default MimeMessage object.

         MimeMessage message = new MimeMessage(session);
	out.println("<br/>Message : "+message);
         // Set From: header field of the header.

         message.setFrom(new InternetAddress(info.getusername()));
	out.println("<br/>From Set To : "+info.getusername());

         // Set To: header field of the header.
         message.setRecipients(javax.mail.Message.RecipientType.TO, addressTo); 
	out.println("<br/> Recipients Set ");	
		

	out.println("<br/>5");
         // Set Subject: header field
         message.setSubject(subject);

	//set Current date time
	message.setSentDate(new Date());

	//message.setText(data);


	out.println("6");
	Multipart multipart = new MimeMultipart();

	MimeBodyPart messageBodyPart = new MimeBodyPart();
	//setting the actual message in mime body part
	messageBodyPart.setText(data);
    	multipart.addBodyPart(messageBodyPart);
	
	out.println("7");
    // Part two is attachment
	
    	if(!(Attachment.equals("null")))	
	{
	MimeBodyPart attachmentBodyPart = new MimeBodyPart();
    DataSource source = new FileDataSource(FileStoredPath);
	out.println("<br/>source object created...!!!");
    attachmentBodyPart.setDataHandler(new DataHandler(source));
	out.println("<br/>AttachmentBodyPart data handler set...!!!!");
    attachmentBodyPart.setFileName(Attachment);
	out.println("<br/>AttachmentBodypart file name set..!!!");
    multipart.addBodyPart(attachmentBodyPart);
	out.println("<br/>attachmentBodyPart added to multipart object...");
	}
	message.setContent(multipart);	
	out.println("<br/>Message Content Set");


	
	Transport.send(message);
	out.println("<br/>Message Sent Successfully with Attachment<br/>");
	out.println("9");
	
	Store store=info.getStore();
	out.println("store got");
	Folder f = store.getFolder("Sent");
		// create "Sent" folder if it does not exist
	if (!f.exists()) f.create(Folder.HOLDS_MESSAGES);
		// add message to "Sent" folder
	f.appendMessages(new Message[] {message});
	out.println("stored in sent");
    	
	req.setAttribute("sendmessage","Message sent Successfully");
		getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);

	}catch (Exception mex) {
         
	req.setAttribute("sendmessage","Message Not Sent Error : "+mex.getMessage());
	getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);
      }//end catch

}//end if
else
{

      try{
         // Create a default MimeMessage object.
         MimeMessage message = new MimeMessage(session);

         // Set From: header field of the header.
         message.setFrom(new InternetAddress(info.getusername()));


         // Set To: header field of the header.
	 if(!(recipents.equals("null")))
         {message.setRecipients(javax.mail.Message.RecipientType.TO, addressTo);}
	
	
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
	
	out.println("7");
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
	folder.appendMessages(new Message[] {message});
	
	}
	out.println("Message Saved");
        
	req.setAttribute("sendmessage","Message Saved Successfully");
		getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);

	}catch (MessagingException mex) {
         //mex.printStackTrace();
	req.setAttribute("sendmessage","Message Not Saved");
	getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);
      }//end catch
}//end if



}//end top level try
catch(Exception Ex)
{
	req.setAttribute("sendmessage","Error Over Here :"+Ex.toString());
	getServletContext().getRequestDispatcher("/home.jsp").forward(req,res);
}

}
}



	