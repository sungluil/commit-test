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
<form action="boardUpdateAction.do" id="frm1" method="post">
<table>
	<tr>
		<td>
			<table border ="1" style="border-collapse: collapse;">
				<tr>
					<td width="120" align="center" style="background-color: #F2F5F6;">
					Type
					</td>
					<td width="400">
					${board.comCodeVo.codeName }
					</td>
				</tr>
				<tr>
					<td width="120" align="center" style="background-color: #F2F5F6;">
					Title
					</td>
					<td width="400">
					<input type="text" name="boardTitle" value="${board.boardTitle }" border: none;" size="54">
					</td>
				</tr>
				<tr>
					<td height="300" align="center" style="background-color: #F2F5F6;">
					Comment
					</td>
					<td>
					<textarea id="boardComment" name="boardComment" rows="20" cols="55" border: none;">${board.boardComment}</textarea>
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
			<a href="javascript:history.go(-1)">뒤로</a>
			<a href="" id="button" onclick="formSubmit(); return false;">수정</a>
		</td>
	</tr>
</table>	
</form>
</body>
</html>