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
	public Cash insert(String memberId ,int cashNo, long cash_price, int category_no, String category_kind, String cash_memo) throws Exception{
		Cash in=null;
		DBUtil dbUtil= new DBUtil();
		Connection conn=dbUtil.getConnection();
		String sql="INSERT INTO cash (cash_price cashPrice, category_no categortNo, cash_date cashDate, cash_price, cash_memo) VALUE(?,?,?,?);";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, cashNo);
		stmt.setLong(3,cash_price );
		stmt.setInt(4, category_no);
		stmt.setString(5, category_kind);
		stmt.setString(6, cash_memo);
		int row= stmt.executeUpdate();
		
		if(row==1) {
			System.out.println(true);
		}else {
			System.out.println(false);
		}
		
		stmt.close();
		conn.close();
		return in;
	}
	//데이터 삭제
	public Cash delete(int cashNo) throws Exception{
		Cash de=null;
		DBUtil dbUtil=new DBUtil();
		Connection conn=dbUtil.getConnection();
		String sql="DELETE FROM cash WHERE cash_no=?;";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		int row= stmt.executeUpdate();
		
		if(row==1) {
			System.out.println(true);
		}else {
			System.out.println(false);
		}
		
		stmt.close();
		conn.close();
		return de;
	}
}

