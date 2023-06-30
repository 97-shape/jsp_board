package board;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import card.CardDAO;

/**
 * Servlet implementation class BoardDeleteServlet
 */
@WebServlet("/BoardDeleteServlet")
public class BoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		
		String fpath = request.getSession().getServletContext().getRealPath("/") + "Media/board/" + request.getParameter("boardSrc");

		File fileObj = new File(fpath);
		
		System.out.println(fpath);
		System.out.println(fileObj.exists());

		if( fileObj.exists() ) {
		    fileObj.delete();   
		}
		
		BoardDAO boardDao = new BoardDAO();
		
		int result = boardDao.boardDelete(boardNo);
        if (result == 1) {
        	response.sendRedirect("BoardList.jsp"); // 적절한 완료 페이지 경로로 변경해주세요
        }
	}

}
