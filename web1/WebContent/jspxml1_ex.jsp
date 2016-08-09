<?xml version = "1.0" encoding = "utf-8" ?>
<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<sawontable>
<%
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
	pstmt = conn.prepareStatement("select * from sawon");
	rs = pstmt.executeQuery();
	
	while(rs.next()){
%>
	<sawon>
		<sawon_no><%=rs.getString("sawon_no") %></sawon_no>
		<sawon_name><%=rs.getString("sawon_name") %></sawon_name>
		<sawon_jik><%=rs.getString("sawon_jik") %></sawon_jik>
		<sawon_ibsail><%=rs.getString("sawon_ibsail").substring(0, 4) %></sawon_ibsail>
		<sawon_gen><%=rs.getString("sawon_gen") %></sawon_gen>
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