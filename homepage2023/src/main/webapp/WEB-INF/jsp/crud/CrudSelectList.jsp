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
<title>데이터 가져오기~</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<!-- BBS Style -->
<link href="/asset/BBSTMP_0000000000001/style.css" rel="stylesheet" />
<!-- 공통 Style -->
<link href="/asset/LYTTMP_0000000000000/style.css" rel="stylesheet" />


<!-- content 시작 -->
<div id="content">
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
					<table class="list_table">
						<thead>
							<tr>
								<th class="num" scope="col">ID</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">작성일</th>
								<th scope="col">관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}">
								<tr>
									<td><c:out value="${result.crudId}"/></td>
									<td>
										<c:url var="viewUrl" value="/crud/select.do">
											<c:param name="crudId" value="${result.crudId}"/>
										</c:url>
										<a href="${viewUrl}"><c:out value="${result.crudSj}"/></a>
									</td>
									<td><c:out value="${result.userNm}" /></td>
									<td><fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/></td>
									<td>
										<c:url var="delUrl" value="/crud/delete.do">
											<c:param name="crudId" value="${result.crudId}"/>
										</c:url>
										<a href="${delUrl}" class="btn spot btn-del">삭제</a>
									</td>
								</tr>
							</c:forEach>
							
							<c:if test="${fn:length(resultList) == 0}">
								<tr class="empty"><td colspan="5">검색 데이터가 없습니다.</td></tr>
							</c:if>
							
							
						</tbody>
					</table>
				</div>
				
				<div id="paging">
					<ul class="paging_align">
						<c:url var="pageUrl" value="/crud/selectList.do?"/>
						<c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pagingParam}"/>
					</ul>
				</div>
			</div>
			<div class="btn-cont ar">
				<a href="/crud/crudRegist.do" class="btn spot"><i class="ico-check-spot"></i> 등록</a>
			</div>
		</div>
	</div>
</div>
	
<script>
$(document).ready(function() {
	$("#btn-reg").click(function() {
		location.href = $(this).data("href");
	});
	
	$(".btn-del").click(function() {
		if(!confirm("삭제하시겠습니까?")){
			return false;
		}
	});
});
</script>
</body>
</html>

