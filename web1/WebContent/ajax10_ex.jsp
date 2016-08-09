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
	pstmt = conn.prepareStatement("select distinct to_char(sawon_ibsail, 'yyyy')as sawon_ibsail from sawon where to_char(sawon_ibsail, 'yyyy') like ? order by sawon_ibsail");
	pstmt.setString(1, ibsail + "%");
	rs = pstmt.executeQuery();
	
	while(rs.next()){
%>
	<sawon>		
		<sawon_ibsail><%=rs.getString("sawon_ibsail") %></sawon_ibsail>		
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