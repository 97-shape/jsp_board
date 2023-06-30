<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="card.CardDAO"%>
<%@page import="card.CardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<script src="https://kit.fontawesome.com/23268a4293.js" crossorigin="anonymous"></script>
	
	<title>Practice</title>
	<!-- DB -->
	<%
		BoardBean board = null;
		BoardDAO boardDAO = new BoardDAO();
		String boardNo = request.getParameter("boardNo");
		int board_authority = 0;
		// 비밀글인가? 암호가 일치하는가?를 확인
		try {
			board = boardDAO.boardView(Integer.parseInt(boardNo));
			if (board.getPassword() != null){
				board_authority = (Integer)session.getAttribute("board_authority");
				session.removeAttribute("card_authority");
			}
			else{
				board_authority = Integer.parseInt(boardNo);
			}
		}catch(Exception ex){
			
		}
	%>
    
  </head>
  <body>
    <%@ include file="./templates/header.jsp" %>
	<div style="width: 540px; margin: 4rem auto;">
		<% if (board == null || board_authority != Integer.parseInt(boardNo)) { %>
			<div style="text-align: center">
				<h1>잘못된 접근입니다.</h1>
			</div>
		<%}else {%>
		<h1><%=board.getTitle() %></h1>
		<p class="fs-6"><%=board.getId() %> | <%=board.getWriteDate() %> | 조회수: <%=board.getReadCount() %></p>
		<div style="height: 300px;">
			<p><%=board.getContent() %></p>
		</div>
		<div class="input-group mb-3">
			<% if (board.getSrc() == null) {%>
				<span class="input-group-text">첨부파일</span>
			  	<input class="form-control" disabled>
			  	<a class="btn btn-primary disabled">다운로드</a>
			<%}else{ %>
				<span class="input-group-text">첨부파일</span>
			  	<input class="form-control" value="<%=board.getSrc() %>" readonly>
			  	<a class="btn btn-primary" href="Media/board/<%=board.getSrc() %>" download>다운로드</a>
			<%} %>
		</div>
		<div>
			<%if (board.getId().equals(session.getAttribute("userID"))) {%>
				<form action="BoardDeleteServlet" method="post">
				  	<input type="hidden" name="boardNo" value="<%= boardNo %>">
				  	<input type="hidden" name="boardSrc" value="<%= board.getSrc() %>">
				  	<button type="submit" class="btn btn-danger float-end me-2">삭제</button>
				</form>
				<form action="BoardUpdate.jsp" method="post">
				  	<input type="hidden" name="boardNo" value="<%= boardNo %>">
				  	<button type="submit" class="btn btn-secondary float-end me-2">수정</button>
				</form>
			<%} %>
		</div>
		<% } %>
      </div>
      <%@ include file="./templates/footer.jsp" %>
  </body>
</html>