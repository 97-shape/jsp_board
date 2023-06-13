package card;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CardDeleteServlet
 */
@WebServlet("/CardDeleteServlet")
public class CardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int cardNo = Integer.parseInt(request.getParameter("cardNo"));
		
		CardDAO cardDao = new CardDAO();
		
		int result = cardDao.cardDelete(cardNo);
        if (result == 1) {
        	response.sendRedirect("CardList.jsp"); // 적절한 완료 페이지 경로로 변경해주세요
        }
	}

}
