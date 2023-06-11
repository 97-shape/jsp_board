package user;

public class UserBean {
	private String userID;
	private String userPassword;
	private String userName;
	
	public String getUserID() {
		return userID;
	}
	
	public String getUserPassword() {
		return userPassword;
	}
	
	public String getUserName() {
		return userName;
	}
	
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public UserBean() {
		super();
	}
	
	public UserBean(String userID, String userPassword, String userName) {
		this.userID = userID;
		this.userPassword = userPassword;
		this.userName = userName;
	}
	
}