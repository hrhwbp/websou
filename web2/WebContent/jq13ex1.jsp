<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
   pageEncoding="UTF-8"%>

[
<%
   /* 이 안은 자바!  JSON을 DB에서 불러서 사용하는 방법 실습*/
   String buser = request.getParameter("buser");
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
      pstmt = conn.prepareStatement("select sawon_no, sawon_name, sawon_jik, count(gogek_name) as gogek_count from sawon left outer join gogek on sawon_no = gogek_damsano left outer join buser on buser_no = buser_num where buser_name = ? group by sawon_no, sawon_name, sawon_jik order by sawon_no");
      pstmt.setString(1, buser);
      rs = pstmt.executeQuery();
      while (rs.next()) {
         result += "{";
         result += "\"sawon_no\":" + "\"" + rs.getString("sawon_no") + "\",";
         result += "\"sawon_name\":" + "\"" + rs.getString("sawon_name") + "\",";
         result += "\"sawon_jik\":" + "\"" + rs.getString("sawon_jik") + "\",";
         result += "\"gogek_count\":" + "\"" + rs.getString("gogek_count") + "\"";
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