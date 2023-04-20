<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<title>학생 조회하기~</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style>
table {border-collapse: collapse;}
th {font-weight:bold}
th, td {padding:5px; border:1px solid #000;}
</style>
</head>
<body>
<table>
	<thead>
		<tr>
			<th>STUD_NUM</th>
			<th>STUD_NAME</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="result" items="${resultList}">
			<tr>
				<td><c:out value="${result.studNum}"/></td>
				<td>
					<c:url var="viewUrl" value="/stud/select.do">
						<c:param name="studNum" value="${result.studNum}"/>
					</c:url>
					<a href="${viewUrl}"><c:out value="${result.studName}"/></a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<button type="button" id="btn-reg" data-href="/stud/studRegist.do">등록하기</button>
<script>
$(document).ready(function() {
	//등록하기
	$("#btn-reg").click(function() {
		location.href = $(this).data("href");
	});
});
</script>
</body>
</html>

