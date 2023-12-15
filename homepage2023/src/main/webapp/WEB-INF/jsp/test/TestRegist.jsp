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
<title>CRUD 테스트 작성</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.tiny.cloud/1/62u72nxq6gmuahsbeykab0krga3rt9khf9uul9v2irleard1/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
<script>
$(function(){
    var plugins = [
        "advlist", "autolink", "lists", "link", "image", "charmap", "print", "preview", "anchor",
        "searchreplace", "visualblocks", "code", "fullscreen", "insertdatetime", "media", "table",
        "paste", "code", "help", "wordcount", "save"
    ];
    var edit_toolbar = ' blocks fontfamily fontsize |' 
    		   + 'formatselect fontselect fontsizeselect |'
               + ' forecolor backcolor |'
               + ' bold italic underline strikethrough |'
               + ' alignjustify alignleft aligncenter alignright |'
               + ' bullist numlist |'
               + ' table tabledelete |'
               + ' link image ';

    tinymce.init({
    language: "ko_KR", //한글판으로 변경
        selector: '#cn',
        height: 500,
        menubar: false,
        plugins: plugins,
        toolbar: edit_toolbar,
        
        /*** image upload ***/
        image_title: true,
        /* enable automatic uploads of images represented by blob or data URIs*/
        automatic_uploads: true,
        /*
            URL of our upload handler (for more details check: https://www.tiny.cloud/docs/configure/file-image-upload/#images_upload_url)
            images_upload_url: 'postAcceptor.php',
            here we add custom filepicker only to Image dialog
        */
        file_picker_types: 'image',
        /* and here's our custom image picker*/
        file_picker_callback: function (cb, value, meta) {
            var input = document.createElement('input');
            input.setAttribute('type', 'file');
            input.setAttribute('accept', 'image/*');

            /*
            Note: In modern browsers input[type="file"] is functional without
            even adding it to the DOM, but that might not be the case in some older
            or quirky browsers like IE, so you might want to add it to the DOM
            just in case, and visually hide it. And do not forget do remove it
            once you do not need it anymore.
            */
            input.onchange = function () {
                var file = this.files[0];

                var reader = new FileReader();
                reader.onload = function () {
                    /*
                    Note: Now we need to register the blob in TinyMCEs image blob
                    registry. In the next release this part hopefully won't be
                    necessary, as we are looking to handle it internally.
                    */
                    var id = 'blobid' + (new Date()).getTime();
                    var blobCache =  tinymce.activeEditor.editorUpload.blobCache;
                    var base64 = reader.result.split(',')[1];
                    var blobInfo = blobCache.create(id, file, base64);
                    blobCache.add(blobInfo);

                    /* call the callback and populate the Title field with the file name */
                    cb(blobInfo.blobUri(), { title: file.name });
                };
                reader.readAsDataURL(file);
            };
            input.click();
        },
        /*** image upload ***/
        
        content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:14px }'
    });
});
</script>
</head>
<body>

<c:choose>
	<c:when test="${not empty searchVO.testId}">
		<c:set var="actionUrl" value="/test/update.do"/>
		<c:set var="writer" value="${result.userNm}"/>
	</c:when>	
	<c:otherwise>
		<c:set var="actionUrl" value="/test/insert.do"/>
		<c:set var="writer" value="${USER_INFO.name}"/>
	</c:otherwise>
</c:choose>

<div class="container">
	<div id="contents">
		<form action="${actionUrl}" method="post" id="frm" name="frm" onsubmit="return regist()" enctype="multipart/form-data">
			<input type="hidden" name="testId" value="${result.testId}"/>
			
			<%-- 첨부파일 삭제 때문에 returnUrl 존재 --%>
			<input type="hidden" name="returnUrl" value="/test/testRegist.do" />
			
			<h2>test 작성</h2>
			<table class="chart2 table">
				<colgroup>
					<col style="width:120px" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">제목</th>
						<td>
							<input type="text" id="sj" name="sj" title="제목입력" class="q3" value="<c:out value="${result.sj}"/>"/>
						</td>
					</tr>
					<tr>
						<th scope="row">작성자</th>
						<td>
							<input type="text" id="userNm" name="userNm" title="작성자입력" value="<c:out value="${writer}"/>"/>
						</td>
					</tr>
					<tr>
						<th scope="row">내용</th>
						<td>
							<textarea id="cn" name="cn" rows="15" title="내용입력"><c:out value="${result.cn}"/></textarea>
						</td>
					</tr>
					<!-- <tr>
						<th scope="row">파일첨부</th>
						<td>
							<input type="file" name="file_1"/><br/>
							<input type="file" name="file_2"/>
						</td>
					</tr> -->
				</tbody>
			</table>
			<div class="btn-cont ar">
				<c:choose>
					<c:when test="${not empty searchVO.testId}">
						<c:url var="uptUrl" value="/test/update.do">
							<c:param name="testId" value="${result.testId}"/>
						</c:url>
						<a href="${uptUrl}" id="btn-reg" class="btn btn-outline-primary">수정</a>
						
						<c:url var="delUrl" value="/test/delete.do">
							<c:param name="testId" value="${result.testId}"/>
						</c:url>
						<a href="${delUrl}" id="btn-del" class="btn btn-outline-danger">삭제</a>
					</c:when>
					<c:otherwise>
						<a href="#none" id="btn-reg" class="btn spot btn-outline-secondary">등록</a>
					</c:otherwise>
				</c:choose>
				<c:url var="listUrl" value="/test/selectList.do"/>
				<a href="${listUrl}"class="btn btn-primary">취소</a>
			</div>
		</form>
	</div>
</div>
<script>
$(document).ready(function() {
	//게시글 등록
	$("#btn-reg").click(function() {
		$("#frm").submit();
		return false;
	});
	
	//게시글 삭제
	$("#btn-del").click(function() {
		if(!confirm("삭제하시겠습니까?")){
			return false;
		}
	});
});

function regist() {
	if (!$("#sj").val()) {
		alert("제목을 입력해주세요.");
		$("#sj").focus();
		return false;
	}
}
</script>

</body>
</html>