<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	/* 이 안은 자바!  json을 DB에서 불러서 사용하는 방법 실습*/
	request.setCharacterEncoding("utf-8");
	String code = request.getParameter("code");
	String sang = request.getParameter("sang");
	String su = request.getParameter("su");
	String dan = request.getParameter("dan");

	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
	} catch (Exception e) {
		System.out.println("Connection Error : " + e);
		return;
	}

	try {
		//System.out.println("@JSON gogek_gen: " + gogek_gen);
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
		String sql = "insert into sangdata values(?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, code);
		pstmt.setString(2, sang);
		pstmt.setString(3, su);
		pstmt.setString(4, dan);
		int re = pstmt.executeUpdate();
		if(re == 1){	//insert 성공시 반환값이 1, 아닐 경우 0
			out.print("t");
		}else{
			out.print("f");
		}
	} catch (Exception e2) {
		System.out.println("Insert Error : " + e2);
	}finally{
		pstmt.close();
		conn.close();
	}
%>