package project_info;

public class PjtInfo_DTO {
	private String pname;
	private String pmanager;
	private String pdescription;

	public PjtInfo_DTO() {
		super();
	}

	public PjtInfo_DTO(String pname, String pmanager, String pdescription) {
		super();
		this.pname = pname;
		this.pmanager = pmanager;
		this.pdescription = pdescription;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getPmanager() {
		return pmanager;
	}

	public void setPmanager(String pmanager) {
		this.pmanager = pmanager;
	}

	public String getPdescription() {
		return pdescription;
	}

	public void setPdescription(String pdescription) {
		this.pdescription = pdescription;
	}

	@Override
	public String toString() {
		return "PjtInfo_DTO [pname=" + pname + ", pmanager=" + pmanager + ", pdescription=" + pdescription + ", pnum="
				+ "]";
	}

}
