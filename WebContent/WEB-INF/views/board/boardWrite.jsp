<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardWrite</title>
</head>
<script type="text/javascript">
// 			var exit = false;
		
// 			$j("[name='boardTitle']").each(function(i, element) {
// 				//if( $j.trim($j(this).val()) == "" ) {
// 				if($j(this).val() == "" ) {
// 					$j(this).focus();
// 		            alert("제목을 입력하세요.");
// 		            return false;
// 				} 
// 				if(!exit) {
// 					$j("[name='boardComment']").each(function(i, element) {
// 						if($j(this).val() == "" ) {
// 							$j(this).focus();
// 							alert("내용을 입력하세요.");
// 							return false;
// 						}
// 						if(!exit) {
// 						}
// 					});
					
// 				}
// 			});
	$j(document).ready(function(){
		var pageNo=1;
		
		$j("#boardWrite").submit(function() {

// 			var boardTitle = $j(".boardTitle").val();
// 			var boardComment = $j(".boardComment").val();
			
// 			if(boardTitle == "") {
// 				alert("제목을 입력해주세요.");
// 				return false;
// 			}
// 			if(boardComment == "") {
// 				alert("내용을 입력해주세요.");
// 				return false;
// 			}
			
			//var $frm = $j('.boardWrite :input');
 			//var param = $frm.serialize();
 			var param = $j("#boardWrite").serialize();

 			$j.ajax({
 			    url : "/board/boardInsertAll.do",
 			    dataType: "json",
 			    type: "POST",
 			    data : param,
 			    success: function(data, textStatus, jqXHR)
 			    {
 					//alert("작성완료");
				
 					//alert("메세지:"+data.success);
				
 					location.href = "/board/boardList.do?pageNo="+pageNo;
 			    	//location.replace("/board/boardList.do");
 			    },
 			    error: function (jqXHR, textStatus, errorThrown)
 			    {
 			    	alert("실패");
 			    }
 			});

		});
	});
// 			$j('.boardTitle').each(function(i, element) {
// 				if( $j.trim($j(this).val()) == "" ) {
// 					$j(this).focus();
// 		            alert("제목을 입력하세요.");
// 		            exit = true;
// 		            return false;
// 				} if (exit) {
// 					exit = true;
// 				}

// 				$j('.boardComment').each(function(i, element) {
// 			        if( $j.trim($j(this).val()) == "") {
// 			    	    $j(this).focus();
// 			            alert("내용을 입력하세요");
// 			            exit = true;
// 			            return false;
// 			        } else if (!exit) {
// 			        	exit = true;
// 			        	if( $j.trim($j(this).val()) != "") {
				    	    
// 						var $frm = $j('.boardWrite :input');
// 			 			var param = $frm.serialize();
				
// 			 			$j.ajax({
// 			 			    url : "/board/boardInsertAll.do",
// 			 			    dataType: "json",
// 			 			    type: "POST",
// 			 			    data : param,
// 			 			    success: function(data, textStatus, jqXHR)
// 			 			    {
// 			 					//alert("작성완료");
								
// 			 					//alert("메세지:"+data.success);
								
// 			 					//location.href = "/board/boardList.do?pageNo="+pageNo;
// 			 			    	location.replace("/board/boardList.do?pageNo="+pageNo);
// 			 			    },
// 			 			    error: function (jqXHR, textStatus, errorThrown)
// 			 			    {
// 			 			    	alert("실패");
// 			 			    }
// 			 			});
// 			        	}
// 			        }
// 				});
// 				if(exit) {
// 				}
// 			});


				

// 			$j(".boardTitle").each(function(i, element) {
// 				boardTitle.push($j(this).val());
// 			});
// 			$j(".boardComment").each(function(i, element) {
// 				boardComment.push($j(this).val());
// 			});
			
// 			var $frm = $j('.boardWrite :input');
// 			var param = $frm.serialize();
	
// 			$j.ajax({
// 			    url : "/board/boardInsertAll.do",
// 			    dataType: "json",
// 			    type: "POST",
// 			    data : param,
// 			    success: function(data, textStatus, jqXHR)
// 			    {
// 					//alert("작성완료");
					
// 					//alert("메세지:"+data.success);
					
// 					//location.href = "/board/boardList.do?pageNo="+pageNo;
// 			    	location.replace("/board/boardList.do?pageNo="+pageNo);
// 			    },
// 			    error: function (jqXHR, textStatus, errorThrown)
// 			    {
// 			    	alert("실패");
// 			    }
// 			});
// 			exit = true;
			


	//글쓰기 양식 추가하기

	$j(document).ready(function() {
		
		var list1 = new Array();
		<c:forEach var="list" items="${codeList }">
		<c:if test="${list.codeType eq 'menu' }" >
		list1.push("${list.codeName }");
		</c:if>
		</c:forEach>
		for (var i = 0; i < list1.length; i++) {
		    //alert(list1[i]);
		}
		//alert(list1);
		
		$j("#addBtn").click(function() {
			
			var html ="<table align='center'>";
			html += "<tr>"
			html += "<td>"
			html += "<table class='formTable' align='center' border ='1' style='border-collapse: collapse;'>"
			html += "<tr>";
			html += "<td width='120' align='center' style='background-color: #F2F5F6;'>Type</td>";
			html += "<td width='400'>";
			html += "<select name='boardType'>"
			html += "<c:forEach var='list' items='${codeList }'><c:if test='${list.codeType eq "menu" }' ><option value='${list.codeId }'>${list.codeName }</option></c:if></c:forEach>"
			html += "</select>"			
			html += "</td>";
			html += "</tr>";
			
			html += "<tr>";
			html += "<td width='120' align='center' style='background-color: #F2F5F6;'>Title</td>";
			html += "<td width='400'>";
			html += "<input class='boardTitle' required='required' name='boardTitle' type='text' size='54' value='${board.boardTitle}'>";
			html += "</td>";
			html += "</tr>";
			
			html += "<tr>";
			html += "<td height='300' align='center' style='background-color: #F2F5F6;'>Comment</td>";
			html += "<td align='top'>";
			html += "<textarea class='boardComment' required='required' name='boardComment'  rows='20' cols='55'>${board.boardComment}</textarea>";
			html += "</td>";
			html += "</tr>";
			
			html += "<tr>";
			html += "<td align='center' style='background-color: #F2F5F6;'>Writer</td>";
			html += "<td></td>";
			html += "</tr>";
			html += "</table>";
			html += "<tr>";
			html += "<td td style='border: none;' align='right'><input id='delBtn' type='button' value='삭제'></td>";
			html += "</tr>";

			html += "</table>";
			
			if($j(".formTable").length < 2) {
				$j("#addTable").append(html);
			} else if ($j(".formTable").length = 2) {
				$j("#addBtn").attr("disabled", "disabled");				
			}
		});
		//행 삭제	
		$j('#addTable').on("click", "input:button[id=delBtn]", function() {
		    $j(this).parents("table").remove();
		});
	});

</script>
<body>
<form class="boardWrite" id="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
<!-- 			<input id="submit" type="button" value="작성"> -->
			<input type="submit" id="submit" value="작성">
			<input id="addBtn" type="button" value="추가">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1" style="border-collapse: collapse;"> 
					<tr>
						<td width="120" align="center" style="background-color: #F2F5F6;">
						Type
						</td>
						<td width="400">
						<select name="boardType">
						<c:forEach var="list" items="${codeList }">
						<c:if test="${list.codeType eq 'menu' }" >
							<option value="${list.codeId }">${list.codeName }</option>
						</c:if>
						</c:forEach>
						</select>
						</td>
					</tr>
					<tr>
						<td width="120" align="center" style="background-color: #F2F5F6;">
						Title
						</td>
						<td width="400">
						<input class="boardTitle" required="required" name="boardTitle" type="text" size="54" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center" style="background-color: #F2F5F6;">
						Comment
						</td>
						<td align="top">
						<textarea class="boardComment" required="required" name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center" style="background-color: #F2F5F6;">
						Writer
						</td>
						<td>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
	<div id="addTable"></div>
</form>	
</body>
</html>