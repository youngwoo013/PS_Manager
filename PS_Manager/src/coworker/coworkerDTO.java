package coworker;

public class coworkerDTO {
	private String userid;
	private String pnum;
	
	public coworkerDTO() {
		super();
	}
	
	public coworkerDTO(String userid, String pnum) {
		super();
		this.userid = userid;
		this.pnum = pnum;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPnum() {
		return pnum;
	}
	public void setPnum(String pnum) {
		this.pnum = pnum;
	}
	
	@Override
	public String toString() {
		return "coworkerDTO [userid=" + userid + ", pnum=" + pnum + "]";
	}
	
	

}
