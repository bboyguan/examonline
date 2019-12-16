<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="basepath" value="${pageContext.request.contextPath}" />
<html>
<head>
<link href="${basepath}/css/common_top_style.css" rel="stylesheet">
</head>
<body>
	<div id="top">
		<c:if test="${sessionScope.loginBean.role eq 'student'}">
			<h2>欢迎使用在线考试系统[学生端]</h2>
			<c:out value="你好，${loginBean.name}同学。" />
		</c:if>
		<c:if test="${sessionScope.loginBean.role eq 'teacher'}">
			<h2>欢迎使用在线考试系统[教师端]</h2>
			<c:out value="您好，${loginBean.name}${loginBean.job}。" />
		</c:if>
		<a href="HandleExit" target="_top" onclick="logout()">[退出]</a>
	</div>
</body>
</html>