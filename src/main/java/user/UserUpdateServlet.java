package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import encrypter.EncryptPassword;

/**
 * Servlet implementation class UserUpdateServlet
 */
@WebServlet("/UserUpdateServlet")
public class UserUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		
		UserDAO userDAO = new UserDAO();
		EncryptPassword encryptPw = new EncryptPassword();

		request.setCharacterEncoding("UTF-8"); // 글자 깨짐 방지
		
		HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userID");
        
		String userPassword = request.getParameter("pw");
		// 비밀번호 확인이랑 일치할 때
		if (userPassword.equals(request.getParameter("confirm"))){
			String userName = request.getParameter("name");
			String encrypteUserPassword = encryptPw.encryptPassword(userPassword); 
			
			// 유저 빈 생성
			UserBean userBean = new UserBean(userId, encrypteUserPassword, userName);
			
			int joinResult = userDAO.update(userBean);
			if (joinResult == 1) {
			    // 회원가입 성공
			    response.sendRedirect("Main.jsp"); // 회원가입 후 이동할 페이지
			}
		}else {
			//response.sendRedirect("Join.jsp?joinFailed=password");
		}
	}

}
