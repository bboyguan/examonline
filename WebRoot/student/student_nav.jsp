<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basepath" value="${pageContext.request.contextPath}" />
<html>
<head>
<link href="${basepath}/css/common_nav_style.css" rel="stylesheet">
</head>
<body>
	     
	<ul>
		<li>
			<h3>学生信息</h3>
			<dl>
				<dd>
					<a href="student_info.jsp" target="rightframe">学生概况</a>
				</dd>
				<dd>
					<a href="student_pw_modify.jsp" target="rightframe">修改密码</a>
				</dd>
			</dl>
		</li>
		<li>
			<h3>考试管理</h3>
			<dl>
				<dd>
					<a href="student_exam_pre.jsp" target="rightframe">申请考试</a>
				</dd>
				<dd>
					<a href="student_score.jsp" target="rightframe">成绩查询</a>
				</dd>
			</dl>
		</li>
	</ul>
</body>
</html>
   
