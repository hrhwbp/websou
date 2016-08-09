<?xml version = "1.0" encoding = "utf-8" ?>
<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<gogektable>
<%
request.setCharacterEncoding("utf-8");
String sawon_no = request.getParameter("sawon_no");
String sawon_name = request.getParameter("sawon_name");
System.out.println(sawon_no + " " + sawon_name);

//out.print(irum + "님의 나이는 " + nai); //9번라인과 같은 의미
//<%=irum + "님의 나이는 " + nai//% >

Connection conn = null;   
PreparedStatement pstmt = null;
ResultSet rs = null;
//String result = "";
try {
   Class.forName("oracle.jdbc.driver.OracleDriver");
} catch (Exception e) {
   System.out.println("Connection Error : " + e);
   return;
}

try {
   conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
   pstmt = conn.prepareStatement("select gogek_name, gogek_tel, case when gogek_jumin like '%-1%' then '남' when gogek_jumin like '%-2%' then '여' end as gogek_gen from gogek left outer join sawon on gogek_damsano = sawon_no where sawon_no = ? and sawon_name = ? ");
   pstmt.setString(1, sawon_no);
   pstmt.setString(2, sawon_name);
   rs = pstmt.executeQuery();
   
   while(rs.next()){
%>
		<gogek>
			<gogek_name><%=rs.getString("gogek_name") %></gogek_name>
			<gogek_tel><%=rs.getString("gogek_tel") %></gogek_tel>
			<gogek_gen><%=rs.getString("gogek_gen") %></gogek_gen>			
		</gogek>	
<%			
	
    
   }
	rs.close();
	pstmt.close();
	conn.close();
}catch(Exception e2){
	System.out.println("오류: " + e2);
}

%>
</gogektable>