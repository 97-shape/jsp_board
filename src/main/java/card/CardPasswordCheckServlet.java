package card;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

/**
 * Servlet implementation class CardPasswordCheckServlet
 */
@WebServlet("/CardPasswordCheckServlet")
public class CardPasswordCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		CardDAO cardDao = new CardDAO();

		int cardNo = Integer.parseInt(request.getParameter("no"));
		String enteredPassword = request.getParameter("pw");
		String correctPassword = cardDao.cardPasswordCheck(cardNo); 
		
		if (enteredPassword.equals(correctPassword)) {
			session.setAttribute("card_authority", cardNo);
			response.sendRedirect("CardView.jsp?cardNo=" + cardNo);
		}
	}

}
