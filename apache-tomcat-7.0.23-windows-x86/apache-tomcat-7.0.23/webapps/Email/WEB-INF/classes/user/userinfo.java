package user;

import javax.mail.*;

public class userinfo
{
	public userinfo(){};
	private String hostname;
	private String username;
	private String password;
	private String sendfrom;
	private Folder folder;
	private Session session;
	private Store store;
	private URLName url;
	private String protocol;
	private String mbox = "INBOX";	
	private int count=0;
	private int unreadedcount=0;

	private String error;

	public void setError(String err)
	{ this.error=err; }
	
	public String getError()
	{ return this.error; }

	public void setusername(String user)
	{ this.username=user; }

	public String getusername()
	{ return this.username; }

	public void setpassword(String pass)
	{ this.password=pass; }

	public String getpassword()
	{ return this.password; }

	public void setsendfrom(String user)
	{ this.sendfrom=user; }

	public String getsendfrom()
	{  return this.sendfrom; }

	public Folder getFolder()
	{ return folder; }

	public void setFolder(Folder fldr)
	{ this.folder=fldr; }

	public String getHostname()
	{ return hostname;   }
    
	public void setHostname(String hostname)
	{ this.hostname = hostname; }

	public Session getSession()
	{ return session; }

	public void setSession(Session session)
	{ this.session = session; }

	public Store getStore()
	{ return store; }

	public void setStore(Store store)
	{ this.store = store; }


	public URLName getUrl()
	{ return url; }

	public void setUrl(URLName url)
	{ this.url=url; }

	public void setMessageCount(int count)
	{ this.count=count; }

	public int getMessageCount()
	{ return this.count; }

	public void setUnreadedCount(int count)
	{ this.unreadedcount=count; }

	public int getUnreadedCount()
	{ return this.unreadedcount; }


	public userinfo(String username, String password)
	{ this.username=username;this.password=password;}


}

	