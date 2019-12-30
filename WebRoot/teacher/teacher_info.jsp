<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="basepath" value="${pageContext.request.contextPath}" />
<html>

<head>
<link href="${basepath}/css/common_info_style.css" rel="stylesheet">
</head>

<body>


	<sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/examination?useUnicode=true&serverTimezone=UTC&characterEncoding=utf-8"
		user="root" password="root" />
	<sql:query dataSource="${db}" var="student">
		SELECT * FROM student ;
	</sql:query>

	<sql:query dataSource="${db}" var="score">
		SELECT * FROM student Where score >=0;
	</sql:query>

	<sql:query dataSource="${db}" var="max_min">
		select max(score) max ,min(score) min from student where score >= 0;
	</sql:query>

	<c:set value="0" var="sum" />
	<c:forEach var="row1" items="${score.rows}">
		<c:set var="sum" value="${sum+row1.score}" />
	</c:forEach>


	<sql:query dataSource="${db}" var="que">
		SELECT * FROM question ;
	</sql:query>

	<c:set var="mutiq" value="0" />
	<c:set var="sinq" value="0" />
	<c:set var="judq" value="0" />
	<c:set var="essq" value="0" />
	<c:set var="fillq" value="0" />

	<c:forEach var="row3" items="${que.rows}">
		<c:choose>
			<c:when test="${row3.type eq '单选题'}">
				<c:set var="sinq" value="${sinq+1}"></c:set>
			</c:when>
			<c:when test="${row3.type eq '多选题'}">
				<c:set var="mutiq" value="${mutiq+1}"></c:set>
			</c:when>
			<c:when test="${row3.type eq '判断题'}">
				<c:set var="judq" value="${judq+1}"></c:set>
			</c:when>
			<c:when test="${row3.type eq '填空题'}">
				<c:set var="fillq" value="${fillq+1}"></c:set>
			</c:when>
			<c:when test="${row3.type eq '简答题'}">
				<c:set var="essq" value="${essq+1}"></c:set>
			</c:when>
		</c:choose>
	</c:forEach>

	<div id="div">
		<p>
		<h3>教师信息</h3>
		<c:out value="教工号：${loginBean.ID}" />
		<br>
		<c:out value="姓名：${loginBean.name}" />
		<br>
		<c:out value="任课班级：${loginBean.CLASS}" />
		<br>
		<c:out value="职称：${loginBean.job}" />
		</p>
		<hr>
		<p>
		<h3>考生信息</h3>
		<c:out value="您管理的班级共有${student.rowCount}名学生。" />
		<br />
		<c:out value="其中，共有${score.rowCount}名考生完成了考试。" />
		<br /> ————————————<br /> 已完成考试的学生成绩统计：<br />

		<c:forEach var="row" items="${max_min.rows}" varStatus="status">
			<c:out value="最高分：${row.max}分">
			</c:out>
			<br />
			<c:out value="最低分：${row.min}分"></c:out>
			<br />
		</c:forEach>
		平均分：
		<fmt:formatNumber value="${sum/score.rowCount}" minFractionDigits="1"
			maxFractionDigits="1" />
		分 <br />
		</p>
		<hr>
		<p>
		<h3>题库信息</h3>
		<c:out value="题库共有题目：${que.rowCount}道" />
		<br /> ————————————<br /> 其中包含：<br />
		<c:out value="单项选择题：${sinq}道" />
		<br />
		<c:out value="多项选择题：${mutiq}道" />
		<br />
		<c:out value="判断题：${judq}道" />
		<br />
		<c:out value="填空题：${fillq}道" />
		<br />
		<c:out value="简答题：${essq}道" />
		<br />
		</p>
	</div>
</body>
</html>