<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pi" value="${map.pi }"/>
<c:set var="list" value="${map.list }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리 페이지</title>
	<!-- css -->
    <link rel="stylesheet" href="resources/css/admin_08_faqManage.css" />
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="../common/header.jsp"/>

    <!-- 왼쪽 수직 navbar -->
    <jsp:include page="../admin/adminNavbar.jsp"/>

    <!-- 결제관리 -->
    <section id="faqList">
      <h2>공지사항 관리</h2>
      <hr />
      <!-- 로그인시에만 보이는 글쓰기 버튼. -->
			<c:if test="${ not empty loginUser }">
				<a class="btn btn-secondary" style="float:right;" href="${contextPath }/enrollForm.bo">작성하기</a>
			</c:if>
      <table class="table table-hover">
        <thead>
          <tr>
            <th scope="col">글번호</th>
            <th scope="col">제목</th>
            <th scope="col">등록날짜</th>
          </tr>
        </thead>
        <tbody>
			<c:if test="${empty list }">
				<tr id="tableEmpty">
					<td colspan="5">목록이 없습니다..</td>
				</tr>
			</c:if>
					
			<c:forEach var="b" items="${list }" >
				<tr onclick="movePage(${b.boardNo});">
					<td>${b.boardNo}</td>
					<td>${b.boardTitle }</td>
					<td>${b.createDate }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

      <c:set var = "url" value="?cpage="/>
      <div aria-label="Page navigation example" class="pagination">
        <ul class="pagination">
          <c:choose>
            <c:when test="${pi.currentPage eq 1 }">
              <li class="page-item disabled" ><a class="page-link" aria-label="Previous" href="#">&laquo;</a></li>
            </c:when>
            <c:otherwise>
              <li class="page-item" ><a class="page-link" aria-label="Previous" href="${url }${pi.currentPage -1 }">&laquo;</a></li>
            </c:otherwise>
          </c:choose>
          
          <c:forEach var="item" begin="${pi.startPage }" end="${pi.endPage }">
          <li class="page-item"><a class="page-link" href="${url }${item }">${item}</a></li>
          </c:forEach>

          <c:choose>
            <c:when test="${pi.currentPage eq pi.maxPage }">
              <li class="page-item disabled"><a class="page-link" aria-label="Next" href="#">&raquo;</a></li>
            </c:when>
            <c:otherwise>
              <li class="page-item"><a class="page-link" aria-label="Next" href="${url }${pi.currentPage +1 }">&raquo;</a></li>
            </c:otherwise>
          </c:choose>
        </ul>
      </div>
	</section>
		
	<script>
	
	function movePage(bno){
 		location.href = "${contextPath}/detail.bo/"+bno;
 	}
	
	$(function(){
        if('${flag}' == 'showAlert'){
       	 Swal.fire({
                icon:'success',
                title: "FAQ 삭제 성공"
          		});
       	}
    });
	 
	 $(function(){
        if('${flag2}' == 'showAlert2'){
       	 Swal.fire({
                icon:'success',
                title: "FAQ 등록 성공"
          		});
       	}
    });
	</script>
</body>
</html>