<?xml version = "1.0" encoding = "utf-8" ?>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
String gogek_gen = request.getParameter("gogek_gen");
System.out.println(gogek_gen);
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try{
   Class.forName("oracle.jdbc.driver.OracleDriver");

   conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
   String sql = "select gogek_name, gogek_tel, sawon_name, buser_tel from gogek inner join sawon on sawon_no = gogek_damsano left outer join buser on buser_no = buser_num where gogek_jumin like ?";
   pstmt = conn.prepareStatement(sql);
   pstmt.setString(1, "%-" + gogek_gen + "%");
   rs = pstmt.executeQuery();
   
   String ss = "";
   while(rs.next()){
	   ss += "<gogek_name>"+ rs.getString(1)+"</gogek_name><gogek_tel>"+rs.getString(2)+"</gogek_tel><sawon_name>"+rs.getString(3)+"</sawon_name><buser_tel>"+rs.getString(4) + "</buser_tel>";
   }
   
   //out.print(ss);
   //out.print("여기");
   out.print("<ele>");
   out.print("<gogek>"+ss+"</gogek>");
   out.print("</ele>");
   
   rs.close();
   pstmt.close();
   conn.close();
}catch(Exception e2){
   System.out.println("오류: " + e2);
}
%>

