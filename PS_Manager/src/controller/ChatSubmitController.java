package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import chat.ChatDAO;

@WebServlet("/chat_servlet/submit.do")
public class ChatSubmitController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset-utf-8");
		String chatName = request.getParameter("chatName");
		String chatContent = request.getParameter("chatContent");
		if(chatName == null || chatName.equals("") || chatContent == null || chatContent.equals("")) {
			response.getWriter().write("0"); //둘 중 하나라도 입력하지 않을 시 0을 보내줌
		}
		else {
			response.getWriter().write(new ChatDAO().submit(chatName, chatContent)+""); //성공적으로 반환시 1이 들어갈 것임
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
