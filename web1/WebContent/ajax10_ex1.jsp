<?xml version = "1.0" encoding = "utf-8" ?>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<sawonNameTable>
<%
request.setCharacterEncoding("utf-8");
String year = request.getParameter("year");
System.out.println(year);
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
	pstmt = conn.prepareStatement("select sawon_name from sawon where to_char(sawon_ibsail, 'yyyy') = ? order by sawon_name");
	pstmt.setString(1, year.trim());
	rs = pstmt.executeQuery();
	
	while(rs.next()){
		System.out.println(rs.getString(1));
%>
	<sawon_show>		
		<sawon_name><%=rs.getString(1)%></sawon_name>		
	</sawon_show>		
<%			
	}
	rs.close();
	pstmt.close();
	conn.close();
}catch(Exception e2){
	System.out.println("오류: " + e2);
}
%>
</sawonNameTable>
