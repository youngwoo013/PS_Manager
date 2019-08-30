package memo;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import memo.dao.MemoDAO;
import memo.dto.MemoDTO;

@WebServlet("/memo_servlet/*")





public class MemoController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
   	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemoDAO dao=new MemoDAO();
		String url=request.getRequestURL().toString();
		if(url.indexOf("list.do")!=-1){
			List<MemoDTO> list=dao.listMemo();
			request.setAttribute("list", list);
			String page="/memo/memo_list.jsp";
			
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
			}
		else if(url.indexOf("insert.do")!=-1) {
			String writer=request.getParameter("writer");
			String memo=request.getParameter("memo");
			MemoDTO dto=new MemoDTO(writer, memo);
			System.out.println(dto);
			dao.insertMemo(dto);
		}
		
		else if(url.indexOf("view.do")!=-1) {
			int idx=Integer.parseInt(request.getParameter("idx"));
			MemoDTO dto=dao.viewMemo(idx);
			request.setAttribute("dto", dto);
			String page="/memo/memo_view.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		else if(url.indexOf("update.do")!=-1) {
			request.setCharacterEncoding("utf-8");
			int idx=Integer.parseInt(request.getParameter("idx"));
			String writer=request.getParameter("writer");
			String memo=request.getParameter("memo");
			System.out.println("controller="+memo);
			MemoDTO dto=new MemoDTO();
			dto.setIdx(idx);
			dto.setWriter(writer);
			dto.setMemo(memo);
			dao.updateMemo(dto);
			response.sendRedirect("/psManager/memo/memo.jsp");
		}
		else if(url.indexOf("delete.do")!=-1) {
			int idx=Integer.parseInt(request.getParameter("idx"));
			dao.deleteMemo(idx);
			response.sendRedirect("/psManager/memo/memo.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doGet(request, response);
	}

}
