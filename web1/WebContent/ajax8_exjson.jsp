<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
   pageEncoding="UTF-8"%>

{"gogekinfo": [
<%
   /* 이 안은 자바!  xml을 DB에서 불러서 사용하는 방법 실습*/
   String gogek_gen = request.getParameter("gogek_gen");
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
	  //System.out.println("@JSON gogek_gen: " + gogek_gen);
      conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
      pstmt = conn.prepareStatement("select gogek_name, gogek_tel, sawon_name, buser_tel from gogek inner join sawon on sawon_no = gogek_damsano left outer join buser on buser_no = buser_num where gogek_jumin like ?");
      pstmt.setString(1,"%-" + gogek_gen + "%");
      rs = pstmt.executeQuery();
      while (rs.next()) {
         result += "{";
         result += "\"gogek_name\":" + "\"" + rs.getString("gogek_name") + "\",";
         result += "\"gogek_tel\":" + "\"" + rs.getString("gogek_tel") + "\",";
         result += "\"sawon_name\":" + "\"" + rs.getString("sawon_name") + "\",";
         result += "\"buser_tel\":" + "\"" + rs.getString("buser_tel") + "\"";
         result += "},";
      }
      if(result.length() > 0){
    	  result = result.substring(0, result.length() - 1);	
      }    
      //out.println("result : " + result);
      out.println(result);
      
      rs.close();
      pstmt.close();
      conn.close();
      
   } catch (Exception e2) {
      System.out.println("Error : " + e2);
   }
   
%>
]}