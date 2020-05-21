<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUpload</title>
<script>
$j(document).ready(function() {
	$j("#t").submit(function() {
		var str = $j( "form" ).serialize();
		
// 		$j.ajax({
// 			type:"post",
// 			url:"/board/fileResult",
// 			data:str,
// 			dataType: "json",
// 			success:function(success) 
// 			{
// 				alert("성공");
// 			},
// 			error:function(req) {
// 				alert("에러 = "+req.status);
// 			}	
// 		});
	});
});



$j(function() {
	$j("#btn5").on("click", function() {
		uploadFile();
	});
});

function uploadFile() {
	
	var form = new FormData($j('#frm')[0]);
	
	$j.ajax({
		url: "/board/fileAction.do",
		type: "post",
		data: form,
		contentType: false,
		processData: false,
		success: function(data) 
		{
			 for(var i=0; i < data.length; i++){
                 $j('#result').append(data[i] + '<br>')
             }
		}, error: function(req) {
			alert(req.status)
		}
	});
	
}
</script>
</head>
<body>
<form id="frm" enctype="multipart/form-data">
    <input multiple="multiple" type="file" id="images" name="images">
</form>
    <button id="btn5">업로드</button>
    <div id="result"></div>
<br>
<form id="t" action="/board/fileUpload.do" method="post" enctype="multipart/form-data">
		<fieldset style="width: 500px;">
			<table>
				<tr>
					<th>이    름</th>
					<td><input type="text" name="name" required="required" placeholder="이름"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="pwd" required="required" placeholder="비밀번호"></td>
				</tr>
				<tr>
					<th>파    일</th>
					<td><input type="file" name="file" required="required"></td>
				</tr>
				<tr>
					<th>제    목</th>
					<td><input type="text" name="title" required="required" placeholder="제목"></td>
				</tr>
				<tr>
					<th>내    용</th>
					<td><textarea rows="20" cols="40" name="content" required="required" placeholder="내용"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center" style="padding-top: 10px;">
						<input type="submit" value="작성">
						<input type="reset" value="취소">
					</td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>