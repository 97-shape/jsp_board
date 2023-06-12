<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%!
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
    
<%

	String pageStr = request.getParameter("page");
	String pageSizeStr = request.getParameter("size");
	
	if (pageStr == null) {
		pageStr = "1";
	}
	
	if (pageSizeStr == null) {
		pageSizeStr = "10";
	}
	
	int currPage = Integer.parseInt(pageStr);
	int pageSize = Integer.parseInt(pageSizeStr);
	int start = (currPage - 1) * pageSize;
	int end = currPage * pageSize;
	
	List<BoardBean> boardList = null;  // 그냥 선언만 해주면 오류 발생
	
	// BoardDAO 인스턴스 생성
	BoardDAO boardDAO = new BoardDAO();
	int count = boardDAO.boardCount();
	
	if (count > 0) {
		// 게시글 목록 가져오기
		boardList = boardDAO.boardListGet(start, end);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
</head>
<body>
	<%-- include를 이용한 header및 footer 가져오기 --%>
	<%@ include file="./templates/header.jsp" %>
	<div style="max-width: 720px; margin: 4rem auto; text-align: center">
		<h1>게시판 목록</h1>
		<% if (count == 0) { %>
			<table>
				<tr>
				    <td align="center">
				              게시판에 저장된 글이 없습니다.
				    </td>
				</tr>
			</table>
		<% } else {%>
	    <table>
	        <thead>
	            <tr>
	                <th>제목</th>
	                <th>작성자</th>
	            </tr>
	        </thead>
	        <tbody>
	            <% for (BoardBean board : boardList) { %>
		        <tr>
		            <td><%= board.getId() %></td>
		            <td><%= board.getTitle() %></td>
		            <!-- 필요한 열들 추가 -->
		        </tr>
		        <% } %>
	        </tbody>
	    </table>
	    <% } %>
	    <ul class="pagination" style="justify-content: center;">
		<%
			if (count > 0) {
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				int startPage = 1;
		
				if (currPage % 10 != 0)
					startPage = (int) (currPage / 10) * 10 + 1;
				else
					startPage = ((int) (currPage / 10) - 1) * 10 + 1;
		
				int pageBlock = 10;
				int endPage = startPage + pageBlock - 1;
				if (endPage > pageCount)
					endPage = pageCount;
		
				if (startPage - pageBlock > 0) {
					int prevPage = startPage - pageBlock;
					%>
					<li class="page-item"><a class="page-link" href="BoardList.jsp?pageNum=<%= prevPage %>&pageSize=<%= pageSize %>">[이전]</a></li>
					<%
				}
		
				for (int i = startPage; i <= endPage; i++) {
					%>
					<li class="page-item"><a class="page-link" href="BoardList.jsp?pageNum=<%= i %>&pageSize=<%= pageSize %>">[<%= i %>]</a></li>
					<%
				}
		
				if (endPage < pageCount) {
					int nextPage = startPage + pageBlock;
					%>
					<li class="page-item"><a class="page-link" href="BoardList.jsp?pageNum=<%= nextPage %>&pageSize=<%= pageSize %>">[다음]</a></li>
					<%
				}
			}
		%>
		</ul>
	 </div>
	 <%@ include file="./templates/footer.jsp" %>	
</body>
</html>