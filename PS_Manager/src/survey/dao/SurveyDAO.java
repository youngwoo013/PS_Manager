package survey.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;


import sqlmap.MybatisManager;
import survey.dto.SurveyDTO;
import survey.dto.SurveyResultDTO;
import survey.dto.SurveySummaryDTO;


public class SurveyDAO {
	public List<SurveySummaryDTO> listSummary(int survey_num){
		SqlSession session=MybatisManager.getInstance().openSession();
		List<SurveySummaryDTO> items=session.selectList("survey.list_summary", survey_num);
		session.close();
		return items;
	}
	
	
	public void insertSurvey(SurveyResultDTO dto) {
		SqlSession session=MybatisManager.getInstance().openSession();
		session.insert("survey.insert_survey", dto);
		session.commit();
		session.close();
	}
	
	public SurveyDTO viewQuestion(int survey_idx) {
		SqlSession session=MybatisManager.getInstance().openSession();
		SurveyDTO dto=session.selectOne("survey.view_question", survey_idx);
		session.close();
		return dto;
		
	}

	
}
