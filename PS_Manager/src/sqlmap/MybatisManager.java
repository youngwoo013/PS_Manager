package sqlmap;
import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisManager {
	private static SqlSessionFactory instance;
	private MybatisManager() {}

	public static SqlSessionFactory getInstance() {
		Reader reader = null;
		try {
			// Java Resources의 src
			reader = Resources.getResourceAsReader("sqlmap/sqlMapConfig.xml");
			// SqlSessionFactory 생성기
			instance = new SqlSessionFactoryBuilder().build(reader);
			reader.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (reader != null)
					reader.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return instance;
	}
}
