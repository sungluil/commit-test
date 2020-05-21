<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table id="newTable" align="center" width="520px;">
		<tr>
			<td>
				<c:if test="${sessionScope.userVo == null }">
				<a href="${pageContext.request.contextPath }/board/join.do">join</a>
				<a href="${pageContext.request.contextPath }/board/login.do">login</a>
				<div style="padding-left: 360px; display: inline-table;">total : ${totalCnt}</div>
				</c:if>
				<c:if test="${sessionScope.userVo != null }">
				<a href="${pageContext.request.contextPath }/board/logout.do">logout</a>
				<c:out value="${userVo.userId } 님 환영합니다."></c:out> 
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
					<tbody id="">
						<c:forEach items="${boardList}" var="list">
							<tr>
								<td align="center">${list.comCodeVo.codeName}</td>
								<td align="center">${list.boardNum}</td>
								<td><a
									href="/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</td>
		</tr>
	</table>