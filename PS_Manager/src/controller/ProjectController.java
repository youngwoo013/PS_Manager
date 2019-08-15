package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project_info.PjtInfo_DAO;
import project_info.PjtInfo_DTO;

@WebServlet("/project_servlet/*")
public class ProjectController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getRequestURL().toString();
		request.setCharacterEncoding("utf-8");
		System.out.println("url = " + url);

		if (url.contains("createPjt.do")) { // 프로젝트 추가

			PjtInfo_DTO dto = new PjtInfo_DTO();
			String pname = request.getParameter("pname");
			String pmanager = request.getParameter("pmanager");
			String pdescription = request.getParameter("pdescription");
			PrintWriter out = response.getWriter();
			int res = 0;

			// 입력값 없을 때
			if (pname == "") {
				System.out.println("필수항목 기입 X");
				out.print(res);
			} else {
				dto.setPname(pname);
				dto.setPmanager(pmanager);
				dto.setPdescription(pdescription);

				res = new PjtInfo_DAO().insertPjt(dto);
				// pname을 클라이언트에 반환
				out.print(res);
			}
		} else if (url.contains("showPjt.do")){ // 프로젝트 보여주기
			
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			PjtInfo_DAO dao = new PjtInfo_DAO();
			PrintWriter out = response.getWriter();
			String userid = request.getParameter("userid");
			String pjt_res = dao.showPjt(userid);
			
			out.print(pjt_res);
		} else if (url.contains("addCoworker.do")) {
			
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
