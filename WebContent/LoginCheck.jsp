<%@page import="encrypter.EncryptPassword"%>
<%@ page import="user.UserDAO" %>

<%
EncryptPassword encryptPw = new EncryptPassword();

request.setCharacterEncoding("UTF-8"); // 글자 깨짐 방지
String userID = request.getParameter("id");
String userPassword = request.getParameter("pw");
String encrypteUserPassword = encryptPw.encryptPassword(userPassword);

UserDAO userDAO = new UserDAO();
int loginResult = userDAO.login(userID, encrypteUserPassword);

if (loginResult == 1) {
    // 로그인 성공
    session.setAttribute("userID", userID); // 세션에 사용자 아이디 저장
    session.setAttribute("userName", userDAO.username(userID)); // 세션에 사용자 이름 저장
    response.sendRedirect("Main.jsp"); // 로그인 후 이동할 페이지
} else {
    // 로그인 실패
    response.sendRedirect("Login.jsp?loginFailed=true"); // get방식으로 파라미터를 보내 로그인 실패를 전송해준다.
}
%>
