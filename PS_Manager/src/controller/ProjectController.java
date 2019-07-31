package controller;

import java.io.IOException;

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

			dto.setPname(pname);
			dto.setPmanager(pmanager);
			dto.setPdescription(pdescription);

			new PjtInfo_DAO().insertPjt(dto);
			// pname을 클라이언트에 반환
			response.getWriter().write(pname);

		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
