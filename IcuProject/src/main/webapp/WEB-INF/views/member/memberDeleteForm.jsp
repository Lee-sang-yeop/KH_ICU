<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>

    <!-- css -->
    <link rel="stylesheet" href="resources/css/25_memberDeleteForm.css" />


</head>
<body>
  
	<!-- Navbar -->
    <jsp:include page="../common/header.jsp"/>
    
    <!-- 왼쪽 수직 navbar -->
    <jsp:include page="../member/myNavbar.jsp"/>
    
    
  <div id="main__logo" class='animate__animated animate__fadeIn'>
	<h2>회원탈퇴</h2>
  <br>
  </div>

  <div id="whole">
    <div id="content">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      회원 탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.<br><br>
      
      <i class="fa-solid fa-check"></i>&nbsp;&nbsp;사용하고 계신 아이디(<span id="red"><b>${loginUser.memId}</b></span>)는 탈퇴할 경우 재 사용 및 복구가 불가능 합니다.<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <span id="red">탈퇴한 아이디는 본인과 타인 모두 재사용 및 복구가 불가능하오니 신중하게 선택하시기 바랍니다.</span><br><br>

      <i class="fa-solid fa-check"></i>&nbsp;&nbsp;탈퇴 후 회원 정보 및 서비스 이용 기록은 모두 삭제됩니다.<br>

      <i class="fa-solid fa-check"></i>&nbsp;&nbsp;탈퇴 후에도 게시판형 서비스에 등록한 게시물은 그대로 남아 있습니다.<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      삭제를 원하는 게시글이 있다면
      <span id="red">반드시 탈퇴 전 비공개 처리하거나 삭제하시기 바랍니다.</span><br><br>

      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <span id="red">탈퇴 후에는 아이디 <span id="red"><b>${loginUser.memId}</b></span>로 다시 가입할 수 없으며
      아이디와 데이터는 복구할 수 없습니다.<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      게시판형 서비스에 남아 있는 게시글은 탈퇴 후 삭제할 수 없습니다.<br><br>

      <!-- Button trigger modal -->
      <c:choose>
		<c:when test="${loginUser.snsType eq 'N' }">
			<button type="button" class="btn btn-primary" onclick="naverDelete();">
				회원탈퇴
			</button>
		</c:when>
		<c:when test="${loginUser.snsType eq 'K' }">
			<button type="button" class="btn btn-primary" onclick="kakaoDelete();">
				회원탈퇴
			</button>
		</c:when>
		<c:when test="${loginUser.snsType eq 'G' }">
			<button type="button" class="btn btn-primary" onclick="googleDelete();">
				회원탈퇴
			</button>
		</c:when>
		<c:otherwise>
			<button type="button" class="btn btn-primary deleteBtn" data-bs-toggle="modal" data-bs-target="#exampleModal">
				회원탈퇴
			</button>
		</c:otherwise>
	 </c:choose>
    </div>
    <br>

    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-heade">
            <h1 class="modal-title fs-5" id="exampleModalLabel">회원탈퇴</h1>
          </div>
          <div class="modal-body">
            <form id="memberDelete" action="${contextPath }/memDelete.me" method="post">
            <label>비밀번호 입력 : </label>
              <input type="password" id="memPwd" placeholder="비밀번호를 입력해주세요" name="memPwd" required/>
              <!-- <input type="hidden" id="memPwdCheck" value="${member.getMemPwd}"/> -->
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" >취소</button>
            <button type="button" class="btn btn-primary" onclick="btnDelete();" name="delete">확인</button>
          </div>
        </div>
      </div>
    </div>
  </div>

	<!-- 실시간 문의 -->
    <jsp:include page="../common/chatForm.jsp"/>

</body>
<script> 
  $(function () {
        switch ("${flag}") {
          case 'showAlert1':
          Swal.fire({
            icon:'error',
            title: "비밀번호가 일치하지 않습니다."
          }); break;

          case 'showAlert3':
          Swal.fire({
            icon:'error',
            title: "회원 탈퇴 실패하였습니다."
          }); break;
        }
      });
  
  function btnDelete(){
    
    if($('input[name=memPwd]').val() == ""){
           Swal.fire({
              icon: 'error',
              title: '비밀번호를 입력해주세요.'                  
          });
    } else {
      Swal.fire({
              title: '회원탈퇴는 되돌릴 수 없습니다<br>탈퇴하시겠습니까?',
              icon: 'warning',
              showCancelButton: true,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#d33',
              cancelButtonText: '취소',
              confirmButtonText: '탈퇴'
          }).then((result) => {
              if (result.isConfirmed) {
                $("#memberDelete").submit();
                  
              }
          });
    }
    
   }
  
  function naverDelete(){
	  Swal.fire({
          title: '회원탈퇴는 되돌릴 수 없습니다<br>탈퇴하시겠습니까?',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          cancelButtonText: '취소',
          confirmButtonText: '탈퇴'
      }).then((result) => {
          if (result.isConfirmed) {
        	  location.href='${contextPath}/remove';
              
          }
      });
  }
  
  function kakaoDelete(){
	  Swal.fire({
          title: '회원탈퇴는 되돌릴 수 없습니다<br>탈퇴하시겠습니까?',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          cancelButtonText: '취소',
          confirmButtonText: '탈퇴'
      }).then((result) => {
          if (result.isConfirmed) {
        	  location.href='${contextPath}/remove?mode=kakao';
              
          }
      });
  }
  
  function googleDelete(){
	  Swal.fire({
          title: '회원탈퇴는 되돌릴 수 없습니다<br>탈퇴하시겠습니까?',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          cancelButtonText: '취소',
          confirmButtonText: '탈퇴'
      }).then((result) => {
          if (result.isConfirmed) {
        	  location.href='${contextPath}/remove?mode=google';
              
          }
      });
  }
  
  document.addEventListener('keydown', function(event) {
      if (event.keyCode === 13) {
        event.preventDefault();
      };
    }, true);


  </script>
</html>