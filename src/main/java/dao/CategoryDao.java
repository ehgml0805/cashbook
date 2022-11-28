package dao;

import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.Category;

public class CategoryDao {
	//수정: 수정폼과 수정액션으로 구성
	//admin->updatecategoryAction.jsp
	public int updateCategoryName(Category category) throws Exception{
		int row=0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="UPDATE category SET category_name=?, updatedate=CURDATE() WHERE category_no=? ;";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setInt(2,category.getCategoryNo());
		row=stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
		
	}
	
	//admin->updatecategoryForm.jsp
	public Category selectCategoryOne(int categoryNo) throws Exception{
		Category category=null;//null 아예 암것도 없음 new Category하면 빈데이터라도 넘기는 것
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="SELECT category_no categoryNo, category_name categoryName FROM category WHERE category_no=?;";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		ResultSet rs=stmt.executeQuery();
		if(rs.next()) {
			category=new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryName(rs.getString("categoryName"));
		}
		return category;
	}
	
	//admin-> deleteCategory.jsp
	public int deleteCategory(int categoryNo) throws Exception{
		int row=0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="DELETE FROM category WHERE category_no=?";//관리자 페이지니까 걍 삭제 
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		row=stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	//admin->insertCategory
	public int insertCategory(Category category) throws Exception{
		int row=0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="INSERT INTO category (category_kind , category_Name , updatedate, createdate) VALUES (?,?,CURDATE(),CURDATE());";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		row=stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}

	// admin->카테고리 관리->카테고리 목록
	public ArrayList<Category> selectCategoryListByAdmin() throws Exception {
		ArrayList<Category> categoryList = null;
		categoryList = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_no categoryNo, category_kind categoryKind,category_name categoryName, updatedate, createdate FROM category; ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();// resultset을 받음, execuateupdate는 행을 반환함
		while (rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setUpdatedate(rs.getString("updatedate"));
			c.setCreatedate(rs.getString("createdate"));
			categoryList.add(c);
		}
		dbUtil.close(rs, stmt, conn);
		return categoryList;
	}
	// 카테고리 cash입력시 보여주려고
	public ArrayList<Category> selectCategoryList() throws Exception {
		ArrayList<Category> categoryList = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category ORDER BY category_kind ASC;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			categoryList.add(c);
		}
		rs.close();
		stmt.close();
		conn.close();
		return categoryList;
	}
}