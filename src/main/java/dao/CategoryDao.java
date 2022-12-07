package dao;

import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.Category;

public class CategoryDao {
	// 수정: 수정폼과 수정액션으로 구성
	// admin->updatecategoryAction.jsp
	public int updateCategoryName(Category category) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn =null;
		PreparedStatement stmt =null;
		try {
			conn = dbUtil.getConnection();
			String sql = "UPDATE category SET category_kind=?, category_name=?, updatedate=CURDATE() WHERE category_no=? ;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryKind());
			stmt.setString(2, category.getCategoryName());
			stmt.setInt(3, category.getCategoryNo());
			row = stmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(null, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}

	// admin->updatecategoryForm.jsp
	public Category selectCategoryOne(int categoryNo) {
		Category category = null;// null 아예 암것도 없음 new Category하면 빈데이터라도 넘기는 것
		DBUtil dbUtil = new DBUtil();
		Connection conn =null;
		PreparedStatement stmt =null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT category_name categoryName, category_kind categoryKind FROM category WHERE category_no=?;";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			rs = stmt.executeQuery();
			if (rs.next()) {
				category = new Category();
				//category.setCategoryNo(rs.getInt("categoryNo")); 이거는 가져오기만 할거야,,노 필요
				category.setCategoryName(rs.getString("categoryName"));
				category.setCategoryKind(rs.getString("categoryKind"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(null, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return category;
	}

	// admin-> deleteCategory.jsp
	public int deleteCategory(int categoryNo) throws Exception {
		int row = 0;
		Connection conn =null;
		PreparedStatement stmt =null;
		DBUtil dbUtil = new DBUtil();
		try {
			conn = dbUtil.getConnection();
			String sql = "DELETE FROM category WHERE category_no=?";// 관리자 페이지니까 걍 삭제
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			row = stmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
		}finally {
			try {
				dbUtil.close(null, stmt, conn);
			}catch(Exception e) {
				
			}
		}
		return row;
	}
		

	// admin->insertCategory
	public int insertCategory(Category category){
		int row = 0;
		Connection conn =null;
		PreparedStatement stmt =null;
		DBUtil dbUtil = new DBUtil();
		try {
		conn = dbUtil.getConnection();
		String sql = "INSERT INTO category (category_kind , category_Name , updatedate, createdate) VALUES (?,?,CURDATE(),CURDATE());";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		row = stmt.executeUpdate();
		if (row == 1) {
			System.out.println("추가 성공");
			return 1;
		} else {
			System.out.println("추가 실패");
			return 0;
		}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(null, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}return row;
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
	public ArrayList<Category> selectCategoryList(){
		ArrayList<Category> categoryList = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		Connection conn =null;
		PreparedStatement stmt =null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category ORDER BY category_kind ASC;";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Category c = new Category();
				c.setCategoryNo(rs.getInt("categoryNo"));
				c.setCategoryKind(rs.getString("categoryKind"));
				c.setCategoryName(rs.getString("categoryName"));
				categoryList.add(c);
				}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return categoryList;
	}
}