<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
      crossorigin="anonymous"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
      integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
      crossorigin="anonymous"
    ></script>

    <!-- animate.css -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
    />

    <!-- 웹사이트에 아이콘 추가 -->
    <link rel="icon" type="image/png" href="resources/images/navbarLogo.png" />

    <!-- Font Awesome cdn -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
      integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />

    <!-- Google Fonts -->
    <link
      href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap"
      rel="stylesheet"
    />

    <!-- css -->
<!--     <link rel="stylesheet" href="resources/css/05_enrollForm2.css" /> -->

    <!-- jQuery -->
    <script
      src="https://code.jquery.com/jquery-3.6.1.min.js"
      integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
      crossorigin="anonymous"
    ></script>

    <!-- Alert 창  -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<style>
	#enrollForm>div{width:100%;}


</style>
</head>
<body>
	<!-- Navbar -->
    <jsp:include page="../common/header.jsp"/>
    
	<!-- Logo -->
    <div id="main__logo">
      <img src="resources/images/navbarLogo.png" />
    </div>
	<br><br>
	<div class="content">
		<br><br>
		<div class="innerOuter" >
			<c:choose>
				<c:when test="${b.boardNo eq null}">
					<h2>게시글 작성하기</h2>
				</c:when>
				<c:otherwise>
					<h2>게시글 수정하기</h2>
				</c:otherwise>
			</c:choose>
			<br>
			<form id="enrollForm" action="${contextPath }/insert.bo">
				<div >
					<div>
						<label for="title">제목 : </label>
						<input type="text" id="title" class="form-control" name="boardTitle" value="${b.boardTitle } " required>
					</div>
					<hr>
					<div>
						<label for="writer">작성자 : </label>
						<input type="text" id="writer" class="form-control" value="${loginUser.memNickname}" name="memNickname" readonly>
						<input type="hidden" name="boardWriter" value="${loginUser.memNo}">
					</div>
					<br>
					<div>
						<textarea id="content" style="resize:none;" cols="50" rows="20" class="form-control" name="boardContent" placeholder="내용을 입력해주세요." required></textarea>
					</div>
					<br>
				<input type="hidden" name="mode" value="${param.mode }"/>
				<input type="hidden" name="boardNo" value="${empty b.boardNo ? 0 : b.boardNo}"/>
				
				<div align="center">
					<a href="${contextPath }/list.bo" class="btn btn-danger">취소하기</a>
					<c:choose>
						<c:when test="${b.boardNo eq null}">
							<button type="submit" class="btn btn-primary">등록하기</button>
						</c:when>
						<c:otherwise>
							<button type="submit" class="btn btn-primary">수정하기</button>
						</c:otherwise>
					</c:choose>	
				</div>
			</form>
			
			
		</div>
	
	</div>

	
		
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>