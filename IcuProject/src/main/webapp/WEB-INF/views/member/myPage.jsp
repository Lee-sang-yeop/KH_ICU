<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ICU - 회원정보 수정</title>

    <!-- css -->
    <link rel="stylesheet" href="resources/css/myPage.css" />

</head>
<body>
	<!-- Navbar -->
    <jsp:include page="../common/header.jsp"/>
    
    <!-- 왼쪽 수직 navbar -->
    <jsp:include page="../member/myNavbar.jsp"/>
    <br><br>
	<!-- Logo -->
    <div id="main__logo" class='animate__animated animate__fadeIn'>
      <img src="resources/images/navbarLogo.png" />
    </div>

    <div id="whole" class='animate__animated animate__fadeIn'>
      <div id="imgAndInfo">
        <div id="viewAndEnroll">
          <div id="view" class="titleImg">
          <!-- 올린 파일이 들어가는 자리 -->
          <c:choose>
          
          <c:when test="${!empty profile}">
          	<img class='viewImg' src="${contextPath }${profile.filePath }${profile.changeName}" onclick="previewClick();">
          </c:when>

          </c:choose>
          </div>
            <form id="enrollForm" action="${contextPath }/img.me" encType="multipart/form-data" method="post">
          <div id="enroll">
          	<c:if test='${empty profile }'>
              <img id="preview" onclick="previewClick();"/> <Br>
             </c:if>

              <input type="file" id="upfile" class="form-control" name="upfile" style="display:none"/>
              <input type="hidden" name="originName" value="${image.originName }"/>
			        <input type="hidden" name="changefile" value="${image.changeName }"/>
              <div class='deleteBtn'>
                <c:if test="${empty profile}">
                    <button id="enrollBtn" type="submit" class="btn btn-primary" disabled>등록하기</button>
                </c:if>
                <c:if test="${!empty profile}">
                  <input type="hidden" id="mode" name="mode" value=""/>                   
                  <input type="hidden" name="profile" value="${profile }"/>  
                  <button id="enrollBtn" type="submit" class="btn btn-primary" disabled onclick="modeUpdate();">수정하기</button>
	                <button id="deleteBtn" type="submit" class="btn btn-danger" onclick="modeDelete();">삭제하기</button>
                </c:if>
              </div>
          </div>
            </form>
        </div>
        <div id="info">
          <h4><span class="info">${loginUser.memNickname}</span></h4><br>
          <span class="info">아이디 : </span><span class="info">${loginUser.memId}</span><br><br>
          <c:if test="${loginUser.snsType ne 'G'}">
            <span class="info">이름   : </span><span class="info">${loginUser.memName}</span><br><br>
          </c:if>
          <c:if test="${loginUser.snsType eq 'I'}">
            <span class="info">연락처 : </span><span class="info">${loginUser.phone}</span><br><br>
          </c:if>
          <span class="info">이메일 : </span><span class="info">${loginUser.email}</span><br><br>
          <span class="info">가입일 : </span><span class="info">${loginUser.enrollDate}</span><br><br>
        </div>
		<br>
      </div>
      <!-- <c:choose>
        <c:when test="${loginUser.snsType eq 'I'}">
          <div id="updateButton">
            <a class="btn" href="${contextPath}/memUpdateForm.me">수정하러 가기</a>
          </div>
        </c:when>
        <c:otherwise>
          <div id="updateButton">
            <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <b><span style="color: white; font-weight: bold;">닉네임 수정하기</span></b>
            </button>
          </div>
        </c:otherwise>
      </c:choose> -->
      <c:choose>
        <c:when test="${loginUser.snsType eq 'I'}">
          <div id="updateButton" style="float: right; margin-right: 230px;" >
              <a class="btn" href="${contextPath}/memUpdateForm.me">회원정보 수정하기</a>
          </div>
          <div id="updateButton" style="margin-left: 250px;">
            <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <b><span style="color: white; font-weight: bold;">닉네임 수정하기</span></b>
            </button>
          </div>
        </c:when>
        <c:otherwise>
          <div id="updateButton">
            <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#exampleModal">
              <b><span style="color: white; font-weight: bold;">닉네임 수정하기</span></b>
            </button>
          </div>
        </c:otherwise>
    </c:choose>
      
      
    </div>
    
    <!-- 소셜 로그인 수정 모달 -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">닉네임 수정하기</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form id="memberUpdateNick" action="${contextPath }/memUpdateNick.me" method="post">
              <label>변경할 닉네임 : </label>
              <input type="text" id="memNickname" placeholder="닉네임 입력" name="memNickname" required/>
              <button
              type="button"
              class="btn btn-primary tableBtn"
              onclick="nickCheck();"
            >
              중복확인
            </button>
            </form>
          </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" >취소</button>
              <button type="button" class="btn btn-primary" onclick="btnUpdate();" name="update" disabled>확인</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class='imgBtn'>
    <c:if test="${profile eq null }">
    	<span>* 원을 클릭하여 프로필 이미지를 등록해보세요!</span>
    </c:if>
    </div>
    
    <!-- 실시간 문의 -->
    <jsp:include page="../common/chatForm.jsp"/>
    
    <script>
      function readURL(input) {
    	console.log(input.files[0]);
        if (input.files && input.files[0]) {
          var reader = new FileReader();
          /* var fileInput = document.getElementById("upfile"); */
          reader.onload = function (e) {
        	if($(".viewImg").length > 0){
        		//document.getElementsByClassName('viewImg').src = e.target.result;
        		$('.viewImg').attr('src', e.target.result);
        	}
        	else{
            	//document.getElementById('view').src = e.target.result;
            	$('#preview').attr('src', e.target.result);
        	}
            $("#enrollBtn").attr("disabled", false);
          };
          reader.readAsDataURL(input.files[0]);
        }
      }
	  
      $("#upfile").change(function(){
    	  	console.log($(".viewImg").length);
    	  	console.log($("#upfile").val());
    	  	if($(".viewImg").length > 0 && $("#upfile").val() == ''){
      		//document.getElementsByClassName('viewImg').src = e.target.result;
      			$('.viewImg').attr('src', '');
      		}
      		else if($("#preview").length > 0 && $("#upfile").val() == ''){
          		//document.getElementById('view').src = e.target.result;
          		$('#preview').attr('src', '');
      		}

			readURL(this);
	});
      
      
	  function previewClick(){
		  $("#upfile").click();
	  }
      function modeUpdate() {
        $('#mode').val('update');
      }

      function modeDelete() {
        $('#mode').val('delete');
      }

      function validate() {
        var fileInput = document.getElementById("upfile");
        if (fileInput.val != "") {
          $("#enrollBtn").attr("disabled", false);
        }
      };

      function refreshProfile() {
        location.reload();
      }

//       function deleteBtn() {
//         console.log("${profile.fileNo}");
//         $.ajax({
//           url: "${contextPath}/deleteImg.me",
//           data: {
//             fileNo: "${profile.fileNo}"
//           },
//           type: "post",
//           success: function (result) {
//             if (result == "1") {

//               return "redirect:myPage.me";


//             } else {
//               Swal.fire({
//                 icon: 'error',
//                 title: '프로필 삭제 실패.'
//               });
//             }
//           }

//         });
//         refreshProfile();

//       }

      function btnUpdate() {

        if ($('input[name=memNickname]').val() == "") {
          Swal.fire({
            icon: 'error',
            title: '닉네임을 입력해주세요.'
          });
        } else {
          Swal.fire({
            title: '변경하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            cancelButtonText: '취소',
            confirmButtonText: '수정'
          }).then((result) => {
            if (result.isConfirmed) {
              $("#memberUpdateNick").submit();

            }
          });
        }

      }

      function nickCheck() {
        // 아이디 입력하는 input 요소 객체
        let $memberNick = $("#memberUpdateNick input[name=memNickname]");
        let regExp = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,20}$/;

        $.ajax({
          url: "${contextPath }/nickCheck",
          data: { checkNick: $memberNick.val() },
          success: function (result) {

            if ($memberNick.val() == "") {

              Swal.fire({
                icon: 'error',
                title: '닉네임을 입력해주세요.'

              });

              $memberNick.focus();

            }

            else if (!regExp.test($memberNick.val())) {
              Swal.fire({
                icon: 'error',
                title: '유효한 닉네임을 입력해주세요.'
              });

            } else if (result == 1) { // 사용불가능한 닉네임

              Swal.fire({
                icon: 'error',
                title: '이미 존재하는 닉네임입니다.'

              });
              $memberNick.focus();

            } else {

              Swal.fire({
                title: '사용가능한 닉네임입니다.',
                text: '사용하시겠습니까?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '사용',
                cancelButtonText: '취소'
              }).then((result) => {
                if (result.isConfirmed) {
                  $("input[name=memNickname]").attr("readonly", true);
                  $("button:button[name=update]").attr("disabled", false);
                }

              });
            }
          },
          error: function () {
            alert("닉네임 중복체크용 ajax 통신 실패");
          }
        });
      }

      $(function () {
        switch ("${flag}") {
          case 'showAlert1':
            Swal.fire({
              icon: 'error',
              title: "이미지 등록 실패"
            });
            break;
          case 'showAlert2':
            Swal.fire({
              icon: 'error',
              title: "회원정보 수정 실패"
            });
            break;
          case 'showAlert3':
            Swal.fire({
              icon: 'error',
              title: "닉네임 수정 실패"
            });
            break;
        }
      });

      document.addEventListener('keydown', function(event) {
	      if (event.keyCode === 13) {
	        event.preventDefault();
	      };
       }, true);
    </script>
</body>
</html>