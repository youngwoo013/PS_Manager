package schedule;


public class pjt_scheduleDTO {
	private String pnum;
	private String sday;
	private String eday;
	private String description;
	
	public pjt_scheduleDTO() {
		super();
	}
	
	public pjt_scheduleDTO(String pnum, String sday, String eday, String description) {
		super();
		this.pnum = pnum;
		this.sday = sday;
		this.eday = eday;
		this.description = description;
	}
	
	public String getPnum() {
		return pnum;
	}
	public void setPnum(String pnum) {
		this.pnum = pnum;
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
		return "pjt_scheduleDTO [pnum=" + pnum + ", sday=" + sday + ", eday=" + eday + ", description=" + description + "]";
	}

}
