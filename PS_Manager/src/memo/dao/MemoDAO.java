package memo.dao;
import memo.dto.MemoDTO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import sqlmap.MybatisManager;

public class MemoDAO {
	public List<MemoDTO> listMemo(){
		SqlSession session=MybatisManager.getInstance().openSession();
		List<MemoDTO> list=session.selectList("memo.list");
		session.close();
		return list;
	}
	public void updateMemo(MemoDTO dto) {
		SqlSession session=MybatisManager.getInstance().openSession();
		session.update("memo.update", dto);
		session.commit();
		session.close();
	}
	
	public void deleteMemo(int idx) {
		SqlSession session=MybatisManager.getInstance().openSession();
		session.delete("memo.delete", idx);
		session.commit();
		session.close();
	}
	
	public MemoDTO viewMemo(int idx) {
		SqlSession session=MybatisManager.getInstance().openSession();
		MemoDTO dto=session.selectOne("memo.view", idx);
		session.close();
		return dto;
	}
	
	
	public void insertMemo(MemoDTO dto) {
		SqlSession session=MybatisManager.getInstance().openSession();
		String writer=dto.getWriter();
		String memo=dto.getMemo();
		
		writer=writer.replace("  ", "&nbsp;&nbsp;");
		memo=memo.replace("  ", "&nbsp;&nbsp;");
		
		
		writer=writer.replace("<", "&lt;");
		writer=writer.replace(">", "&gt;");
		memo=memo.replace("<", "&lt;");
		memo=memo.replace(">", "&gt;");
		dto.setWriter(writer);
		dto.setMemo(memo);
		
		session.insert("memo.insert", dto);
		session.commit();
		session.close();
		
	}
}
