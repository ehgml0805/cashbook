package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	//추가
	public int insertNotice(Notice notice) {
		int row=0;
		DBUtil dbUtil= new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		try {
			conn=dbUtil.getConnection();
			String sql = "INSERT notice(notice_memo,updatedate,createdate) VALUES (?,NOW(),NOW());";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeMemo());
			row=stmt.executeUpdate();
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
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}return row;
	}
	
	// 삭제
	public int deleteNotice(Notice notice) {
		int row=0;
		DBUtil dbUtil= new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
				
		try {
			conn=dbUtil.getConnection();
			String sql = "DELETE FROM notice WHERE notice_no=?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, notice.getNoticeNo());
			row=stmt.executeUpdate();
			if(row==1) {
				System.out.println("삭제성공");
				return 1;
			}else {
				System.out.println("삭제실패");
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
	
	//수정 Form에서 메모 내용이랑 번호 가져오기
	public Notice selectNotice(int noticeNo){
		Notice notice=null;
		DBUtil dbUtil=new DBUtil();
		Connection conn= null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try {
			conn=dbUtil.getConnection();
			String sql="SELECT notice_memo noticeMemo FROM notice WHERE notice_no=? ;";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			rs=stmt.executeQuery();
			if(rs.next()) {
				notice=new Notice();
				notice.setNoticeMemo(rs.getString("noticeMemo"));
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn);
			}catch (Exception e){
				e.printStackTrace();
			}
		}return notice;
	}
	
	//수정 Action
	public int updateNotice(Notice notice) {
		int row=0;
		DBUtil dbUtil=new DBUtil();
		PreparedStatement countStmt=null;
		Connection conn = null;
		ResultSet countRs = null;
		
		try {
			conn=dbUtil.getConnection();
			String sql = "UPDATE notice SET notice_memo =?, updatedate=NOW() WHERE notice_no=? ;";
			countStmt=conn.prepareStatement(sql);
			countStmt.setString(1, notice.getNoticeMemo());
			countStmt.setInt(2, notice.getNoticeNo());
			row=countStmt.executeUpdate();
			if(row==1) {
				System.out.println("수정성공");
				return 1;
			}else {
				System.out.println("수정성공");
				return 0;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(countRs, countStmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}return row;
	}

	// 마지막페이지 구하려면 전체 개수만 구하면 댐
	public int selectNoticeCount() {
		int count = 1;// 0으로 쓰니까 오류남
		DBUtil dbUtil = new DBUtil();
		PreparedStatement countStmt=null;
		Connection conn = null;
		ResultSet countRs = null;
		
		try {
			conn = dbUtil.getConnection();
			String countSql = "SELECT COUNT(*) FROM notice;";
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

	// 공지목록 loginForm.jsp에 나올 begin==몇번 부터 뽑을 지
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) {
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt=null;
		Connection conn = null;
		ResultSet rs = null;
		
		try {
			conn = dbUtil.getConnection();
			String sql = "SELECT notice_no noticeNo,notice_memo noticeMemo, updatedate, createdate FROM notice ORDER BY createdate DESC LIMIT ?,?; ";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while (rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setUpdatedate(rs.getString("updatedate"));
				n.setCreatedate(rs.getString("createdate"));
				list.add(n);
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
