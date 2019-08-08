package survey;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import survey.dao.SurveyDAO;
import survey.dto.SurveyDTO;
import survey.dto.SurveyResultDTO;
import survey.dto.SurveySummaryDTO;


@WebServlet("/survey_servlet/*")
public class SurveyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url=request.getRequestURL().toString();
		System.out.println(url);
		SurveyDAO dao=new SurveyDAO();
		if(url.contains("input.do")) {
			SurveyDTO dto=dao.viewQuestion(1);
			request.setAttribute("dto", dto);
			RequestDispatcher rd=request.getRequestDispatcher("/survey/survey_input.jsp");
			rd.forward(request, response);
			
		}
		else if(url.contains("insert.do")) {
			int survey_idx=Integer.parseInt(request.getParameter("survey_idx"));
			int num=Integer.parseInt(request.getParameter("num"));
			SurveyResultDTO dto=new SurveyResultDTO();
			dto.setSurvey_idx(survey_idx);
			dto.setNum(num);
			dao.insertSurvey(dto);
			response.sendRedirect("/survey/input_result.jsp");
			
			
		}
		else if(url.contains("survey_result.do")) {
			int survey_idx=Integer.parseInt(request.getParameter("survey_idx"));
			List<SurveySummaryDTO> items=dao.listSummary(survey_idx);
			request.setAttribute("list", items);
			RequestDispatcher rd=request.getRequestDispatcher("/survey/survey_result.jsp");
			rd.forward(request, response);
	
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
