<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>Summernote with Bootstrap 4</title>
    <%-- jquery 및 summernote 설치 --%>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
	<%-- bootstrap 4.4.1버전에 최적화 --%>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    
    <script type="text/javascript">
        /* summernote에서 이미지 업로드시 실행할 함수 */
	 	function sendFile(file, editor) {
            // 파일 전송을 위한 폼생성
	 		data = new FormData();
	 	    data.append("uploadFile", file);
	 	    $.ajax({ // ajax를 통해 파일 업로드 처리
	 	        data : data,
	 	        type : "POST",
	 	        url : "./summernote_imageUpload.jsp",
	 	        cache : false,
	 	        contentType : false,
	 	        processData : false,
	 	        success : function(data) { // 처리가 성공할 경우
                    // 에디터에 이미지 출력
	 	        	$(editor).summernote('editor.insertImage', data.url);
	 	        }
	 	    });
	 	}
	</script>
  </head>
  <body>
	<%@ include file="./templates/header.jsp" %>
	<%@ include file="./templates/footer.jsp" %>
	<div style="max-width: 720px; margin: 4rem auto;">
		<form action="BoardCreateAction.jsp" method="post" action="./summernote_insert.jsp" class="mb-3">
			<div class="mb-3">
				<div class="input-group">
	    			<input type="text" class="form-control" name="title" aria-describedby="basic-addon3 basic-addon4" placeholder="제목">
	  			</div>
			</div>
	    	<textarea id="summernote" name="content"></textarea>
	    	<div class="text-center">
	    		<input type="submit" class="btn btn-dark rounded-pill col-6 mt-3" value="작성">
	    	</div>
		</form>
    </div>
    <script>
    $(document).ready(function() {
    	$('#summernote').summernote({
            placeholder: '여기에 게시글 작성',
            tabsize: 2,
            height: 400,
            callbacks: { // 콜백을 사용
                // 이미지를 업로드할 경우 이벤트를 발생
			    onImageUpload: function(files, editor, welEditable) {
				    sendFile(files[0], this);
				}
			}
          });
    	});
    </script>
  </body>
</html>