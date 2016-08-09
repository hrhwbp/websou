<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
String sName = request.getParameter("sName");
double kor = Integer.parseInt(request.getParameter("kor"));
double eng = Integer.parseInt(request.getParameter("eng"));

System.out.println(sName + " 학생의 총점 :" + (kor + eng) + " 점" + "평균 : " + (kor + eng)/2);
%>

</body>
</html>