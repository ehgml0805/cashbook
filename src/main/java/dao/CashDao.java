package dao;

import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.Cash;

public class CashDao {
	
	// 사용자 월 별 수입/지출 합과 평균
	public ArrayList<HashMap<String, Object>> selectCashSumByMonth(String memberId,int year){
		ArrayList<HashMap<String, Object>> list= new ArrayList<HashMap<String,Object>>();
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt=null;
		Connection conn = null;
		ResultSet rs =null;
		
		try {
			conn = dbUtil.getConnection();
			String sql="SELECT"
					+ "		MONTH(t2.cashDate) month"
					+ "		, COUNT(t2.importCash) importCashCount"
					+ "		, IFNULL(SUM(t2.importCash), 0) importCashSum"
					+ "		, IFNULL(ROUND(AVG(t2.importCash)), 0) importCashAvg"
					+ "		, COUNT(t2.exportCash) exportCashCount"
					+ "		, IFNULL(SUM(t2.exportCash), 0) exportCashSum"
					+ "		, IFNULL(ROUND(AVG(t2.exportCash)), 0) exportCashAvg"
					+ " FROM"
					+ "	(SELECT "
					+ "			memberId"
					+ "			, cashNo"
					+ "			, cashDate"
					+ "			, IF(categoryKind = '수입', cashPrice, null) importCash"
					+ "			, IF(categoryKind = '지출', cashPrice, null) exportCash"
					+ "	 FROM (SELECT cs.cash_no cashNo"
					+ "					, cs.cash_date cashDate"
					+ "					, cs.cash_price cashPrice"
					+ "					, cg.category_kind categoryKind"
					+ "					, cs.member_id memberId"
					+ "			FROM cash cs "
					+ "			INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?"
					+ " GROUP BY MONTH(t2.cashDate)"
					+ " ORDER BY MONTH(t2.cashDate) ASC;";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			rs=stmt.executeQuery();
			while(rs.next()) {
				HashMap<String , Object> m=new HashMap<String, Object>();
				m.put("month",rs.getInt("month"));
				m.put("importCashCount",rs.getInt("importCashCount"));
				m.put("importCashSum",rs.getInt("importCashSum"));
				m.put("importCashAvg",rs.getInt("importCashAvg"));
				m.put("exportCashCount",rs.getInt("exportCashCount"));
				m.put("exportCashSum",rs.getInt("exportCashSum"));
				m.put("exportCashAvg",rs.getInt("exportCashAvg"));
				list.add(m);
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
		
		return list;
		
	}
	
	
	// 사용자 년도 별 수입/지출 합과 평균
	public ArrayList<HashMap<String,Object>> selectCashListByCategory(String memberId){
		ArrayList<HashMap<String,Object>> list= new ArrayList<HashMap<String,Object>>();
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt=null;
		Connection conn = null;
		ResultSet rs =null;
		
		try {
			conn = dbUtil.getConnection();
			String sql="SELECT"
					+ "		YEAR(t2.cashDate) year"
					+ "		, COUNT(t2.importCash) importCashCount "
					+ "		, IFNULL(SUM(t2.importCash), 0) importCashSum"
					+ "		, IFNULL(ROUND(AVG(t2.importCash)), 0) importCashAvg "
					+ "		, COUNT(t2.exportCash) exportCashCount"
					+ "		, IFNULL(SUM(t2.exportCash), 0) exportCashSum"
					+ "		, IFNULL(ROUND(AVG(t2.exportCash)), 0) exportCashAvg"
					+ " FROM"
					+ "	(SELECT "
					+ "			memberId"
					+ "			, cashNo"
					+ "			, cashDate"
					+ "			, IF(categoryKind = '수입', cashPrice, null) importCash"
					+ "			, IF(categoryKind = '지출', cashPrice, null) exportCash"
					+ " FROM (SELECT cs.cash_no cashNo"
					+ "					, cs.cash_date cashDate"
					+ "					, cs.cash_price cashPrice"
					+ "					, cg.category_kind categoryKind"
					+ "					, cs.member_id memberId"
					+ "			FROM cash cs "
					+ "			INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ " WHERE t2.memberId =?"
					+ " GROUP BY YEAR(t2.cashDate)"
					+ " ORDER BY YEAR(t2.cashDate) ASC;";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs=stmt.executeQuery();
			while(rs.next()) {
				HashMap<String , Object> m=new HashMap<String, Object>();
				m.put("year",rs.getInt("year"));
				m.put("importCashCount",rs.getInt("importCashCount"));
				m.put("importCashSum",rs.getInt("importCashSum"));
				m.put("importCashAvg",rs.getInt("importCashAvg"));
				m.put("exportCashCount",rs.getInt("exportCashCount"));
				m.put("exportCashSum",rs.getInt("exportCashSum"));
				m.put("exportCashAvg",rs.getInt("exportCashAvg"));
				list.add(m);
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
		
		return list;
	}
	
	//페이징할 최소 년도와 최대 년도 
	public HashMap<String, Object> selectMaxMinYear(){
		HashMap<String, Object> map= null;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt=null;
		Connection conn = null;
		ResultSet rs =null;
		
		try {
			conn = dbUtil.getConnection();
			String sql="SELECT (SELECT MIN(YEAR(cash_date)) FROM cash) minYear, (SELECT MAX(YEAR(cash_date)) FROM cash) maxYear FROM DUAL;";
			stmt=conn.prepareStatement(sql);
			rs=stmt.executeQuery();
			if(rs.next()) {
				map=new HashMap<String, Object>();
				map.put("minYear", rs.getInt("minYear"));
				map.put("maxYear", rs.getInt("maxYear"));
				
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
		return map;
	}
	
	// 일별 데이터 출력
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt=null;
		Connection conn = null;
		ResultSet rs =null;
		
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_kind categoryKind , ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id=? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) ORDER BY c.cash_date ASC, ct.category_kind ASC;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			stmt.setInt(4, date);
			rs = stmt.executeQuery();
			while (rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("cashNo", rs.getInt("cashNo"));
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("cashMemo", rs.getString("cashMemo"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
				list.add(m);
				}
		}catch(Exception e) {
			
		}finally {
			try {
				dbUtil.close(rs, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	// 월별 데이터 출력
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt=null;
		Connection conn = null;
		ResultSet rs =null;
		
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT c.cash_no cashNo, c.cash_price cashPrice, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName, c.cash_date cashDate FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no  WHERE c.member_id=? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			while (rs.next()) {
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
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	// 데이터 삽입
	public int insert(String memberId, String cashDate, long cashPrice, int categoryNo, String cashMemo)  {
		int row=0;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt=null;
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			String sql = "INSERT INTO cash (member_id, cash_date, cash_price, category_no, cash_memo, updatedate, createdate) VALUE(?,?,?,?,?,CURDATE(),CURDATE());";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setString(2, cashDate);
			stmt.setLong(3, cashPrice);
			stmt.setInt(4, categoryNo);
			stmt.setString(5, cashMemo);
			row = stmt.executeUpdate();
			if (row == 1) {
				System.out.println("추가 성공");
				return 1;
			} else {
				System.out.println("추가 실패");
				return 0;
			}
		}catch (Exception e) {

		}finally {
			try {
				dbUtil.close(null, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}return row;
	}

	// 데이터 삭제
	public int delete(int cashNo) {
		int row=0;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt=null;
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			String sql = "DELETE FROM cash WHERE cash_no=?;";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			row = stmt.executeUpdate();
			if (row == 1) {
				System.out.println("삭제 성공");
				return 1;
			} else {
				System.out.println("삭제 실패");
				return 0;
			}
		}catch(Exception e) {//예외가 발생한다면 에러메시지 표시할 것?
			e.printStackTrace();
		}finally {// 예외가 발생해도 무조건 실행해라
			try {
				stmt.close();
				conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}return row;//finally 안에 적어주면 노란 줄 생김 에러는 아니고 일종의 경고?
	}

	// cash 데이터 수정 Form
	public Cash selectCashOne(int cashNo){
		Cash cash = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn =null;
		PreparedStatement stmt =null;
		ResultSet rs =null;
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT category_no categoryNo, member_id memberId, cash_date cashDate, cash_price cashPrice, cash_memo cashMemo FROM cash WHERE cash_no=?;";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			rs = stmt.executeQuery();
			if (rs.next()) {
				cash = new Cash();
				//cash.setCashNo(rs.getInt("cashNo"));이거 적어버리니까 안나옴  no가 같을 때 가져올 값이라서 no 없어도 되는 듯?
				cash.setCategoryNo(rs.getString("categoryNo"));
				cash.setMemberId(rs.getString("memberId"));
				cash.setCashDate(rs.getString("cashDate"));
				cash.setCashPrice(rs.getLong("cashPrice"));
				cash.setCashMemo(rs.getString("cashMemo"));
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
				rs.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return cash;
	}

	// cash 데이터 수정 Action
	public int update(Cash cash){
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn =null;
		PreparedStatement stmt =null;
		try {
			conn = dbUtil.getConnection();
			String sql = "UPDATE cash SET cash_price=?, cash_memo=? WHERE cash_no=?;";
			stmt = conn.prepareStatement(sql);
			stmt.setLong(1, cash.getCashPrice());
			stmt.setString(2, cash.getCashMemo());
			stmt.setInt(3, cash.getCashNo());
			row = stmt.executeUpdate();
			if (row == 1) {
				System.out.println("수정 성공");
				return 1;
			} else {
				System.out.println("수정 실패");
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
}
