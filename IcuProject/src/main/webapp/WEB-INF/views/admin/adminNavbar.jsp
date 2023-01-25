<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<!-- css -->
    <link rel="stylesheet" href="${contextPath}/resources/css/admin_main.css" />
</head>
<body>
	<!-- 왼쪽 수직 navbar -->
    <section id="vertical-navbar">
      <div class="navbar-container">
        <div class="member__manage">
          <h2>회원 정보 관리</h2>
          <ul>
            <li><a href="admin_01_manageMember.html">회원정보조회</a></li>
            <li><a href="admin_02_blackList.html">블랙리스트 관리</a></li>
          </ul>
          <hr />
        </div>
        <div class="party__manage">
          <h2>파티 관리</h2>
          <ul>
            <li><a href="admin_03_currentParty.html">진행중인 파티</a></li>
            <li><a href="admin_04_endParty.html">종료된 파티</a></li>
          </ul>
          <hr />
        </div>
        <div class="contents__manage">
          <h2><a href="admin_05_contentsManage.html">컨텐츠 관리</a></h2>
          <hr />
        </div>
        <div class="faq__manage">
          <h2><a href="${contextPath }/faqList.fq">FAQ 관리</a></h2>
          <hr />
        </div>
        <div class="pay__manage">
          <h2><a href="admin_07_payManage.html">결제 관리</a></h2>
          <hr />
        </div>
        <div class="inquiry__manage">
          <h2><a href="${contextPath }/chat/chatRoomList">실시간 문의</a></h2>
        </div>
      </div>
    </section>
</body>
</html>