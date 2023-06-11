<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>

<%
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	System.out.println(title + "내용 : " + content);
	
%>