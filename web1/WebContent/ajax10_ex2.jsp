<?xml version = "1.0" encoding = "utf-8" ?>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<gogek>
<%
request.setCharacterEncoding("utf-8");
String sName = request.getParameter("sName");
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
	pstmt = conn.prepareStatement("select gogek_no, gogek_name, gogek_jumin, gogek_tel from gogek left outer join sawon on gogek_damsano = sawon_no where sawon_name = ? order by gogek_no");
	pstmt.setString(1, sName);
	rs = pstmt.executeQuery();
	System.out.println(rs.next());
	
	while(rs.next()){
%>
	<gogek_show>		
		<gogek_no><%=rs.getString(1)%></gogek_no>
		<gogek_name><%=rs.getString(2)%></gogek_name>
		<gogek_jumin><%=rs.getString(3)%></gogek_jumin>
		<gogek_tel><%=rs.getString(4)%></gogek_tel>		
	</gogek_show>		
<%			
	}
	rs.close();
	pstmt.close();
	conn.close();
}catch(Exception e2){
	System.out.println("오류: " + e2);
}
%>
</gogek>
