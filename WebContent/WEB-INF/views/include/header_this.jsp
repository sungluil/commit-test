<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#i_1 .xans-layout-category, #header.on .xans-layout-category {
    top: 7px;
}
.xans-layout-category {
/*     position: absolute; */
    top: 17px;
    left: 140px;
    margin: 0 0;
    z-index: 2019;
    height: auto;
    display: inline-block;
    width: auto;
    text-align: left;
}
#i_1 .xans-layout-category .position {
    margin: 0 0;
}
.xans-layout-category .position {
    display: block;
    margin: 0 0;
}
.xans-layout-category .position > ul {
    z-index: 10;
}
ul {
    margin: 0 0;
    padding: 0 0;
}
.xans-layout-category .position > ul > li {
    position: relative;
    z-index: 10;
    display: inline-block;
    margin: 0 16px 0 0;
}
ul li {
    list-style: none;
    margin: 0 0;
    padding: 0 0;
}
.xans-layout-category .position ul li a {
    transition: all 0.0s ease-in-out;
}
.xans-layout-category .position > ul > li > a {
    font-size: 10px !important;
    color: #111;
    text-transform: none;
    position: relative;
    padding: 2px 0 1px;
    text-decoration: none;
    display: inline-block;
    z-index: 99 !important;
}
.xans-layout-category .position ul li a {
    font-style: normal;
    font-size: 10px !important;
    text-transform: uppercase !important;
}
.xans-layout-category .position ul li a span {
    display: inline-block;
    padding-bottom: 0px;
    border-bottom: 1px solid transparent;
    transition: all 0.0s ease-in-out;
}
.xans-layout-category #lb_nv .sub-menu {
    min-width: 200px;
}
.xans-layout-category .sub-menu {
    position: absolute;
    top: 0px;
    left: -8px;
    width: 100%;
    z-index: 2018;
    padding-top: 28px;
    display: block;
    z-index: 1;
    min-width: 148px;
    display: none;
}
.xans-layout-category .sub-menu ul {
    border: 0px solid #111;
    z-index: 18;
    background: gray;
    width: 100%;
    height: auto;
    padding: 8px 8px 12px;
    display: block;
    text-align: left;
    display: block;
    margin: 0 0;
}
.xans-layout-category .sub-menu li {
    display: block;
    float: none;
    padding: 4px 0;
    width: 100%:;
}
.xans-layout-category .position ul li a {
    font-size: 10px !important;
    color: #111;
}
.xans-layout-category .position ul li a:hover {
    font-size: 10px !important;
    font-weight:bold;
}
.xans-layout-category .sub-menu ul li a:hover {
    font-size: 10px !important;
    font-weight:bold;
    color: black;
}

</style>
</head>
<body>
<div id="header">
	<div class="inner">
		<div class="logo">
<!-- 		<a href="/ko.html"><img src="/resources/images/lg-1.svg" alt="thisisneverthat"></a> -->
			<div id="category"
				class="xans-element- xans-layout xans-layout-category">
				<div class="position">
					<ul>
						<li class="xans-record-"><a
							href="/product/list.html?cate_no=58"><span>Shop</span></a></li>
						<li id="lb_nv"><a href="#none"><span>Lookbook</span></a>
							<div class="sub-menu">
								<ul>
									<li><a href="/lookbook/san-francisco.html"><span>San
												Francisco, 2019</span></a></li>
									<li><a
										href="/lookbook/new-balance-x-thisisneverthat.html"><span><span
												class="lwr">thisisneverthat</span>® ✕ New Balance®</span></a></li>
									<li><a href="/lookbook/ss20.html"><span>ss20
												lookbook</span></a></li>
									<li><a href="/lookbook/bags.html"><span>bags</span></a></li>
								</ul>
							</div></li>
						<li><a href="https://thisisneverthat.com/-/s20.html"
							target="_blank"><span>ss20</span></a></li>
						<li><a href="https://thisisneverthat.com/-/" target="_blank"><span>Archive</span></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<div>
<div class="dropdown">
  <button id="dLabel1" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Dropdown trigger
    <span class="caret"></span>
  </button>
  <ul id="menu1" class="dropdown-menu" role="menu" aria-labelledby="dLabel1">
    ...
  </ul>
</div>
<div class="dropdown">
  <button id="dLabel2" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Dropdown trigger
    <span class="caret"></span>
  </button>
  <ul id="menu2" class="dropdown-menu" role="menu" aria-labelledby="dLabel2">
    ...
  </ul>
</div>
</div>


</body>
<script type="text/javascript">
$j(function (){
	$j("#lb_nv").hover(function() {
		$j(".sub-menu").css("display", "block");
	}, function() {
		$j(".sub-menu").css("display", "none");
	});
});
</script>
</html>