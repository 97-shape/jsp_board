package card;

public class CardBean {
	
	private int cardNo;
	private String name;
	private String role;
	private String phone;
	private String email;
	private String company_number;
	private String company_address;
	private String image;
	private String userID;
	private String password;
	
	public int getCardNo() {
		return cardNo;
	}
	public void setCardNo(int cardNo) {
		this.cardNo = cardNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCompany_number() {
		return company_number;
	}
	public void setCompany_number(String company_number) {
		this.company_number = company_number;
	}
	public String getCompany_address() {
		return company_address;
	}
	public void setCompany_address(String company_address) {
		this.company_address = company_address;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public CardBean() {
		super();
	}
	public CardBean(int cardNo, String name, String role, String phone, String email, String company_number,
			String company_address, String image, String userID, String password) {
		super();
		this.cardNo = cardNo;
		this.name = name;
		this.role = role;
		this.phone = phone;
		this.email = email;
		this.company_number = company_number;
		this.company_address = company_address;
		this.image = image;
		this.userID = userID;
		this.password = password;
	}
	
}
