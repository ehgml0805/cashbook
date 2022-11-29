package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Member;

public class MemberDao {
	// 관리자 레벨 수정
	public int updateLevel(Member member) {
		
		return 0;
	}

	// 관리자 멤버 강퇴 시킬때
	public Member deleteMemberByAdmin(Member member) throws Exception{
		Member resultMember=null;
		DBUtil dbUtil=new DBUtil();
		Connection conn=dbUtil.getConnection();
		String sql="DELETE FROM member WHERE member_id=?;";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		int row=stmt.executeUpdate();
		if(row==1) {
			System.out.println("멤버 강퇴 성공");
			resultMember=member;
		}
		return resultMember;
	}
	
	// 관리자 페이지에서 멤버 리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Member> list=new ArrayList<Member>();
		DBUtil dbUtil=new DBUtil();
		Connection conn=dbUtil.getConnection();
		String sql="SELECT member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate FROM member ORDER BY createdate DESC; ";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs=stmt.executeQuery();
		while(rs.next()) {
			Member m=new Member();
			m.setMemberId(rs.getString("memberId"));
			m.setMemberLevel(rs.getInt("memberLevel"));
			m.setMemberName(rs.getNString("memberName"));
			m.setUpdatedate(rs.getString("updatedate"));
			m.setCreatedate(rs.getString("createdate"));
			list.add(m);
		}
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	//관리자페이지 페이징 전체 행 구하기
	public int selectMemberAdminCount() throws Exception{
		int count=1;
		DBUtil dbUtil=new DBUtil();
		Connection conn=dbUtil.getConnection();
		String sql="SELECT COUNT(*) FROM member;";
		PreparedStatement stmt=conn.prepareStatement(sql);
		ResultSet rs=stmt.executeQuery();
		if(rs.next()) {
			count=rs.getInt(count);
		}
		return count;
	}
	// 로그인
	public Member login(Member paramMember) throws Exception {
		Member resultMember = null;
		/*
		 * Class.forName("org.mariadb.jdbc.Driver"); String
		 * dbUrl="jdbc:mariadb://127.0.0.1:3306/cashbook"; String dbUser="root"; String
		 * dbPw="java1234"; Connection conn
		 * =DriverManager.getConnection(dbUrl,dbUser,dbPw); ->db를 연결하는 코드(명령들)가 Dao 메서드들
		 * 거의 공통으로 중복됨 ->중복되는 코드를 하나의 이름(메서드)으로 만들자 ->입력값과 반환값 결정해야 함 ->입력값은 없고 반환값은
		 * connection타입의 결과값이 남아야 한다
		 */
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId,member_level memberLevel, member_name memberName FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		// Id랑 Pw를 비교할거
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {// 로그인 된거
			resultMember = new Member();
			// 가져올게 Id랑 Name
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
		}
		dbUtil.close(rs, stmt, conn);
		return resultMember;
	}

	// 회원가입 나눠서 다시 함
	// id 중복 검사
	public boolean memberIdCh(String memberId) throws Exception {
		boolean result = false;// return 받아서 이리 온거니까 중복 아이디 아님
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// id 중복검사
		String idSql = "SELECT member_id FROM member WHERE member_id=?;";
		PreparedStatement idStmt = conn.prepareStatement(idSql);
		idStmt.setString(1, memberId);
		ResultSet idRs = idStmt.executeQuery();
		if (idRs.next()) {// 이미 아이디 있는거
			System.out.println("중복된 아이디입니다");
			result = true;// true가 중복된 아이디
		}
		return result;
	}

	// 회원가입 id중복검사랑 메소드 나눠서 해야함
	public int insertMember(Member paramMember) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member (member_id, member_pw, member_name,updatedate, createdate) VALUES(?,PASSWORD(?),?,CURDATE(),CURDATE());";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}

	/* update id랑 비밀번호가 서로 맞는지 확인
	 * 나눠서 할 필요가 없음.....
	public Member idPwCh(String memberId, String memberPw) throws Exception {
		Member result = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 데이터 베이스 안에 있는 로그인 한 비밀번호 가져오기 및 비교
		String pwSql = "SELECT member_id, member_pw FROM member WHERE member_id=? AND member_pw=PASSWORD(?);";
		PreparedStatement pwStmt = conn.prepareStatement(pwSql);
		pwStmt.setString(1, memberId);
		pwStmt.setString(2, memberPw);
		ResultSet pwRs = pwStmt.executeQuery();
		if (!pwRs.next()) {// id랑 pw가
			System.out.println("비밀번호가 다릅니다.");
		}
		pwRs.close();
		pwStmt.close();
		conn.close();
		return result;
	}
	*/
	public Member update(Member paramMember) throws Exception {
		Member resultMember=null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_name=?, updatedate=CURDATE() WHERE member_id=? AND member_pw=PASSWORD(?);";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberName());
		stmt.setString(2, paramMember.getMemberId());
		stmt.setString(3, paramMember.getMemberPw());
		stmt.executeUpdate();
		int row = stmt.executeUpdate();
		if (row == 1) {
			System.out.println("수정 성공");
			resultMember=paramMember;
		} 
		stmt.close();
		conn.close();
		return resultMember;
	}
	//delete
	public Member delete(Member paramMember) throws Exception {
		Member resultMember = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM member WHERE member_id=? AND member_pw=PASSWORD(?);";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		int row = stmt.executeUpdate();
		if (row == 1) {
			System.out.print("성공");
			resultMember=paramMember;
		} 
		stmt.close();
		conn.close();
		return resultMember;
	}

	//비밀번호 수정 
}
