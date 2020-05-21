<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardView</title>
</head>
<body>
<script type="text/javascript">
$j(document).ready(function() {

});

function formSubmit() {
	document.getElementById("frm1").submit();
}
</script>
<form action="boardDelete.do" id="frm1">
<table align="center">
	<tr>
		<td>
			<table border ="1" style="border-collapse: collapse;">
				<tr>
					<td width="120" align="center" style="background-color: #F2F5F6;">
					Type
					</td>
					<td width="400">
					${board.comCodeVo.codeName}
					</td>
				</tr>
				<tr>
					<td width="120" align="center" style="background-color: #F2F5F6;">
					Title
					</td>
					<td width="400">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center" style="background-color: #F2F5F6;">
					Comment
					</td>
					<td>
					${board.boardComment}
					</td>
				</tr>
				<tr>
					<td align="center" style="background-color: #F2F5F6;">
					Writer
					</td>
					<td>
					<input type="hidden" name="boardType" value="${board.boardType }">
					<input type="hidden" name="boardNum" value="${board.boardNum }">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href="/board/boardList.do">List</a>
			<a href = "/board/${board.boardType}/${board.boardNum}/boardUpdate.do">Update</a>
			<a href="" id="button" onclick="formSubmit(); return false;">Delete</a>
		</td>
	</tr>
</table>	
</form>
</body>
</html>