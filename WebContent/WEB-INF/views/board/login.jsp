<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style type="text/css">
#div01 {
	position: relative;
	height: 180px;
	width: 300px;
	top: 50%;
	left: 50%;
	border: 1px solid;
	margin: 35px 0px 0px -150px;
}
#div02 {
	padding-left: 25px;
}
#div03 {
	padding-top: 10px;
}
#div04 {
	padding-top: 10px;
}
</style>
</head>
<script type="text/javascript">
function join() {
	location.href="join.do";
}
/**
 * ajax로 아이디비번,체크박스값
 */
$j(document).ready(function() {
	$j("#loginBtn").click(function() {
// 		var arr = new Array();
// 		$("input[type=checkbox]:checked").each(function(i, element) {
// 			arr.push($j(this).val());
// 		});
		var idSave = $j("#idSave").prop("checked") == true ? "Y" : "N";
		var loginKeep = $j("#loginKeep").prop("checked") == true ? "Y" : "N";
		var id = $j("#id").val();
		var pw = $j("#pw").val();
		$j.ajax({
			url:"/board/loginAction.do",
			type:"post",
			data:
			{
				"id":id,
				"pw":pw,
				"idSave":idSave ,
				"loginKeep":loginKeep
			},
			success: function(cnt) {
				if(cnt==1) {
					alert("환영합니다.")
					location.replace("/board/boardList.do");
				} else {
					alert("아이디 또는 비밀번호가 잘못되었습니다.")
				}
			},
			error:function(req) {
				
			}
		});
	});
});

/**
 * 아이디저장 로그인유지 체크박스 저장
 */
$j(document).ready(function (){
    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var userInputId = getCookie("userCookie");
    $j("input[name='id']").val(userInputId); 
     
    if($j("input[name='id']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $j("#idSave").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $j("#idSave").change(function (){ // 체크박스에 변화가 있다면,
        if($j("#idSave").is(":checked")){ // ID 저장하기 체크했을 때,
            var userInputId = $j("input[name='id']").val();
            setCookie("userCookie", userInputId, 7); // 7일 동안 쿠키 보관
        } else { // ID 저장하기 체크 해제 시,
            deleteCookie("userCookie");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $j("input[name='id']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($j("#userCookie").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $j("input[name='id']").val();
            setCookie("userCookie", userInputId, 7); // 7일 동안 쿠키 보관
        }
    });
});

function setCookie(cookieName, value, exdays) {
	   var exdate = new Date();
	   exdate.setDate(exdate.getDate() + exdays);
	   var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	   document.cookie = cookieName + "=" + cookieValue;
	}
function deleteCookie(cookieName) {
   var expireDate = new Date();
   expireDate.setDate(expireDate.getDate() - 1);
   document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
function getCookie(cookieName) {
   cookieName = cookieName + '=';
   var cookieData = document.cookie;
   var start = cookieData.indexOf(cookieName);
   var cookieValue = '';
   if(start != -1){
      start += cookieName.length;
      var end = cookieData.indexOf(';', start);
      if(end == -1)end = cookieData.length;
      cookieValue = cookieData.substring(start, end);
   }
   return unescape(cookieValue);
}

// var message = '${msg}'; 
// var returnUrl = '${url}'; 
// alert(mag); 
// document.location.href = url; 
</script>
<body>
<div id="div01"><p align="center">로그인</p>
<div id="div02">
	<div>id<input type="text" id="id" name="id" style="margin-left: 13px;"></div>
	<div>pw <input type="password" id="pw" name="pw"></div>
	<div id="div03">
	<button type="submit" name="btn" id="loginBtn">로그인</button>
	<button type="button" name="btn" onclick="join()">회원가입</button>
<!-- 	<button type="button" name="btn" onclick="history.go(-1);">이전</button> -->
	<button type="button" name="btn" onclick="location.href='boardList.do?pageNo=1'">이전</button>
	</div>
	<div id="div04">
		<input type="checkbox" id="idSave" value="Y">아이디저장
		<input type="checkbox" id="loginKeep" value="Y">로그인유지
	</div>
</div>
</div>
<div style="color: red;" align="center">${message }</div>
</body>
</html>