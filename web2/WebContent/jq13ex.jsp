<?xml version = "1.0" encoding = "utf-8" ?>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<sangpumtable>
<%
request.setCharacterEncoding("utf-8");
String sang = request.getParameter("sang");
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
System.out.println(sang);
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	
}catch(Exception e){
	System.out.println("연결 오류: " + e);
	return;
}

try{
	
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
	pstmt = conn.prepareStatement("select * from sangdata where sang like ?");	
	pstmt.setString(1, sang + "%");
	rs = pstmt.executeQuery();
	while(rs.next()){
%>
	<sangpums>		
		<code><%=rs.getString("code") %></code>
		<sangpum><%=rs.getString("sang") %></sangpum>
		<su><%=rs.getString("su") %></su>
		<dan><%=rs.getString("dan") %></dan>
	</sangpums>	
<%			
	}
	rs.close();
	pstmt.close();
	conn.close();
}catch(Exception e2){
	System.out.println("오류: " + e2);
}
%>
</sangpumtable>