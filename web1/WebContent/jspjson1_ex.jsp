<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
   pageEncoding="UTF-8"%>

{"sawon": [
<%
   /* 이 안은 자바!  xml을 DB에서 불러서 사용하는 방법 실습*/
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
      conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
      pstmt = conn.prepareStatement("select sawon_no, sawon_name,sawon_jik, sawon_gen,buser_name,buser_tel from sawon left outer join buser on buser_no = buser_num");
      
      rs = pstmt.executeQuery();
      while (rs.next()) {
         result += "{";
         result += "\"sawon_no\":" + "\"" + rs.getString("sawon_no") + "\",";
         result += "\"sawon_name\":" + "\"" + rs.getString("sawon_name") + "\",";
         result += "\"sawon_jik\":" + "\"" + rs.getString("sawon_jik") + "\",";
         result += "\"sawon_gen\":" + "\"" + rs.getString("sawon_gen") + "\",";
         result += "\"buser_name\":" + "\"" + rs.getString("buser_name") + "\",";
         result += "\"buser_tel\":" + "\"" + rs.getString("buser_tel") + "\"";
         
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

]}
