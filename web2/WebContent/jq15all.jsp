<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>

[
<%
	/* 이 안은 자바!  json을 DB에서 불러서 사용하는 방법 실습*/
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String result = "";
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
	} catch (Exception e) {
		System.out.println("Connection Error : " + e);
		return;
	}

	try {
		//System.out.println("@JSON gogek_gen: " + gogek_gen);
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
		pstmt = conn.prepareStatement("select * from sangdata order by code desc");
		rs = pstmt.executeQuery();
		while (rs.next()) {
			result += "{";
			result += "\"code\":" + "\"" + rs.getString("code") + "\",";
			result += "\"sang\":" + "\"" + rs.getString("sang") + "\",";
			result += "\"su\":" + "\"" + rs.getString("su") + "\",";
			result += "\"dan\":" + "\"" + rs.getString("dan") + "\"";
			result += "},";
		}
		if (result.length() > 0) {
			result = result.substring(0, result.length() - 1);
		}
		//out.println("result : " + result);
		out.println(result);

		rs.close();
		pstmt.close();
		conn.close();

	} catch (Exception e2) {
		out.print("f");
		System.out.println("Error : " + e2);
	}
%>
]
