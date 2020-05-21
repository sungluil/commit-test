<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>list</title>
<style type="text/css">
li {
	display: inline-block;
	float: left;
	margin: 0 6px 6px 0;
}
ul a {
	border: 1px solid #ddd;
	display: inline-block;
	width: 28px;
	height: 28px;
	line-height: 28px;
	text-align: center;
	box-sizing: border-box;
	color: #111;
	font-style: normal;
	font-size: 11px;
	font-weight: 700;
}
a {
	text-decoration: none;
}
li.product-selected a {
    background: #fff;
    border-color: #111;
}
li a:hover {
	background: transparent;
	border-color: #111;
}


/* s m l xl 박스 div */
.xans-product-relation ul.prdList {
	display: table;
	width: 100%;
	margin: 0;
	border: 0;
}
.xans-product-relation ul.prdList li.item {
	display: inline-block;
	float: left;
    width: auto;
    height: 52px;
    margin-right: 12px;
    box-sizing: border-box;
}
.xans-product-relation ul.prdList li.item a {
	display: inline-block;
	width: 100%;
	height: 100%;
	border: 1px solid transparent;
	box-sizing: border-box;
	text-align: center;
}
.xans-product-relation ul.prdList li.item img {
	display: inline-block;
	height: 100%;
    width: auto;
}

#totalProducts td .quantity {
    display: inline-block;
    position: relative;
    width: auto !important;
    vertical-align: top;
    margin: 0;
}
.xans-product-detail .infoArea td .quantity {
    position: relative;
    display: block;
}
input, select, textarea {
    font-size: 100%;
    color: #111;
    vertical-align: middle;
/*     border: 1px solid #fff; */
    outline: none !important;
}
#totalProducts td .quantity input {
    width: 16px;
    height: 17px;
    padding: 0 24px 0 12px;
    font-size: 12px;
    color: #111;
    border: 0px solid #ddd;
    border-radius: 2px;
    margin: 0px 0px 0px -1px;
}
#totalProducts td .quantity .up {
    position: absolute;
    left: 28px;
    top: 0;
}
#totalProducts td .quantity .down {
    position: absolute;
    left: 28px;
    top: 11px;
}
#totalProducts td .quantity img {
    width: 15px;
    margin-left: 1px;
}
#totalProducts td a.delete {
    display: inline-block;
    float: right;
    vertical-align: middle;
    width: 16px !important;
    padding-top: 2px;
}
#totalProducts tr {
    border: 0;
    vertical-align: top;
}

/* 버튼 */
.xans-product-action {
    width: 100%;
    padding: 0;
    display: block;
    height: auto;
    overflow: visible;
    margin-bottom: 0;
    max-width: 200px;
}
.xans-product-action .btnArea {
    overflow: hidden;
    margin: 0;
    text-align: left;
    margin: 0 0;
    padding-bottom: 12px;
}
.xans-product-action .btnArea a {
    display: inline-block;
    float: left;
    cursor: pointer;
    width: 50%;
    height: auto;
    box-sizing: border-box !important;
    font-weight: 500 !important;
    border: 1px solid #111;
    margin-bottom: 4px;
    font-size: 10px;
    text-align: center;
    text-transform: uppercase;
    padding: 8px 4px;
    height: 32px;
    overflow: hidden;
    white-space: nowrap;
}
.xans-product-action .btnArea a.buyb {
    background: #111;
    color: #fff;
}
</style>
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
				url : "/board/searchTable.do",
				data : 
				{
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
				url: "/board/searchAction.do",
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
	/**
	 * 클릭시 클래스명 변경
	**/
// 	ctrl_tab = function(size) {
// 		var small = document.getElementById('small');
// 		var medium = document.getElementById('medium');
// 		var large = document.getElementById('large');
// 		var xlarge = document.getElementById('xlarge');
		
// 		if (size == 'small') {
// 			document.getElementById('small').className = 'product-selected';
// 			document.getElementById('medium').className = 'product';
// 			document.getElementById('large').className = 'product';
// 			document.getElementById('xlarge').className = 'product';
// 		} else if (size == 'medium') {
// 			document.getElementById('small').className = 'product';
// 			document.getElementById('medium').className = 'product-selected';
// 			document.getElementById('large').className = 'product';
// 			document.getElementById('xlarge').className = 'product';
// 		} else if (size == 'large') {
// 			document.getElementById('small').className = 'product';
// 			document.getElementById('medium').className = 'product';
// 			document.getElementById('large').className = 'product-selected';
// 			document.getElementById('xlarge').className = 'product';
// 		} else if (size == 'xlarge') {
// 			document.getElementById('small').className = 'product';
// 			document.getElementById('medium').className = 'product';
// 			document.getElementById('large').className = 'product';
// 			document.getElementById('xlarge').className = 'product-selected';
// 		}
		
		
// 	}
	
	$j(function(){
		$j("#small").on("click",function() {
			if(small.className=='product') {
	 			document.getElementById('small').className = 'product-selected';
	 			document.getElementById('medium').className = 'product';
	 			document.getElementById('large').className = 'product';
	 			document.getElementById('xlarge').className = 'product';					
			} else if(small.className=='product-selected') {
				document.getElementById('small').className = 'product';
			}
		});
		$j("#medium").on("click",function() {
			if(medium.className=='product') {
	 			document.getElementById('small').className = 'product';
	 			document.getElementById('medium').className = 'product-selected';
	 			document.getElementById('large').className = 'product';
	 			document.getElementById('xlarge').className = 'product';					
			} else if(medium.className=='product-selected') {
				document.getElementById('medium').className = 'product';
			}
		});
		$j("#large").on("click",function() {
			if(large.className=='product') {
	 			document.getElementById('small').className = 'product';
	 			document.getElementById('medium').className = 'product';
	 			document.getElementById('large').className = 'product-selected';
	 			document.getElementById('xlarge').className = 'product';					
			} else if(large.className=='product-selected') {
				document.getElementById('large').className = 'product';
			}
		});
		$j("#xlarge").on("click",function() {
			if(xlarge.className=='product') {
	 			document.getElementById('small').className = 'product';
	 			document.getElementById('medium').className = 'product';
	 			document.getElementById('large').className = 'product';
	 			document.getElementById('xlarge').className = 'product-selected';					
			} else if(xlarge.className=='product-selected') {
				document.getElementById('xlarge').className = 'product';
			}
		});
	});
// 	const size= document.querySelector("#small");
// 	const CLICKED_CLASS = "clicked";

// 	function handleClick(){
// 		size.classList.toggle(CLICKED_CLASS);
// 	}

// 	function init(){
// 		size.addEventListener("click", handleClick);
// 	}
	 
// 	init();

// 	function changeClass(){
// 		document.getElementById('small').className = '';
// 	}
// 	function myFunction() {
// 		var el = document.getElementsByClassName("product");
// 		//console.log(x.length)
// 	}
// 	for (var i = 0; i < myFunction.; i++) {
// 	    el[i].addEventListener('click', changeClass);
// 	}
	

// 	window.onload = function(){
//         document.getElementById('small').addEventListener( 'click', changeClass);
//     }
	$j(document).ready(function() {
		$j("#small").click(function() {
			var html = "<table class='Products-small'>"
			html += "<tr>"
			html += "<td>"
			html += "<Strong>S.W. Carpenter Pant Black</Strong>"
			html += "<br>"
			html += "<span style='font-size:12px;'> - S</span>"
			html += "</td>"
			html += "<td>"
			html +=	"<span class='quantity' style='width:65px;'>"
			html += "<input type='text' id='option_box1_quantity' name='quantity_opt[]' class='quantity_opt eProductQuantityClass' value='1' product-no='2672'>"
			html += "<a href='#none' class='up eProductQuantityUpClass' data-target='option_box1_up'>"
			html += "<img src='/resources/images/btn_count_up.gif' id='option_box1_up' class='option_box_up' alt='수량증가'>"
			html += "</a>"
			html += "<a href='#none' class='down eProductQuantityDownClass' data-target='option_box1_down'>"
			html += "<img src='/resources/images/btn_count_down.gif' id='option_box1_down' class='option_box_down' alt='수량감소'>"
			html += "</a>"
			html += "</span>"
			html += "<a href='#' class='delete'><img src='/resources/images/btn_price_delete.gif'>"
			html += "</a>"
			html += "</td>"
			html += "</tr>"
			html += "</table>"
			
			if($j(".Products-small").length < 1) {
				$j("#totalProducts").append(html);
			} else {
				alert("이미 선택되어있습니다.")				
			}
			//행 삭제	
			$j('.Products-small').on("click", ".delete", function() {
				$j('.Products-small ').remove();
			});
			
			
			var clicknum = 1;
			$j("#option_box1_up").on("click", function() {
				clicknum++;
				$j("input[type=text][id='option_box1_quantity']").val(clicknum);
			});

			$j("#option_box1_down").on("click", function() {
				var su = $j("#option_box1_quantity").val();
				if(su <=1) {
					alert("최소주문수량은 1개입니다.")
				} else {
					clicknum--;
				}
				$j("input[type=text][id='option_box1_quantity']").val(clicknum);

			});

		});
		
		$j("#medium").click(function() {
			var html = "<table class='Products-medium'>"
			html += "<tr>"
			html += "<td>"
			html += "<Strong>S.W. Carpenter Pant Black</Strong>"
			html += "<br>"
			html += "<span style='font-size:12px;'> - M</span>"
			html += "</td>"
			html += "<td>"
			html +=	"<span class='quantity' style='width:65px;'>"
			html += "<input type='text' id='option_box2_quantity' name='quantity_opt[]' class='quantity_opt eProductQuantityClass' value='1' product-no='2672'>"
			html += "<a href='#none' class='up eProductQuantityUpClass' data-target='option_box2_up'>"
			html += "<img src='/resources/images/btn_count_up.gif' id='option_box2_up' class='option_box_up' alt='수량증가'>"
			html += "</a>"
			html += "<a href='#none' class='down eProductQuantityDownClass' data-target='option_box2_down'>"
			html += "<img src='/resources/images/btn_count_down.gif' id='option_box2_down' class='option_box_down' alt='수량감소'>"
			html += "</a>"
			html += "</span>"
			html += "<a href='#' class='delete'><img src='/resources/images/btn_price_delete.gif'>"
			html += "</a>"
			html += "</td>"
			html += "</tr>"
			html += "</table>"
			
			if($j(".Products-medium").length < 1) {
				$j("#totalProducts").append(html);
			} else {
				alert("이미 선택되어있습니다.")				
			}
			//행 삭제	
			$j('.Products-medium').on("click", ".delete", function() {
				$j('.Products-medium ').remove();
			});
			
			
			var clicknum = 1;
			$j("#option_box2_up").on("click", function() {
				clicknum++;
				$j("input[type=text][id='option_box2_quantity']").val(clicknum);
			});

			$j("#option_box2_down").on("click", function() {
				var su = $j("#option_box2_quantity").val();
				if(su <=1) {
					alert("최소주문수량은 1개입니다.")
				} else {
					clicknum--;
				}
				$j("input[type=text][id='option_box2_quantity']").val(clicknum);

			});
		});
		
		$j("#large").click(function() {
			var html = "<table class='Products-large'>"
			html += "<tr>"
			html += "<td>"
			html += "<Strong>S.W. Carpenter Pant Black</Strong>"
			html += "<br>"
			html += "<span style='font-size:12px;'> - L</span>"
			html += "</td>"
			html += "<td>"
			html +=	"<span class='quantity' style='width:65px;'>"
			html += "<input type='text' id='option_box3_quantity' name='quantity_opt[]' class='quantity_opt eProductQuantityClass' value='1' product-no='2672'>"
			html += "<a href='#none' class='up eProductQuantityUpClass' data-target='option_box3_up'>"
			html += "<img src='/resources/images/btn_count_up.gif' id='option_box3_up' class='option_box_up' alt='수량증가'>"
			html += "</a>"
			html += "<a href='#none' class='down eProductQuantityDownClass' data-target='option_box3_down'>"
			html += "<img src='/resources/images/btn_count_down.gif' id='option_box3_down' class='option_box_down' alt='수량감소'>"
			html += "</a>"
			html += "</span>"
			html += "<a href='#' class='delete'><img src='/resources/images/btn_price_delete.gif'>"
			html += "</a>"
			html += "</td>"
			html += "</tr>"
			html += "</table>"
			
			if($j(".Products-large").length < 1) {
				$j("#totalProducts").append(html);
			} else {
				alert("이미 선택되어있습니다.")				
			}
			//행 삭제	
			$j('.Products-large').on("click", ".delete", function() {
				$j('.Products-large ').remove();
			});
			
			
			var clicknum = 1;
			$j("#option_box3_up").on("click", function() {
				clicknum++;
				$j("input[type=text][id='option_box3_quantity']").val(clicknum);
			});

			$j("#option_box3_down").on("click", function() {
				var su = $j("#option_box3_quantity").val();
				if(su <=1) {
					alert("최소주문수량은 1개입니다.")
				} else {
					clicknum--;
				}
				$j("input[type=text][id='option_box3_quantity']").val(clicknum);

			});
		});
		
		$j("#xlarge").click(function() {
			var html = "<table class='Products-xlarge'>"
			html += "<tr>"
			html += "<td>"
			html += "<Strong>S.W. Carpenter Pant Black</Strong>"
			html += "<br>"
			html += "<span style='font-size:12px;'> - XL</span>"
			html += "</td>"
			html += "<td>"
			html +=	"<span class='quantity' style='width:65px;'>"
			html += "<input type='text' id='option_box4_quantity' name='quantity_opt[]' class='quantity_opt eProductQuantityClass' value='1' product-no='2672'>"
			html += "<a href='#none' class='up eProductQuantityUpClass' data-target='option_box4_up'>"
			html += "<img src='/resources/images/btn_count_up.gif' id='option_box4_up' class='option_box_up' alt='수량증가'>"
			html += "</a>"
			html += "<a href='#none' class='down eProductQuantityDownClass' data-target='option_box4_down'>"
			html += "<img src='/resources/images/btn_count_down.gif' id='option_box4_down' class='option_box_down' alt='수량감소'>"
			html += "</a>"
			html += "</span>"
			html += "<a href='#' class='delete'><img src='/resources/images/btn_price_delete.gif'>"
			html += "</a>"
			html += "</td>"
			html += "</tr>"
			html += "</table>"
			
			if($j(".Products-xlarge").length < 1) {
				$j("#totalProducts").append(html);
			} else {
				alert("이미 선택되어있습니다.")				
			}
			//행 삭제	
			$j('.Products-xlarge').on("click", ".delete", function() {
				$j('.Products-xlarge ').remove();
			});
			
			
			var clicknum = 1;
			$j("#option_box4_up").on("click", function() {
				clicknum++;
				$j("input[type=text][id='option_box4_quantity']").val(clicknum);
			});

			$j("#option_box4_down").on("click", function() {
				var su = $j("#option_box4_quantity").val();
				if(su <=1) {
					alert("최소주문수량은 1개입니다.")
				} else {
					clicknum--;
				}
				$j("input[type=text][id='option_box4_quantity']").val(clicknum);

			});
		});
		
		
	});

	
</script>
<body>
	<table id="newTable" align="center" width="520px;">
	<tr>
		<td>
			<c:if test="${sessionScope.userVo == null }">
			<a href="${pageContext.request.contextPath }/board/join.do">join</a>
			<a href="${pageContext.request.contextPath }/board/login.do">login</a>
			<div style="padding-left: 360px; display: inline-table;">total : ${totalCnt}</div>
			</c:if>
			<c:if test="${sessionScope.userVo != null }">
			<c:out value="[${userVo.userId }] 님 환영합니다."></c:out> 
			<a href="${pageContext.request.contextPath }/board/logout.do">logout</a>
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
								<td>
								<a href="/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td>
			<table id="" align="center" width="520px;">
			<tr>
				<td><input name="checkboxAll" type="checkbox" value="a05">전체
					<c:forEach items="${codeList }" var="list">
						<c:if test="${list.codeType eq 'menu' }">
							<input name="checkbox01" type="checkbox" value="${list.codeId }">${list.codeName }			
					</c:if>
					</c:forEach>
					<button type="button" id="search">검색</button>
					<p style="display: inline; padding-left: 120px;">
						<a href="/board/boardWrite.do">글쓰기</a>
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
			    <c:if test="${pageVo.pageNo < pageVo.totalPage  }">
			    <a href="boardList.do?pageNo=${pageVo.nextPage }">다음</a>
			    </c:if>
			    <a href="boardList.do?pageNo=${pageVo.totalPage }">마지막</a>
				</td>
			</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td>
			<div class="xans-element- xans-product xans-product-relation xans-record-">
				<div class="xans-element- xans-product xans-product-relationlist">
					<ul class="prdList">
						<li class="item xans-record-"><a href="#"><img alt="S.W. Carpenter Pant Mint" src="/resources/images/90312dd6d3e6123c8af84e87049220e2.jpg"></a></li>
						<li class="item xans-record-"><a href="#"><img alt="S.W. Carpenter Pant Mint" src="/resources/images/e051bb19cfcfbd5deb8ff6d8bda99a4e.jpg"></a></li>
					</ul>
				</div>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<ul>
				<li id="small" class="product" title="S"><a href="#">S</a></li>
				<li id="medium" class="product" title="M"><a href="#">M</a></li>
				<li id="large" class="product" title="L"><a href="#">L</a></li>
				<li id="xlarge" class="product" title="XL"><a href="#">XL</a></li>
			</ul>
			</td>
		</tr>
		<tr>
			<td>
			<div id="totalProducts">
			</td>
		</tr>
		<tr>
			<td>
			<div class="xans-element- xans-product xans-product-action">
			<div class="btnArea ">
			<a href="#none" class=" atb" onclick="product_submit(2, '/exec/front/order/basket/', this)">쇼핑백에 담기</a>
			<a href="#none" class=" buyb" onclick="product_submit(1, '/exec/front/order/basket/', this)">구매하기</a>
		<!-- 	<span class="displaynone sold">Sold out</span> -->
		<!--     <a href="#none" onclick="add_wishlist_nologin('/member/login.html');" class=" wishb">위시리스트에 담기</a> -->
		    </div>
		    </div>
			</td>
		</tr>
		<tr>
			<td>
			<div style="border: 1px solid black; width: 250px; padding: 10px">
				<p>Ajax TEST</p>
				id :&nbsp;<input type="text" id="idbtn" class="idbtn" size="10">
				<button class="buttonAjax" type="button" >중복확인</button><br>
				pw :<input type="password" id="pwbtn" class="pwbtn" size="10">
				
				<div style="margin: 5px"><button type="submit" id="checklogin">접속</button></div>
			</td>
			</div>
		</tr>
	</table>
	<div id="app">
		<table id="boardTable" border="1" style="border-collapse: collapse;" width="650px;">
			<tr style="background-color: #F2F5F6;">
				<td width="80" align="center">Type</td>
				<td width="40" align="center">No</td>
				<td width="300" align="center">Title</td>
			</tr>
			<tr v-for="item in data">
				<td>{{item.comCodeVo.codeName}}</td>	
				<td>{{item.boardNum}}</td>	
				<td><a href="">{{item.boardTitle}}</a></td>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
		new Vue({
			el : "#app",
			data() {
				return {
					data : [],
				}
			},
			mounted() {
				axios
				.post("/board/boardList.do")
// 				.then(response => {
// 					this.data = response.data;
// 				})
				.then(res => {
					this.data = res.data;
				})
			}
		});
	
	
	
		$j(document).ready(function() {
			
			var isChecked=false;
			
			$j(".buttonAjax").click(function() {
				
			var idbtn = $j("#idbtn").val();
			var pwbtn = $j("#pwbtn").val();
			

				$j.ajax({
					url: "/board/ajaxTest.do",
					type: "post",
					data: {idbtn:idbtn,pwbtn:pwbtn},
					success : function(result) {
						if(result==1) {
							isChecked=true;	
							alert("사용가능")
						} else {
							isChecked=false;
						}
						
					}
						
				});
				
			})
			
			$j("#checklogin").on('click', function() {
				
				if(isChecked==false) {
					alert("중복확인 버튼을 눌러주세요.")
				} else {
					alert("환영합니다.")
				}
			})
			
		});
	</script>
</body>
</html>