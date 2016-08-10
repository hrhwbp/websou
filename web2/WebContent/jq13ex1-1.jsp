<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
   pageEncoding="UTF-8"%>

[
<%
   /* 이 안은 자바!  JSON을 DB에서 불러서 사용하는 방법 실습*/
   String sName = request.getParameter("sName");
   Connection conn = null;   
   PreparedStatement pstmt = null;
   ResultSet rs = null;	
   String result = "";
   try {
      Class.forName("oracle.jdbc.driver.OracleDriver");
   } catch (Exception e) {
      System.out.println("Connection Error : " + e);
      return;
   }

   try {
	  //System.out.println(buser);
      conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
      pstmt = conn.prepareStatement("select gogek_name, gogek_tel, case when substr(gogek_jumin,8 , 1) = 1 then '남'  when substr(gogek_jumin, 8, 1) = 2 then '여' end as gogek_gen, ((substr(sysdate, 1, 2)+2000) - (substr(gogek.GOGEK_JUMIN, 1, 2)+1900)+1) as gogek_age from gogek left outer join sawon on sawon_no = gogek_damsano where sawon_name = ? order by gogek_no");
      pstmt.setString(1, sName);
      rs = pstmt.executeQuery();
      while (rs.next()) {
         result += "{";
         result += "\"gogek_name\":" + "\"" + rs.getString("gogek_name") + "\",";
         result += "\"gogek_tel\":" + "\"" + rs.getString("gogek_tel") + "\",";
         result += "\"gogek_gen\":" + "\"" + rs.getString("gogek_gen") + "\",";
         result += "\"gogek_age\":" + "\"" + rs.getString("gogek_age") + "\"";
         result += "},";
      }
      if(result.length() > 0){
    	  result = result.substring(0, result.length() - 1);	
      }     
      out.println(result);
      
      rs.close();
      pstmt.close();
      conn.close();
      
   } catch (Exception e2) {
      System.out.println("Error : " + e2);
   }   
%>
]