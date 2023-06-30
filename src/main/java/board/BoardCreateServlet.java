package board;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class BoardCreateServlet
 */
@WebServlet("/BoardCreateServlet")
public class BoardCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userID");
        BoardDAO boardDao = new BoardDAO();
        
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        long timeInMillis = System.currentTimeMillis();
        Date timeInDate = new Date(timeInMillis);
        String timeInFormat = inputFormat.format(timeInDate);


        
        int ref = boardDao.boardRef(); 
        
        //File
        String saveFolder = request.getSession().getServletContext().getRealPath("/") + "Media/board/";
        String encType = "utf-8";
        int maxSize=10*1024*1024;	
        
        MultipartRequest multi = new MultipartRequest(request,saveFolder,maxSize,encType,new DefaultFileRenamePolicy());

        BoardBean boardBean = new BoardBean();
        
        boardBean.setTitle(multi.getParameter("title"));
        boardBean.setId(userId);
        boardBean.setPassword(multi.getParameter("password"));
        boardBean.setContent(multi.getParameter("content"));
        boardBean.setSrc(multi.getFilesystemName("file"));
        boardBean.setWriteDate(timeInFormat);
        boardBean.setReadCount(0);
        boardBean.setRef(ref+1);
        boardBean.setRef_level(0);
        boardBean.setRef_step(0);
        
        int res = boardDao.boardCreate(boardBean);
        if (res == 1) {
        	response.sendRedirect("BoardList.jsp");
        }
        	
	}

}
