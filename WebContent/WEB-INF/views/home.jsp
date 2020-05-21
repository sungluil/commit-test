<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="include/head.jsp" %>
<style>
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
li {
    list-style: none;
}
.xans-layout-category .position > ul {
    z-index: 10;
}
ul {
    margin: 0 0;
    padding: 0 0;
}
.xans-layout-category {
    position: absolute;
    top: 17px;
    left: 140px;
    margin: 0 0;
    z-index: 2019;
    height: auto;
    display: inline-block;
    width: auto;
    text-align: left;
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
#header {
    position: fixed;
    top: 0;
    left: 0;
    background: transparent;
    width: 100%;
    overflow: visible;
    display: block;
    height: 32px;
    z-index: 1029;
    box-sizing: border-box;
    border-bottom: 1px solid transparent;
}
#header > .inner {
    position: relative;
    top: 0px;
    width: 100%;
    max-width: 100%;
    margin: 0 0;
    box-sizing: border-box;
    border: 0px solid #111;
    display: block;
    height: auto;
    z-index: 99;
    padding: 8px 20px;
/*     zoom: 1; */
}
element.style {
    display: block;
}
</style>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <%@ include file="include/main_header.jsp" %>
  
  <%@ include file="include/left_column.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        홈페이지~
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
        
       <iframe src="/home/${pageChange }.do" width="600px;" height="500px;"
       frameborder="0" framespacing="0" marginheight="0" marginwidth="0" 
       scrolling="no" space="0"></iframe>
       


    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <%@ include file="include/main_footer.jsp" %>

  <div class="control-sidebar-bg"></div>
</div>
<%@ include file="include/plugin_js.jsp" %>
</body>
</html>