package dao;

import java.sql.*;
import util.*;
import vo.Comment;

public class CommentDao {
	//수정하기 Action
	public int updateComment(Comment comment) {
		int row=0;
		DBUtil dbUtil=new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		
		try {
			conn=dbUtil.getConnection();
			String sql="UPDATE comment SET comment_memo = ?, updatedate = NOW() WHERE comment_no=?;";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, comment.getCommentMemo());
			stmt.setInt(2, comment.getCommentNo());
			row=stmt.executeUpdate();
			if(row==1) {
				System.out.println("답변 수정 성공");
				return 1;
			}else {
				System.out.println("답변 수정 실패!");
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
	
	
	//수정하기 Form
	public Comment selectCommentOne(int commentNo) {
		Comment comment=null;
		DBUtil dbUtil=new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try {
			conn=dbUtil.getConnection();
			String sql="SELECT comment_memo commentMemo,member_id memberId FROM comment WHERE comment_no = ? ;";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
			rs=stmt.executeQuery();
			if(rs.next()) {
				comment=new Comment();
				comment.setCommentMemo(rs.getString("commentMemo"));
				comment.setMemberId(rs.getString("memberId"));			
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
		return comment;
	}
	
	//삭제
	public int deleteComment(int commentNo) {
		int row=0;
		DBUtil dbUtil=new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		
		try {
			conn=dbUtil.getConnection();
			String sql="DELETE FROM comment WHERE comment_no=?;";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
			row=stmt.executeUpdate();
			if(row==1) {
				System.out.println("답변 삭제 성공");
				return 1;
			}else {
				System.out.println("답변 삭제 실패!");
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
	
	//입력
	public int insertComment(Comment comment) {
		int row=0;
		DBUtil dbUtil=new DBUtil();
		Connection conn=null;
		PreparedStatement stmt=null;
		
		try {
			conn=dbUtil.getConnection();
			String sql="INSERT comment(help_no, comment_memo, member_id, updatedate, createdate) VALUES(?,?,?,NOW(),NOW());";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
			row=stmt.executeUpdate();
			if(row==1) {
				System.out.println("답변 달기 성공");
				return 1;
			}else {
				System.out.println("답변 달기 실패!");
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
