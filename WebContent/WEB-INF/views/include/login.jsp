<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α���</title>
<style type="text/css">
#div01 {
	position: relative;
	height: 150px;
	width: 300px;
	top: 50%;
	left: 30%;
	border: 1px solid;
	margin: 35px 0px 0px -150px;
}
#div02 {
	padding-left: 25px;
}
#div03 {
	padding-top: 10px;
}
</style>
</head>
<script type="text/javascript">
function join() {
	location.href="join.do";
}
</script>
<body>

<form action="loginAction.do" method="post">
<div id="div01"><p align="center">�α���</p>
<div id="div02">
	<div>id <input type="text" name="id"></div>
	<div>pw <input type="password" name="pw"></div>
	<div id="div03">
	<button type="submit" name="btn">�α���</button>
	<button type="button" name="btn" onclick="join()">ȸ������</button>
<!-- 	<button type="button" name="btn" onclick="history.go(-1);">����</button> -->
<!-- 	<button type="button" name="btn" onclick="location.href='boardList.do?pageNo=1'">����</button> -->
	</div>
</div>
</div>
</form>
<div style="color: red;" align="center">${message }</div>
</body>
</html>