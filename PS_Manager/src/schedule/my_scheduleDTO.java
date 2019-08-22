package schedule;

public class my_scheduleDTO {
	private String userid;
	private String sday;
	private String eday;
	private String description;
	
	public my_scheduleDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public my_scheduleDTO(String userid, String sday, String eday, String description) {
		super();
		this.userid = userid;
		this.sday = sday;
		this.eday = eday;
		this.description = description;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSday() {
		return sday;
	}
	public void setSday(String sday) {
		this.sday = sday;
	}
	public String getEday() {
		return eday;
	}
	public void setEday(String eday) {
		this.eday = eday;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	@Override
	public String toString() {
		return "my_scheduleDTO [userid=" + userid + ", sday=" + sday + ", eday=" + eday + ", description=" + description
				+ "]";
	}
	
}
