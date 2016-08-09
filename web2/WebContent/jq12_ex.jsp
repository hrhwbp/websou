<?xml version = "1.0" encoding = "utf-8" ?>

<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<sawontable>
<%
request.setCharacterEncoding("utf-8");
String ibsail = request.getParameter("ibsail");
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	
}catch(Exception e){
	System.out.println("연결 오류: " + e);
	return;
}

try{
	
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
	pstmt = conn.prepareStatement("select sawon_no, sawon_name, buser_name from sawon left outer join buser on buser_no = buser_num order by sawon_no");
	rs = pstmt.executeQuery();
	
	while(rs.next()){
%>
	<sawon>		
		<sawon_no><%=rs.getString(1) %></sawon_no>
		<sawon_name><%=rs.getString(2) %></sawon_name>
		<buser_name><%=rs.getString(3) %></buser_name>
	</sawon>	
<%			
	}
	rs.close();
	pstmt.close();
	conn.close();
}catch(Exception e2){
	System.out.println("오류: " + e2);
}
%>
</sawontable>