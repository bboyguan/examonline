<%@ page contentType="text/html;charset=utf-8"%>
<html>

<head>
<title>在线考试教师端</title>
<frameset rows="14%,86%">
	<frame src="${pageContext.request.contextPath}/common_nav_top.jsp">
	<frameset cols="12%,88%">
		<frame src="${pageContext.request.contextPath}/teacher/teacher_nav.jsp" />
		<frame src="${pageContext.request.contextPath}/teacher/teacher_info.jsp" name="rightframe" />
	</frameset>
</frameset>
</head>

</html>