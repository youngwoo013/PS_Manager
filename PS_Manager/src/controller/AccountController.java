package controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import account.AccountDAO;
import account.AccountDTO;

@WebServlet("/account_servlet/*")
public class AccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getRequestURL().toString();
		request.setCharacterEncoding("utf-8");
		System.out.println("url = " + url);
		if (url.contains("signin.do")) { // 로그인 시도
			String userid = request.getParameter("userid");
			String passwd = request.getParameter("passwd");
			System.out.println(userid + " " + passwd);
			AccountDAO dao = new AccountDAO();
			String name = dao.loginCheck(userid, passwd);
			String message = "";
			String page = "";
			if (name == null) {
				message = "로그인 정보가 일치하지 않습니다.";
				message = URLEncoder.encode(message, "utf-8");
				page = "/psManager/account/signin.jsp?message=" + message;

			} else {
				message = name + "님 환영합니다.";
				page = "/psManager/my_schedule/my_schedule.jsp";
				HttpSession session = request.getSession();
				session.setAttribute("userid", userid);
				session.setAttribute("message", message);
			}
			response.sendRedirect(page);
		} else if (url.contains("signout.do")) {
			HttpSession session = request.getSession();
			session.invalidate();
			String message = "로그아웃되었습니다.";
			response.sendRedirect("/psManager/account/signin.jsp?message=" + URLEncoder.encode(message, "utf-8"));
		} else if (url.contains("signup.do")) {
			AccountDTO dto = new AccountDTO();
			String userid = request.getParameter("userid");
			String passwd = request.getParameter("passwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String phonenum = request.getParameter("phonenum");
			int birth = Integer.parseInt(request.getParameter("birth"));
			dto.setUserid(userid);
			dto.setPasswd(passwd);
			dto.setName(name);
			dto.setEmail(email);
			dto.setPhonenum(phonenum);
			dto.setBirth(birth);
			new AccountDAO().insertAccount(dto);
			String message = "회원가입에 성공하였습니다. 다시 로그인해주세요.";
			response.sendRedirect("/psManager/account/signin.jsp?message=" + URLEncoder.encode(message, "utf-8"));
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
