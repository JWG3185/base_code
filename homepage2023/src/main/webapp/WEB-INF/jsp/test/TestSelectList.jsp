<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<meta name="viewport" content="width=dievice-width,initial-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<title>CRUD 테스트 게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

접속계정 : <c:out value="${USER_INFO.id}"/>, <c:out value="${USER_INFO.name}"/>

<div>
	<a href="/login/login.do" class="btn spot btn-primary">로그인</a>
</div>

<div class="container">
	<div id="contents">
		<%-- 목록영역 --%>
		<div id="bbs_wrap">
			<div class="total">
				총 게시물
				<strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>건  | 
				현재페이지<strong><c:out value="${paginationInfo.currentPageNo}"/></strong>/
				<c:out value="${paginationInfo.totalPageCount}"></c:out>
			</div>
			<div class="bss_list">
				<table class="table table-hover text-center">
					<thead class="table-dark">
						<tr>
							<th class="num" scope="col">ID</th>
							<th class="tit" scope="col">제목</th>
							<th class="writer" scope="col">작성자</th>
							<th class="date" scope="col">작성일</th>
							<th class="hits" scope="col">수정일</th>
							<th class="hits" scope="col">관리</th>
						</tr>
					</thead>
					<tbody>
						<%-- 일반 글 --%>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td><c:out value="${result.testId}"/></td>
								<td class="tit">
									<c:url var="viewUrl" value="/test/select.do">
										<c:param name="testId" value="${result.testId}"/>
									</c:url>
									<a href="${viewUrl}">
										<c:out value="${result.sj}"></c:out>
									</a>
								</td>
								<td><c:out value="${result.userNm}"/></td>
								<td><fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/></td>
								<td><fmt:formatDate value="${result.lastUpdtPnttm}" pattern="yyyy-MM-dd"/></td>
								<td>
									<c:url var="delUrl" value="/test/delete.do">
										<c:param name="testId" value="${result.testId}"/>
									</c:url>
									<a href="${delUrl}" id="btn-del" class="btn btn-outline-danger">삭제</a>
								</td>
							</tr>
						</c:forEach>
						
						<%-- 게시 글이 없을 경우 --%>
						<c:if test="${fn:length(resultList) == 0}">
							<tr class="empty"><td colspan="5">데이터가 없습니다.</td></tr>
						</c:if>
						
					</tbody>
				</table>	
			</div>
			<div id="paging" class="pagination justify-content-center m-1">
				<a href="?pageIndex=1" class="first" title="처음페이지로 이동"><span>처음</span></a>
				<a href="?pageIndex={1}" class="prev" title="이전페이지로 이동"><span>이전</span></a>
				<strong class="current"><c:out value="${pageUrl}"/></strong>
				<a href="?pageIndex={1}" class="page" title="{1}페이지로 이동"><span>{1}</span></a>
				<a href="?pageIndex={1}" class="next" title="다음페이지로 이동"><span>다음</span></a>
				<a href="?pageIndex={1}" class="last" title="마지막페이지로 이동"><span>마지막</span></a>
				<%-- 
				<c:url var="pageUrl" value="/test/selectList.do?"/>
				<c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pagingParam}"/>
				 --%>
			</div>
		</div>
		<div class="mt-2">
			<c:url var="regUrl" value="/test/testRegist.do" />
			<a href="${regUrl}" class="btn spot btn-primary">등록</a>
		</div>
	</div>
</div>

<script>
<c:if test="${not empty message}">
	alert("${message}");
</c:if>

</script>


</body>
</html>