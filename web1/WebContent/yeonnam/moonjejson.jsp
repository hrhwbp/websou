<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
{"sawons": [
<%
	request.setCharacterEncoding("utf-8");
	String gen = request.getParameter("gen");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String result = "";

	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
	} catch (Exception e) {
		System.out.println("연결 오류:" + e);
		return;
	}

	try {
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
 		String sql = "select gogek_name, gogek_tel, sawon_name, buser_tel from gogek left outer join sawon on gogek_damsano = sawon_no left outer join buser on buser_no = buser_num ";
 		if(gen.equals("1")){
 			sql += " where substr(gogek_jumin, 8, 1) = 1";
 		}else if (gen.equals("2")){
 			sql += " where substr(gogek_jumin, 8, 1) = 2";
 		}else{
 			
 		}
 		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();

		while (rs.next()) {
			result += "{";
			result += "\"gname\":" + "\"" + rs.getString(1) + "\",";
			result += "\"gtel\":" + "\"" + rs.getString(2) + "\",";
			result += "\"sname\":" + "\"" + rs.getString(3) + "\",";
			result += "\"btel\":" + "\"" + rs.getString(4) + "\"";

			result += "},";
		}
		
		if (result.length() > 0) {
			result = result.substring(0, (result.length() - 1));
		}
		result += "]}";
		out.println(result);
		rs.close();
		pstmt.close();
		conn.close();
	} catch (Exception e2) {
		System.out.println("에러:" + e2);
	}
%>