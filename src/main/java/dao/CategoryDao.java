package dao;

import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.Category;

public class CategoryDao {
	public ArrayList<Category> selectCategoryList() throws Exception {
		ArrayList<Category> categoryList = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category ORDER BY category_kind ASC;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category c= new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			categoryList.add(c);
		}
		rs.close();
		stmt.close();
		conn.close();
		
		// ORDER BY category_kind
		return categoryList;
	}
}