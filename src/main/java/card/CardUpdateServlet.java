package card;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class CardUpdateServlet
 */
@WebServlet("/CardUpdateServlet")
public class CardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
        
        CardDAO cardDao = new CardDAO();
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userID");
        
        // file
        String saveFolder = request.getSession().getServletContext().getRealPath("/") + "Media/card/";//사진을 저장할 경로
        String encType = "utf-8";				//변환형식
        int maxSize=10*1024*1024;				//사진의 size
        
        //파일업로드를 직접적으로 담당 
        MultipartRequest multi = new MultipartRequest(request,saveFolder,maxSize,encType,new DefaultFileRenamePolicy());
        

        String uploadedFileName =  saveFolder + multi.getParameter("originImg");
        File realFile = new File(uploadedFileName);  //파일객체 생성

        boolean isDel = realFile.delete();
        
        //form이 encType = "multipart/form-data"으로 보내기 때문에 request가 아닌 multi로 받는다
        CardBean cardBean = new CardBean();
        
        cardBean.setCardNo(Integer.parseInt(multi.getParameter("cardNo")));
        cardBean.setRole(multi.getParameter("role"));
        cardBean.setName(multi.getParameter("name"));
        cardBean.setPhone(multi.getParameter("phone"));
        cardBean.setCompany_number(multi.getParameter("company_phone"));
        cardBean.setEmail(multi.getParameter("email"));
        cardBean.setCompany_address(multi.getParameter("company_address"));
        cardBean.setPassword(multi.getParameter("password"));
        if (multi.getFilesystemName("image") == null) {
        	cardBean.setImage(multi.getParameter("originImg"));
        }else {
        	cardBean.setImage(multi.getFilesystemName("image"));
        }
        cardBean.setUserID(userId);
        
        
        int result = cardDao.cardUpdate(cardBean);
        if (result == 1) {
        	response.sendRedirect("CardList.jsp"); // 적절한 완료 페이지 경로로 변경해주세요
        }
	}

}
