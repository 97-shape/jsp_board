<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String previousURL = request.getHeader("Referer"); // 이전 주소 저장
    session.invalidate(); // 세션 정보 초기화
    response.sendRedirect(previousURL);
%>