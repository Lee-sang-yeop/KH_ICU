<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 일반 게시판 리스트 -->
<c:set var="list" value="${map.list }"/>

<!-- 공지사항 리스트 -->
<c:set var="notice" value="${map.notice }"/>

<!-- 페이징처리 -->
<c:set var="pi" value="${map.pi }"/>

<c:if test="${!empty param.condition }">
	<c:set var="sUrl" value="&condition=${param.condition}&keyword=${param.keyword }"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="${contextPath}/resources/css/07_boardList.css" />

<title>ICU - 자유게시판</title>

    <!-- css -->
    <link rel="stylesheet" href="resources/css/07_boardList.css" />
 
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
</head>
<body>
	<!-- Navbar -->
	<jsp:include page="../common/header.jsp"/>
	
	<div class="content">
		<br><br>
		<div class="innerOuter" style="padding: 5% 10%;">
			<h2 class='titleText'>< 자유게시판 ></h2>
			
			<!-- 로그인시에만 보이는 글쓰기 버튼. -->
			<c:if test="${ not empty loginUser }">
				<a class="btn btn-secondary" style="float:right; margin-right:20px;" href="${contextPath }/enrollForm">글쓰기</a>
			</c:if>
			<br><br>
			<div class='table-container'>
			<table id="boardList" class="table table-hover" align="center">
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					
					<c:forEach var="n" items="${notice }">
						<tr onclick="movePage(${n.boardNo });">
							<td class="bno notice"><i class="bi bi-exclamation-triangle-fill"></i> 공지사항</td>
							<td>${n.boardTitle }</td>
							<td>${n.boardWriter }</td>
							<td>${n.createDate }</td>
							<td>${n.count}</td>
						</tr>
					</c:forEach>
					
					<c:if test="${empty list }">
						<tr id="tableEmpty">
							<td colspan="5">게시글이 없습니다.</td>
						</tr>
					</c:if>
					
					<c:forEach var="b" items="${list }" >
					<tr onclick="movePage(${b.boardNo });">
						<td class="bno">${b.boardNo }</td>
						<td>${b.boardTitle }</td>
						<td>${b.boardWriter }</td>
						<td>${b.createDate }</td>
						<td>${b.count}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>			
			
			<!-- 
				게시글 클릭했을때 게시글 상세보기화면으로 이동하는 스크립트 구현.
			 -->			
			<script>
			
			function movePage(bno){
		 		location.href = "${contextPath}/detail/"+bno;
		 	}

			</script>
			
			
			<!-- 검색 기능 구현 -->
			<br clear="both"><br>
			<form id = "searchForm" method="get" align="center">
				<div class="select">
					<select class="custom-select pl" name="condition">
						<option value="title">제목</option>
						<option value="writer">작성자</option>
						<option value="content">내용</option>
						
					</select>
				</div>
				<div class="text">
					<input type="text" class="formControl" name="keyword">
				</div>
				<button type="submit" class="searchBtn btn btn-secondary" style=" border:none; font-family:'Poor Story', 'cursive';">검색</button>
			</form>
			<br><br><br><br>

			<c:set var = "url" value="?cpage="/>
			<!-- 페이지 이동기능 구현 -->
			<div id="pagingArea">
				<ul class="pagination">
					<c:choose>
						<c:when test="${pi.currentPage eq 1 }">
							<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" href="${url }${pi.currentPage -1 }${sUrl}">&laquo;</a></li>
						</c:otherwise>
					</c:choose>
					
					<c:forEach var="item" begin="${pi.startPage }" end="${pi.endPage }">
						<li class="page-item"><a class="page-link" href="${url }${item }${sUrl}">${item}</a></li>
					</c:forEach>
					
					<c:choose>
						<c:when test="${pi.currentPage eq pi.maxPage }">
							<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" href="${url }${pi.currentPage +1 }${sUrl}">&raquo;</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
		<br><br>
	
	</div>
	
	<!-- 실시간 문의 -->
    <jsp:include page="../common/chatForm.jsp"/>
    
	<script>
		$(function () {
			switch ("${flag}") {
				case 'showAlert1':
					Swal.fire({
						icon: 'success',
						title: "게시글 삭제 성공"
					});
					break;
				case 'showAlert2':
					Swal.fire({
						icon: 'success',
						title: "게시글 등록 성공"
					});
					break;
				case 'showAlert3':
					Swal.fire({
						icon: 'error',
						title: "게시글 등록 실패"
					});
					break;
				case 'showAlert4':
					Swal.fire({
						icon: 'error',
						title: "상세조회 실패"
					});
					break;
				case 'showAlert5':
					Swal.fire({
						icon: 'error',
						title: "게시글 삭제 실패"
					});
					break;
			}
		});
	</script>
	
</body>
</html>