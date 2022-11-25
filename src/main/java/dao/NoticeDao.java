package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	public int insertNotice(Notice notice) throws Exception{
		String sql="INSERT notice(notice_memo,updatedate,createdate) VALUES (?,NOW(),NOW());";
		return 0;
	}
	
	public int deleteNotice(Notice notice) throws Exception{
		String sql="DELETE FROM notice WHERE notice_no=?";
		return 0;
	}
	
	public int updateNotice(Notice notice)throws Exception {
		String sql="UPDATE notice SET notice_memo =? WHERE notice_no=? ;";
		PreparedStatement stmt;
		
		return 0;
	}
	
	
	
	//마지막페이지 구하려면 전체 개수만 구하면 댐
	public int selectNoticeCount() throws Exception{
		int count=1;//0으로 쓰니까 오류남
		DBUtil dbUtil=new DBUtil();
		Connection conn=dbUtil.getConnection();
		String countSql="SELECT COUNT(*) FROM notice;";
		PreparedStatement countStmt=conn.prepareStatement(countSql);
		ResultSet countRs=countStmt.executeQuery();
		if(countRs.next()) {
			count=countRs.getInt(count);
		}
		//구해야함
		return count;
	}
	
	//공지목록 loginForm.jsp에 나올 begin==몇번 부터 뽑을 지
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list =new ArrayList<Notice>();
		DBUtil dbUtil=new DBUtil();
		Connection conn=dbUtil.getConnection();
		String sql="SELECT notice_no noticeNo,notice_memo noticeMemo, updatedate, createdate FROM notice ORDER BY createdate DESC LIMIT ?,?; ";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs=stmt.executeQuery();
		while(rs.next()) {
			Notice n=new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		return list;
	}
}
