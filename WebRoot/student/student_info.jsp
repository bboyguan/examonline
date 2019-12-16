<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="basepath" value="${pageContext.request.contextPath}" />
<html>
<head>
<link href="${basepath}/css/common_info_style.css" rel="stylesheet">
</head>

<body>

	<div id="div">
		<h3>学生信息</h3>
		<b>学号：</b>
		<c:out value="${loginBean.ID}"></c:out>
		<br> <b>姓名：</b>
		<c:out value="${loginBean.name}"></c:out>
		<br> <b>班级：</b>
		<c:out value="${loginBean.CLASS}"></c:out>
		<br>
		<hr>

		<h3>考试信息</h3>
		<b>分数：</b>
		<c:if test="${empty loginBean.score||loginBean.score==-1}"
			var="isAbsent" scope="session">
			<c:out value="缺考"></c:out>
		</c:if>
		<c:if test="${not isAbsent}">
			<fmt:formatNumber value="${loginBean.score}" minFractionDigits="1"
				maxFractionDigits="1" />
		</c:if>
		<br> <b>评价：</b>
		<c:choose>
			<c:when test="${loginBean.score>=95}">
				<c:out value="优秀" />
			</c:when>
			<c:when test="${loginBean.score>=85&&loginBean.score<95}">
				<c:out value="良好" />
			</c:when>
			<c:when test="${loginBean.score>=75&&loginBean.score<85}">
				<c:out value="中等" />
			</c:when>
			<c:when test="${loginBean.score>=60&&loginBean.score<75}">
				<c:out value="及格" />
			</c:when>
			<c:when test="${isAbsent}">
				<c:out value="缺考" />
			</c:when>
			<c:otherwise>
				<c:out value="不及格" />
			</c:otherwise>
		</c:choose>
		<hr>
	</div>
</body>
</html>