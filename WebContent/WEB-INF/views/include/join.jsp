<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
td {
	height: 30px;
}
input {
	height: 20px;
}
</style>
</head>
<script type="text/javascript">

// var name = document.querySelector(".userName");
// var onlyKorean = function() {
// 	var pattern = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
// 	this.value = this.value.replace(pattern, '');
// };
// name.addEventListener('keypress', onlyKorean);

function checkReg() {
	

	
	//아이디창 한글입력방지
	$j( '.userId' ).on("blur keyup", function() {
		$j(this).val( $j(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
	});
	//이름 한글만 입력
// 	$j(".userName").on("onkeypress", function() {
// 		var pattern =  /^[가-힣]{2,10}$/g;
// 		$j(this).val($j(this).val().replace(pattern, ""));
		
// 	});
	$j(".userName").keyup(function() {
		var pattern = /[a-zA-Z]/g;
	    $j(this).val( $j(this).val().replace(pattern, '' ) );
	
	});
	
 	var idPattern = /^[a-z0-9]{4,12}$/g;
 	if(!idPattern.test($j(".userId").val())) {
 		$j("#idMsg").css("color","red");
 		$j("#idMsg").text("4~12자의 영문 소문자, 숫자만 사용 가능합니다.");
 		return false;
 	} else {
 		$j("#idMsg").css("color","blue");
 		$j("#idMsg").text("사용가능");
 		//f.userPw.focus();
 	}
 	
 	var pwPattern = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{8,16}$/g;
 	if(!pwPattern.test($j(".userPw").val())) {
 		$j("#pwMsg").css("color","red");
 		$j("#pwMsg").text("8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.");
 		return false;
 	} else {
 		$j("#pwMsg").text("");
 		//f.userPwCheck.focus();
 	}
 	var pwCheckVal = $j(".userPwCheck").val();
 	var pwVal = $j(".userPw").val();
 	if(pwVal!=pwCheckVal) {
 		$j("#pwCheckMsg").css("color","red");
 		$j("#pwCheckMsg").text("일치하지 않습니다.");
 		return false;
 	} else {
 		$j("#pwCheckMsg").css("color","blue");
 		$j("#pwCheckMsg").text("사용가능");
 	}
 	
	$j( '.userAddr1' ).on("blur keyup", function() {
		$j(this).val( $j(this).val().replace( /[^0-9|-]/g, '' ) );
	});
	
	$j( '.userPhone2' ).on("blur keyup", function() {
		$j(this).val( $j(this).val().replace( /[^0-9]/g, '' ) );
	});
	$j( '.userPhone3' ).on("blur keyup", function() {
		$j(this).val( $j(this).val().replace( /[^0-9]/g, '' ) );
	});
 	var phonePattern = /^[0-9]+\d{3,4}/g;
 	if(!phonePattern.test($j(".userPhone2").val())) {
 		$j("#phoneMsg").css("color","red");
 		$j("#phoneMsg").text("xxxx-xxxx사용해주세요");
 		return false;
 	} else {
 		$j("#phoneMsg").css("color","blue");
 		$j("#phoneMsg").text("사용가능"); 		
 	}
 	
 	var postPattern = /^\d{3}-\d{3}/g;
 	if(!postPattern.test($j(".userAddr1").val())) {
 		$j("#postMsg").css("color","red");
 		$j("#postMsg").text("xxx-xxx사용해주세요");
 		return false;
 	} else {
 		$j("#postMsg").css("color","blue");
 		$j("#postMsg").text("사용가능");
 	}
 	
 	
 	
 	
}
$j(document).ready(function() {
	
	
	$j("#idBtn").on("click", function() {
		var userId = $j(".userId").val();
			
		if(userId=="") {
			alert("아이디를 입력해주세요");
			f.userId.focus();
			return false;
		}

		
		//alert(userId)
		
		$j.ajax({
		    url : "/home/idcheck.do",
		    dataType: "text",
		    type: "POST",
		    data : {"userId":userId},
		    success: function(result)
		    {			
		    	if(result==1) {
			    	alert("사용중인 아이디 입니다.");		    		
		    	} else if(result==-1){
		    	 	var idPattern = /^[a-z0-9]{4,12}$/g;
		    	 	if(idPattern.test($j(".userId").val())) {
				    	alert("사용가능 합니다.");		    	 		
				    	f.userPw.focus();
		    	 	} else {
		    	 		alert("4~12자의 영문 소문자, 숫자만 사용 가능합니다.");
		    	 		f.userId.focus();
		    	 	}
		    	}
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert(jqXHR);
		    	alert(textStatus);
		    	alert(errorThrown);
		    }
		});
	});
	
	
	$j(".btn").click(function() {
		
		var userId = $j(".userId").val();
		var userPw = $j(".userPw").val();
		var userPwCheck = $j(".userPwCheck").val();
		var userName = $j(".userName").val();
		var userPhone1 = $j(".userPhone1").val();
		var userPhone2 = $j(".userPhone2").val();
		var userPhone3 = $j(".userPhone3").val();
		var userAddr1 = $j(".userAddr1").val();
		var userAddr2 = $j(".userAddr2").val();
		var userCompany = $j(".userCompany").val();
		
		if(userId == "") {
			alert("아이디를 입력해주세요");
			f.userId.focus();
			return false;
		}
		if(userPw == "") {
			alert("비밀번호를 입력해주세요");
			f.userPw.focus();
			return false;
		}
		if(userPwCheck == "") {
			alert("비밀번호를 체크해주세요 ");
			f.userPwCheck.focus();
			return false;
		}
		if(userName == "") {
			alert("이름을 입력해주세요 ");
			f.userName.focus();
			return false;
		}
		if(userPhone1 == "") {
			alert("전화번호를 입력해주세요 ");
			f.userPhone1.focus();
			return false;
		}
		if(userPhone2 == "") {
			alert("전화번호를 입력해주세요 ");
			f.userPhone2.focus();
			return false;
		}
		if(userPhone3 == "") {
			alert("전화번호를 입력해주세요 ");
			f.userPhone3.focus();
			return false;
		}
		if(userAddr1 == "") {
			alert("우편번호를 입력해주세요 ");
			f.userAddr1.focus();
			return false;
		}
		if(userAddr2 == "") {
			alert("주소를 입력해주세요 ");
			f.userAddr2.focus();
			return false;
		}
		if(userCompany == "") {
			alert("회사이름를 입력해주세요 ");
			f.userCompany.focus();
			return false;
		}
		
		var frm = $j(".join :input");
		var param = frm.serialize();
		
		//alert(param);
		
		$j.ajax({
		    url : "/home/joinAction.do",
		    dataType: "json",
		    type: "POST",
		    data : param,
		    success: function(data, textStatus, jqXHR)
		    {			
		    	alert("가입되었습니다.");
		    	location.href = "/home/boardList.do";
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("실패");
		    }
		});
	});
});

</script>
<body>
<table>
	<tr>
		<td>
		<form action="joinAction.do" method="post" class="join" id="f">
		<table border="1" width="420px" style="border-collapse: collapse;">			
			<tr>
				<td align="center" colspan="2" style="background-color: #F2F5F6;">회원가입</td>
			</tr>
			<tr>
				<td align="center" width="100px;">id</td>
				<td>
					<input type="text" name="userId" class="userId" onkeyup="checkReg()" placeholder="아이디">&nbsp;
					<button type="button" id="idBtn">아이디 중복확인</button>
					<div id="idMsg" style="color: red; font-size: 11px;"></div>
				</td>
			</tr>
			<tr>
				<td align="center" width="100px;">pw</td>
				<td>
				<input type="password" name="userPw" class="userPw" onkeyup="checkReg()" placeholder="비밀번호">
				<div id="pwMsg" style="color: red; font-size: 11px;"></div>
				</td>
				
			</tr>
			<tr>
				<td align="center" width="100px;" >pw check</td>
				<td>
				<input type="password" name="userPwCheck" class="userPwCheck" onkeyup="checkReg()" placeholder="비밀번호 확인">
				<div id="pwCheckMsg" style="color: red; font-size: 11px;"></div>
				</td>
			</tr>
			<tr>
				<td align="center" width="100px;">name</td>
				<td>
				<input type="text" name="userName" class="userName" onkeyup="checkReg()" placeholder="이름">
				</td>
			</tr>
			<tr>
				<td align="center" width="100px;">phone</td>
				<td>
				<select name="userPhone1" style="height: 26px;" class="userPhone1">
				<c:forEach var="list" items="${codeList }">
				<c:if test="${list.codeType eq 'phone' }">
				<option value="${list.codeName }">${list.codeName }</option>
				</c:if>
				</c:forEach>
				</select>
				<input type="text" name="userPhone2" size="3" class="userPhone2" onKeyup="checkReg()">
				<input type="text" name="userPhone3" size="3" class="userPhone3" onKeyup="checkReg()">
				<div id="phoneMsg" style="color: red; font-size: 11px;"></div>
				</td>
			</tr>
			<tr>
				<td align="center" width="100px;" >postNo</td>
				<td>
				<input type="text" name="userAddr1" class="userAddr1" placeholder="000-000" onKeyup="checkReg();">
				<div id="postMsg" style="color: red; font-size: 11px;"></div>
				</td>
			<tr>
			<tr>
				<td align="center" width="100px;" >address</td>
				<td>
				<input type="text" name="userAddr2" class="userAddr2" placeholder="주소">
				</td>
			<tr>
			<tr>
				<td align="center" width="100px;" >company</td>
				<td>
				<input type="text" name="userCompany" class="userCompany" placeholder="회사">
				</td>
			<tr>
		</table>
		</form>
		</td>
	</tr>
<tr>
	<td>
		<table align="center">
			<tr>
				<td>
				<button type="submit" class="btn">가입</button>
				</td>
			</tr>
		</table>
	</td>
</tr>
</table>

</body>
</html>