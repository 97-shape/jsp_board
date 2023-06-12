package card;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

/**
 * Servlet implementation class CardCreateServlet
 */
@WebServlet("/CardCreateServlet")
public class CardCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userID");  // 기본적으론 오브젝트로 반환된다.
        
        CardDAO cardDao = new CardDAO();
        
        // file
        String saveFolder = request.getSession().getServletContext().getRealPath("/") + "Media/card/";//사진을 저장할 경로
        String encType = "utf-8";				//변환형식
        int maxSize=10*1024*1024;				//사진의 size
        
        //파일업로드를 직접적으로 담당 
        System.out.print(saveFolder);
        MultipartRequest multi = new MultipartRequest(request,saveFolder,maxSize,encType,new DefaultFileRenamePolicy());
 
        //form이 encType = "multipart/form-data"으로 보내기 때문에 request가 아닌 multi로 받는다
        CardBean cardBean = new CardBean();
        
        cardBean.setRole(multi.getParameter("role"));
        cardBean.setName(multi.getParameter("name"));
        cardBean.setPhone(multi.getParameter("phone"));
        cardBean.setCompany_number(multi.getParameter("company_phone"));
        cardBean.setEmail(multi.getParameter("email"));
        cardBean.setCompany_address(multi.getParameter("company_address"));
        cardBean.setPassword(multi.getParameter("password"));
        cardBean.setImage(multi.getFilesystemName("image"));
        cardBean.setUserID(userId);
        
        int result = cardDao.cardCreate(cardBean);
        if (result == 1) {
        	response.sendRedirect("CardList.jsp"); // 적절한 완료 페이지 경로로 변경해주세요
        }
        
        
    }
}