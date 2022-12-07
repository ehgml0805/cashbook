package dao;
import java.sql.*;
import java.util.*;

import util.DBUtil;
import vo.Help;

public class HelpDao {
	//관리자 답변 입력시 문의글 보면서 쓰려고
	public HashMap<String, Object> selectHelpComment(int helpNo) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		String sql = "SELECT help_memo helpMemo,member_id memberId,createdate FROM help WHERE help_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			map.put("helpMemo", rs.getString("helpMemo"));
			map.put("memberId", rs.getString("memberId"));
			map.put("createdate", rs.getString("createdate"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return map;
	}

	//총페이지 
	public int selectHelpCount() {
		int count = 1;// 0으로 쓰니까 오류남
		DBUtil dbUtil = new DBUtil();
		PreparedStatement countStmt=null;
		Connection conn = null;
		ResultSet countRs = null;
		
		try {
			conn = dbUtil.getConnection();
			String countSql = "SELECT COUNT(*) FROM help;";
			countStmt = conn.prepareStatement(countSql);
			countRs = countStmt.executeQuery();
			if (countRs.next()) {
				count = countRs.getInt(count);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{
				dbUtil.close(countRs, countStmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	
	//관리자
	//selectHelpList
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage){
		ArrayList<HashMap<String, Object>> list= new ArrayList<HashMap<String,Object>>();
		DBUtil dbUtil=new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		try {
			conn=dbUtil.getConnection();
			String sql="SELECT h.help_no helpNo, h.help_memo helpMemo, h.member_id memberId, h.createdate helpCreatedate, c.comment_no commentNo, c.comment_memo commentMemo, c.createdate commentCreatedate FROM help h LEFT JOIN comment c ON h.help_no=c.help_no ORDER BY h.help_no DESC LIMIT ?,?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs=stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("memberId", rs.getString("memberId"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentNo", rs.getString("commentNo"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
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
		}return list;
	}
	
	//사용자
	//문의 수정하기 Action
	public int updateHelp (Help help) {
		int row=0;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		try {
			dbUtil=new DBUtil();
			conn=dbUtil.getConnection();
			String sql="UPDATE help SET help_memo=?, updatedate=NOW() WHERE help_no=?;";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpMemo());
			stmt.setInt(2, help.getHelpNo());
			row=stmt.executeUpdate();
			if(row==1) {
				System.out.println("문의 수정 성공");
				return 1;
			}else {
				System.out.println("문의 수정 실패");
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
		} return row;
	}
	
	
	
	//문의 수정하기 Form
	public Help selectHelp(Help help){
		Help list=null;
		DBUtil dbUtil=new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		try {
			dbUtil=new DBUtil();
			conn=dbUtil.getConnection();
			String sql="SELECT help_memo FROM help WHERE help_no=?; ";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, help.getHelpNo());
			rs=stmt.executeQuery();
			if(rs.next()) {
				help= new Help();
				help.setHelpNo(rs.getInt("helpNo"));
				help.setHelpMemo(rs.getString("helpMemo"));
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}return list;
	}
	
	
	//문의 삭제하기
	public int deleteHelp(Help help) {
		int row=0;
		DBUtil dbutil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		try {
			dbutil=new DBUtil();
			conn=dbutil.getConnection();
			String sql="DELETE FROM help WHERE help_no=? ;";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, help.getHelpNo());
			row=stmt.executeUpdate();
			if(row==1) {
				System.out.println("문의 삭제 성공");
				return 1;
			}else {
				System.out.println("문의 삭제 실패");
				return 0;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(null, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	//문의 추가하기
	public int insertHelp(Help help){
		int row=0;
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		try {
			dbUtil=new DBUtil();
			conn=dbUtil.getConnection();
			String sql="INSERT help(help_memo, member_id, updatedate, createdate) VALUES (?,?,NOW(), NOW());";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpMemo());
			stmt.setString(2, help.getMemberId());
			row=stmt.executeUpdate();
			if(row==1) {
				System.out.println("문의 추가 성공");
				return 1;
			}else {
				System.out.println("문의 추가 실패");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
			 dbUtil.close(null, stmt, conn);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return row;
	}
	
	
	
	//로그인한 그 아이디 사용자가 문의한 목록 출력하기
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) {
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();		
		DBUtil dbUtil=null;
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs= null;
		try {
			String sql="SELECT h.help_no helpNo, h.help_memo helpMemo , h.createdate helpCreatedate, c.comment_memo commentMemo, c.createdate commentCreatedate FROM help h LEFT JOIN comment c ON h.help_no=c.help_no WHERE h.member_id=?;";
			dbUtil=new DBUtil();
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
	

}
