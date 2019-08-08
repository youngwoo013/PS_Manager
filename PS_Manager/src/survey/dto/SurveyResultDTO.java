package survey.dto;

public class SurveyResultDTO {
	private int answer_idx;
	private int survey_idx;
	private int num;
	public int getAnswer_idx() {
		return answer_idx;
	}
	public void setAnswer_idx(int answer_idx) {
		this.answer_idx = answer_idx;
	}
	public int getSurvey_idx() {
		return survey_idx;
	}
	public void setSurvey_idx(int survey_idx) {
		this.survey_idx = survey_idx;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	@Override
	public String toString() {
		return "SurveyResultDTO [answer_idx=" + answer_idx + ", survey_idx=" + survey_idx + ", num=" + num + "]";
	}
	
}
