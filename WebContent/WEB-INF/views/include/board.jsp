<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
td {
	height: 20px;
}
</style>
<title>list</title>
</head>
<script type="text/javascript">
	function pageNo(page) {
		location.href = "boardList.do?pageNo=" + page;
	}

	$j(document).ready(function() {

		$j("input[name=checkboxAll]").change(function() {//[전체]체크박스 상태체크
			if ($j("input[name=checkboxAll]").prop("checked")) {//체크시
				$j("input[name=checkbox01]").prop("checked", true)//4개체크
			} else {
				$j("input[name=checkbox01]").prop("checked", false)//4개체크해제
			}
		});

		$j("input[name=checkbox01]").change(function() {
			var chkcnt = $j("input:checkbox[name=checkbox01]:checked").length;

			if (chkcnt == 4) {
				$j("input[name=checkboxAll]").prop("checked", true);
			} else {
				$j("input[name=checkboxAll]").prop("checked", false);
			}

		});

		$j("#search").click(function() {//검색버튼 클릭시
			var arr = new Array();//배열생성
			$j("input[type=checkbox]:checked").each(function() {//each로 체크값 순회
				arr.push($j(this).val());//push로 클릭값$j(this).val()배열에 담음
			})

			$j.ajax({
				url : "/home/searchTableHome.do",
				data : {
					"arr" : arr
				},
				type : "post",
				dataType : "html",
				traditional : true,//배열넘길떄
				success : function(data) 
				{
					$j('#newTable').html(data);

				},
				error : function(req) {
					alert("에러 = " + req.status);
				}

			});
		});

	});
	
	$j(function(){
		$j("#searchBtn").on("click",function(){
			
			var search = $j(".keyword").val();
			
			$j.ajax({
				url: "/home/searchHomeAction.do",
				data: {"keyword":search},
				type: "post",
				success: function(data) 
				{
					$j('#newTable').html(data);
					
				},error: function(req) {
					alert("에러"+req.status);
				}
			}) ;
		});
	});
	
</script>
<body>
	<table id="newTable" >
	<tr>
		<td align="right">
			<c:if test="${sessionScope.userVo == null }">
			<div style="padding-left: 360px; display: inline-table;">total : ${totalCnt}</div>
			</c:if>
			<c:if test="${sessionScope.userVo != null }">
			<c:out value="[${userVo.userId }] 님 환영합니다."></c:out> 
			<a href="${pageContext.request.contextPath }/home/logout.do">logout</a>
			<div style="padding-left: 200px; display: inline-table;">total : ${totalCnt}</div>
			</c:if>	
		</td>
		</tr>
		<tr>
			<td>
				<table id="boardTable" border="1" style="border-collapse: collapse;"
					width="100%">
					<tr style="background-color: #F2F5F6;">
						<td width="80" align="center">Type</td>
						<td width="40" align="center">No</td>
						<td width="300" align="center">Title</td>
					</tr>
					<tbody id="searchTable">
						<c:forEach items="${boardList}" var="list">
							<tr>
								<td align="center">${list.comCodeVo.codeName}</td>
								<td align="center">${list.boardNum}</td>
								<td><a
									href="/home/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td>
			<table id="" align="center">
			<tr>
				<td><input name="checkboxAll" type="checkbox" value="a05">전체
					<c:forEach items="${codeList }" var="list">
						<c:if test="${list.codeType eq 'menu' }">
							<input name="checkbox01" type="checkbox" value="${list.codeId }">${list.codeName }			
					</c:if>
					</c:forEach>
					<button type="button" id="search">검색</button>
					<p style="display: inline; padding-left: 120px;">
						<a href="/home/boardWrite.do">글쓰기</a>
					</p></td>
			</tr>
			<tr>
				<td align="left">
					<input type="text" size="10px;" name="keyword" class="keyword">
					<button type="button" value="검색" id="searchBtn">검색</button>
				</td>
			</tr>
			<tr>
				<td style="padding: 5px;" align="center">
				<a href="boardList.do?pageNo=1">처음</a>
				<c:if test="${pageVo.pageNo >= 6 }">
					<a href="boardList.do?pageNo=${pageVo.prevPage }">이전</a>
				</c:if>
				<c:forEach begin="${pageVo.startPage }" end="${pageVo.endPage }" var="page">
					<a style="text-decoration: none;" href="javascript:pageNo(${page });">${page}</a>
				</c:forEach>
			    <c:if test="${pageVo.pageNo >= 5}">
			    <a href="boardList.do?pageNo=${pageVo.nextPage }">다음</a>
			    </c:if>
			    <a href="boardList.do?pageNo=${pageVo.totalPage }">마지막</a>
				</td>
			</tr>
			</table>
			</td>
		</tr>
	</table>
		
</body>
</html>