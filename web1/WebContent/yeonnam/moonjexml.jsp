<?xml version = "1.0" encoding = "utf8" ?>
<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/xml; charset=UTF-8"
	pageEncoding="UTF-8"%>
<sawons> 
<%	
	request.setCharacterEncoding("utf-8");
	String gen = request.getParameter("gen");
	System.out.println(gen);
 	Connection conn = null;
 	PreparedStatement pstmt = null;
 	ResultSet rs = null;
 	try{
 		Class.forName("oracle.jdbc.driver.OracleDriver");
 		
 	}catch(Exception e){
 		System.out.println("연결 오류 : " + e);
 		return;
 	}
 	
 	try{
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
 		while(rs.next()){
%>		
			<sawon>
				<gname><%= rs.getString("gogek_name")%></gname>
				<gtel><%= rs.getString("gogek_tel")%></gtel>
				<sname><%= rs.getString("sawon_name")%></sname>
				<btel><%= rs.getString("buser_tel")%></btel>
			</sawon>
<%
 		}
 		
 		rs.close();
 		pstmt.close();
 		conn.close();
 	}catch(Exception e2){
 		System.out.println("에러 : " + e2);
 	}
 	
%> 
</sawons>

<!-- <"%"내용 "%"> 자바로 표현 . -->













