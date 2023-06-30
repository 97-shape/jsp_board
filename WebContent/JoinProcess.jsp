<%@page import="encrypter.EncryptPassword"%>
<%@page import="user.UserBean"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	UserDAO userDAO = new UserDAO();
	EncryptPassword encryptPw = new EncryptPassword();

	request.setCharacterEncoding("UTF-8"); // 글자 깨짐 방지
	String userID = request.getParameter("id");
	if (userDAO.isUniqueId(userID) == 1){
		String userPassword = request.getParameter("pw");
		// 비밀번호 확인이랑 일치할 때
		if (userPassword.equals(request.getParameter("confirm"))){
			String userName = request.getParameter("name");
			String encrypteUserPassword = encryptPw.encryptPassword(userPassword); 
			
			// 유저 빈 생성
			UserBean user = new UserBean(userID, encrypteUserPassword, userName);
			
			int joinResult = userDAO.join(user);
			if (joinResult == 1) {
			    // 회원가입 성공
			    response.sendRedirect("Login.jsp"); // 회원가입 후 이동할 페이지
			}
		}else {
			response.sendRedirect("Join.jsp?joinFailed=password");
		}
	}else {
		response.sendRedirect("Join.jsp?joinFailed=id");
	}
%>