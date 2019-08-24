package account;

public class AccountDTO {
	private String userid;
	private String passwd;
	private String name;
	private String phonenum;
	private String email;
	private int birth;
	private String photo;
	
	public AccountDTO() {
		super();
	}
	
	public AccountDTO(String userid, String passwd, String name, String phonenum, String email, int birth, String photo) {
		super();
		this.userid = userid;
		this.passwd = passwd;
		this.name = name;
		this.phonenum = phonenum;
		this.email = email;
		this.birth = birth;
		this.photo = photo;
	}
	
	public String getUserid() {
		return userid;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhonenum() {
		return phonenum;
	}
	public void setPhonenum(String phonenum) {
		this.phonenum = phonenum;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getBirth() {
		return birth;
	}
	public void setBirth(int birth) {
		this.birth = birth;
	}
	
	@Override
	public String toString() {
		return "AccountDTO [userid=" + userid + ", passwd=" + passwd + ", name=" + name + ", phonenum=" + phonenum
				+ ", email=" + email + ", birth=" + birth + ", photo=" + photo + "]";
	}
	
}
