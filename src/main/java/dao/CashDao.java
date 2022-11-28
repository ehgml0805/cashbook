package dao;
import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.Cash;

public class CashDao {
	//일별 데이터 출력
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId,int year, int month, int date) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_kind categoryKind , ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id=? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) ORDER BY c.cash_date ASC, ct.category_kind ASC;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId );
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}

	//월별 데이터 출력
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId ,int year, int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT c.cash_no cashNo, c.cash_price cashPrice, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName, c.cash_date cashDate FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no  WHERE c.member_id=? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId );
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			m.put("cashDate", rs.getString("cashDate"));
			// m.put()
			list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}

	//데이터 삽입
	public int insert(String memberId ,String cashDate , long cashPrice, int categoryNo, String cashMemo) throws Exception{
		DBUtil dbUtil= new DBUtil();
		Connection conn=dbUtil.getConnection();
		String sql="INSERT INTO cash (member_id, cash_date, cash_price, category_no, cash_memo, updatedate, createdate) VALUE(?,?,?,?,?,CURDATE(),CURDATE());";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, cashDate);
		stmt.setLong(3,cashPrice );
		stmt.setInt(4, categoryNo);
		stmt.setString(5, cashMemo);
		int row= stmt.executeUpdate();
		if(row==1) {
			System.out.println("추가 성공");
			return 1;
		}else {
			System.out.println("추가 실패");
			return 0;
		}
	}
	//데이터 삭제
	public int delete(int cashNo) throws Exception{
		DBUtil dbUtil=new DBUtil();
		Connection conn=dbUtil.getConnection();
		String sql="DELETE FROM cash WHERE cash_no=?;";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		int row=stmt.executeUpdate();
		if(row==1) {
			System.out.println("삭제 성공");
			return 1;
		}else {
			System.out.println("삭제 실패");
			return 0;
		}
	}
	//cash 데이터 수정 Form
	public Cash selectCashOne(int cashNo) throws Exception{
		Cash cash=null;
		DBUtil dbUtil= new DBUtil();
		Connection conn=dbUtil.getConnection();
		String sql="SELECT cash_no cashNo, category_no categoryNo, cash_price cashPrice, cash_memo cashMemo FROM cash WHERE cash_no=?;";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		ResultSet rs=stmt.executeQuery();
		if(rs.next()) {
			cash= new Cash();
			cash.setCashNo(rs.getInt("cashNo"));
			cash.setCategoryNo(rs.getString("categoryNo"));
			cash.setCashPrice(rs.getLong("cashPrice"));
			cash.setCashMemo(rs.getString("cashMemo"));
		}
		return cash;
	}
	//cash 데이터 수정 Action
	public int update(Cash cash) throws Exception{
		int row=0;
		DBUtil dbUtil= new DBUtil();
		Connection conn=dbUtil.getConnection();
		String sql="UPDATE cash SET cash_price=?, cash_memo=? WHERE cash_no=?;";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setLong(1, cash.getCashPrice());
		stmt.setString(2, cash.getCashMemo());
		stmt.setInt(3, cash.getCashNo());
		row=stmt.executeUpdate();
		if(row==1) {
			System.out.println("수정 성공");
			return 1;
		}else {
			System.out.println("수정 실패");
			return 0;
		}
	}
}

