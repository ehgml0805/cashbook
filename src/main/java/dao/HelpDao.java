package dao;
import java.sql.*;
import java.util.*;

import util.DBUtil;

public class HelpDao {
	//문의 추가하기
	
	
	//로그인한 그 아이디 사용자가 문의한 목록 출력하기
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) throws Exception{
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		String sql="SELECT h.help_no helpNo, h.help_memo helpMemo , h.createdate helpCreatedate, c.comment_memo commentMemo, c.createdate commentCreatedate FROM help h LEFT JOIN comment c ON h.help_no=c.help_no WHERE h.member_id=?;";
		DBUtil dbUtil=new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs= null;
		
		conn=dbUtil.getConnection();
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		rs=stmt.executeQuery();
	
		while(rs.next()) {
			HashMap<String, Object> m=new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			list.add(m);
		}
		dbUtil.close(rs, stmt, conn);
		return list;
	}
}
