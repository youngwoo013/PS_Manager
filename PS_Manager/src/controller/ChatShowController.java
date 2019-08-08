package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import chat.ChatDAO;
import chat.ChatDTO;

@WebServlet("/chat_servlet/show.do")
public class ChatShowController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public String getToday() { //오늘 채팅정보를 가져온다 -> 현재 안씀, 봐두면 좋음
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = new ChatDAO();
		ArrayList<ChatDTO> chatList = chatDAO.getChatList(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		for(int i=0; i<chatList.size(); i++) {
			result.append("[{\"value\":\""+ chatList.get(i).getChatName() +"\"},");
			result.append("{\"value\":\""+ chatList.get(i).getChatContent() +"\"},");
			result.append("{\"value\":\""+ chatList.get(i).getChatTime() +"\"}]");
			if(i!=chatList.size()-1) result.append(",");
		}
		result.append("], \"last\":\""+ chatList.get(chatList.size()-1).getChatID()+"\"}");
		return result.toString();
	}
	public String getID(String chatID) { //lastID를 가져와서 그 값보다 큰 채팅이 있으면 json형식으로 저장
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = new ChatDAO();
		ArrayList<ChatDTO> chatList = chatDAO.getChatListByRecent(chatID);
		for(int i=0; i<chatList.size(); i++) {
			result.append("[{\"value\":\""+ chatList.get(i).getChatName() +"\"},");
			result.append("{\"value\":\""+ chatList.get(i).getChatContent() +"\"},");
			result.append("{\"value\":\""+ chatList.get(i).getChatTime() +"\"}]");
			if(i!=chatList.size()-1) result.append(",");
		}
		result.append("], \"last\":\""+ chatList.get(chatList.size()-1).getChatID()+"\"}");
		return result.toString();
	}
	public String getTen() { //최근 10개를 json형식으로 저장
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDAO chatDAO = new ChatDAO();
		ArrayList<ChatDTO> chatList = chatDAO.getChatListByRecent(10);
		for(int i=0; i<chatList.size(); i++) {
			result.append("[{\"value\":\""+ chatList.get(i).getChatName() +"\"},");
			result.append("{\"value\":\""+ chatList.get(i).getChatContent() +"\"},");
			result.append("{\"value\":\""+ chatList.get(i).getChatTime() +"\"}]");
			if(i!=chatList.size()-1) result.append(",");
		}
		result.append("], \"last\":\""+ chatList.get(chatList.size()-1).getChatID()+"\"}");
		return result.toString();
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		String listType = request.getParameter("listType");
		if(listType == null || listType.equals("")) response.getWriter().write("");
		else if(listType.equals("today")) response.getWriter().write(getToday());
		else if(listType.equals("ten")) response.getWriter().write(getTen());
		else {
			try {
				Integer.parseInt(listType); //숫자이면 넘어가고 숫자가 아니면 catch문에서 처리
				response.getWriter().write(getID(listType));
			} catch (Exception e) {
				response.getWriter().write(""); //숫자가 아니면 ""를 보냄
			}
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
