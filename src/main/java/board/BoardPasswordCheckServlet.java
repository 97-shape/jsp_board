package board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import encrypter.AES256Encrypt;

/**
 * Servlet implementation class BoardPasswordCheckServlet
 */
@WebServlet("/BoardPasswordCheckServlet")
public class BoardPasswordCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		BoardDAO boardDao = new BoardDAO();

		int boardNo = Integer.parseInt(request.getParameter("no"));
		String enteredPassword = request.getParameter("pw");
		try {
		AES256Encrypt encrypt = new AES256Encrypt("kfZ0UkidP2W33sPrLydthyYm7WM1YnKBqDgfZDZhndQ=");
		
		String correctPassword = encrypt.aesDecode(boardDao.boardPasswordCheck(boardNo)); 
		
		if (enteredPassword.equals(correctPassword)) {
			session.setAttribute("board_authority", boardNo);
			response.sendRedirect("BoardView.jsp?boardNo=" + boardNo);
		}
		}catch(Exception ex){}
	}

}
