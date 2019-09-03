package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import schedule.my_scheduleDAO;
import schedule.my_scheduleDTO;
import schedule.pjt_scheduleDAO;
import schedule.pjt_scheduleDTO;

@WebServlet("/schedule_servlet/*")
public class ScheduleController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String url = request.getRequestURL().toString();
		request.setCharacterEncoding("utf-8");
		System.out.println("url = " + url);
		
		if(url.contains("add_pjtSchedule.do")) {
			pjt_scheduleDTO dto = new pjt_scheduleDTO();
			String pname = request.getParameter("userid");
			String pnum = request.getParameter("pnum");
			String description = request.getParameter("description");
			String sday = request.getParameter("sday");
			String eday = request.getParameter("eday");
			PrintWriter out = response.getWriter();
			int res = 0;
			
			dto.setPnum(pnum);
			dto.setDescription(description);
			dto.setSday(sday);
			dto.setEday(eday);
			
			res = new pjt_scheduleDAO().addPjtSchedule(dto);
			out.print(res);
			
			System.out.println(pname + description + sday);
		} else if(url.contains("add_mySchedule.do")) {
			my_scheduleDTO dto = new my_scheduleDTO();
			String userid = request.getParameter("userid");
			String description = request.getParameter("description");
			String sday = request.getParameter("sday");
			String eday = request.getParameter("eday");
			PrintWriter out = response.getWriter();
			int res = 0;
			
			dto.setUserid(userid);
			dto.setDescription(description);
			dto.setSday(sday);
			dto.setEday(eday);
			
			res = new my_scheduleDAO().addMySchedule(dto);
			out.print(res);
		} else if(url.contains("show_Myschedule.do")) {
			
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			
			my_scheduleDAO dao = new my_scheduleDAO();
			PrintWriter out = response.getWriter();
			String userid = request.getParameter("userid");
			String schedule_res = dao.showMyschedule(userid);
			
			out.print(schedule_res);
			
		} else if(url.contains("show_Pjtschedule.do")) {
			
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			
			pjt_scheduleDAO dao = new pjt_scheduleDAO();
			PrintWriter out = response.getWriter();
			String pnum = request.getParameter("pnum");
			String schedule_res = dao.showPjtschedule(pnum);
			
			out.print(schedule_res);
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
