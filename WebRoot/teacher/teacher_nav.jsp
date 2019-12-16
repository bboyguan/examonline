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
			<h3>教务管理</h3>
			<dl>
				<dd>
					<a href="teacher_info.jsp" target="rightframe">教务信息</a>
				</dd>

				<dd>
					<a href="${basepath}/ShowStuPage" target="rightframe">考生管理</a>
				</dd>
				<dd>
					<a href="${basepath}/ShowScorePage" target="rightframe">成绩管理</a>
				</dd>
				<dd>
					<a href="teacher_stu_add.jsp" target="rightframe">考生录入</a>
				</dd>
			</dl>
		</li>
		<li>
			<h3>题库管理</h3>
			<dd>
				<a href="${basepath}/ShowQuePage" target="rightframe">题库管理</a>
			</dd>
			<dd>
				<a href="teacher_que_add.jsp" target="rightframe">题库录入</a>
			</dd>
			<dd>
				<a href="teacher_paper_manage.jsp" target="rightframe">试卷设置</a>
			</dd>
		</li>
	</ul>
</body>
</html>