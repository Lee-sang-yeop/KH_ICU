<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ICU - 자유게시판</title>

<link rel="stylesheet" href="${contextPath }/resources/css/boardDetailView.css" /> 
    
</head>
<body>
   <!-- Navbar -->
    <jsp:include page="../common/header.jsp"/>
    
   <div class="content">
      
      <div class="innerOuter">
         <h2>${b.boardTitle }</h2>
         <div style="float:left; width:300px;">
            <span>
               <c:choose>
                  <c:when test="${!empty b.changeName}">
                     <img id="boardWriter-img" src="${contextPath }${b.filePath }${b.changeName}">
                  </c:when>
                  <c:otherwise>
                     <i class="fa-solid fa-user fa-lg profileImg"></i>
                </c:otherwise>
               </c:choose>
            </span>
          
            <span id="writer" class="form-control" name="memNickname">${b.boardWriter}</span>
            <input type="hidden" name="boardWriter" value="${loginUser.memNo}">
         </div>
         <div style="float:right;">
            <c:if test="${not empty loginUser && loginUser.memNickname eq b.boardWriter }">
               <a class="btn btn-primary boardBtn" href="${contextPath}/enrollForm?mode=update&bno=${b.boardNo}">수정하기</a>
               <a class="btn btn-danger boardBtn2" href="${contextPath}/delete?bno=${b.boardNo }">삭제하기</a>
            </c:if>
         </div>
         <br><br>
         
         <table id="contentArea" class="table">
            
            <tr>
               <td colspan="3">
               
               </td>
            </tr>
            <tr>
               <td colspan="4"><p style="height:400px;">${b.boardContent }</p></td>
            </tr>
         </table>
         <br>
         
         <div align="center">
         <c:choose>
         	<c:when test="${loginUser.role eq 'A' }">
            	<a class="btn btn-primary boardBtn3" href="${contextPath }/admin/noticeList.bo">목록으로</a>
            </c:when>
            <c:otherwise>
            	<a class="btn btn-primary boardBtn3" href="${contextPath }/list.bo">목록으로</a>
            </c:otherwise>
         </c:choose>
         </div>
         <br><br>
         
         <!-- 댓글등록기능 -->
         
         <div class="card mb-2">
            <div class="card-header bg-light">
                    <i class="fa fa-comment" style='color:yellowgreen;'></i> <span style='font-family:"Poor Story", "cursive"; font-weight:bold;'>REPLY</span>
            </div>
            <div class="card-body">
               <ul class="list-group list-group-flush">
                   <li class="list-group-item">
                  <textarea maxlength="100" name="replyContent" id="replyContent" rows="3" placeholder="내용을 입력해주세요"; style="resize: none;"></textarea>
                  <c:if test="${not empty loginUser}">
                  <button type="button"  class="btn btn-dark mt-3" onClick="insertReply();">댓글 입력</button>
                  </c:if>
                   </li>
               </ul>
            </div>
         </div>
         <br><br>
         <table id="replyArea" class="table" align="center">
            <thead>
               <tr>
                  <td colspan="3"><b>댓글(${list.size()})</b></td>
               </tr>
            </thead>
            <tbody>
              <c:forEach var="r" items="${list }" varStatus="i">
				<tr style='border-top: 1px solid #dee2e6;'>
               <td style="width: 50px;">
               <c:choose>
                  <c:when test="${!empty r.changeName}">
                     <img id="replyWriter-img" src="${contextPath }${r.filePath }${r.changeName}">
                  </c:when>
                  <c:otherwise>
                     <i class="fa-solid fa-user fa-lg"></i>
                </c:otherwise>
               </c:choose>
               </td>
               		<td id="rWriter">${r.replyWriter }</td>
					<td id="rContent">${r.replyContent }</td>
					<td id="rDate">${r.createDate }</td>
					<td><input type="hidden" id="rno" value="${r.replyNo }"/></td>
					<c:if test="${r.replyWriter == loginUser.memNickname }">
					<%-- <td><button type='button' class='btn btn-danger' data-bs-toggle='modal' id="replyUpdate" data-bs-target='#exampleModal' data-rno="${r.replyNo }">삭제</button></td> --%>
					<td><button type='button' class='btn btn-danger'  id="replyUpdate"  onclick="location.href='${contextPath}/deleteReply.bo?rno=${r.replyNo }&boardNo=${b.boardNo}'">삭제</button></td>
					</c:if>
				</tr>
			</c:forEach>
               
            </tbody>
         </table>
         

            <script>
            const replyWriterNo = "${loginUser.memNo}";
            const replyWriter = "${loginUser.memNickname}";
            const boardWriter = "${b.boardWriter}";
            const boardNo = "${b.boardNo}";
            const boardWriterNo = "${b.boardWriterNo}";	
            
               function insertReply(){
                  $.ajax({
                     url : "${contextPath}/insertReply.bo",
                     data : {
                        refTno : ${empty b.boardNo ? "" : b.boardNo},
                        replyContent : $("#replyContent").val()
                     },
                     type : "post",
                     success : function(result){
                        $("#replyContent").val("");
                        if(result == "1"){
                        	console.log("reply::socket>>", socket);
                        	
                        	if(socket){
                        		if(replyWriter != boardWriter ){
                        		let socketMsg = "reply,"+replyWriterNo + "," + replyWriter + "," + boardWriter + "," +boardWriterNo + "," + boardNo;
                        		console.log("sssssssmsg>>", socketMsg);
                        		// websocket에 보내기!! (reply, 댓글작성자, 게시글 작성자, 게시글 번호)
                        		socket.send(socketMsg)                        			
                        		}
                        	}
                        	
                           Swal.fire({
                                   icon:'success',
                                   title: "댓글등록 성공"
                             }).then(function(){
                            	 location.href=contextPath+"/detail/"+boardNo;
                             })
                           
                        }else{
                           Swal.fire({
                                   icon:'error',
                                   title: "댓글등록 실패"
                             });
                        }
                     },
                     complete : function(){
                        $("#replyContent").val("");
                     }
                  });
               }
         
              
               
         $('#btnSend').on('click', function(evt){
        	 evt.preventDefault();
        	 if(socket.readyState !== 1) return;
        	 
        	 let msg = $("textarea#replyContent").val();
        	 console.log(msg);
        	 socket.send(msg);
         });
         
         $(function () {
            switch ("${flag}") {
               case 'showAlert1':
               Swal.fire({
                     icon:'success',
                     title: "댓글삭제 성공"
                     }); break;

               case 'showAlert2':
               Swal.fire({
                     icon:'error',
                     title: "댓글삭제 실패"
                     }); break;
            }
         });
         </script>
         
         
            
      </div>
   </div>
   
   <!-- 실시간 문의 -->
   <jsp:include page="../common/chatForm.jsp"/>
   
</body>
</html>