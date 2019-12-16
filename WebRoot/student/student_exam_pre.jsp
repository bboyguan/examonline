<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<c:set var="basepath" value="${pageContext.request.contextPath}/" />
<html>
<head>
<link href="${basepath}/css/common_info_style.css" rel="stylesheet">
</head>

<body>
	<sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/examination?useUnicode=true&serverTimezone=UTC&characterEncoding=utf-8"
		user="root" password="0000" />
	<sql:query dataSource="${db}" var="paper">
		SELECT * FROM paper ;
	</sql:query>
	<div id="div">
		<c:if test="${isAbsent}">
			<c:forEach var="row" items="${paper.rows}" varStatus="status">
			<p>
			<h3>考生须知</h3>
				*本次考试时间为<c:out value="${row.time}"></c:out>分钟*		<br>
				*全卷共<c:out value="${row.quantity}"></c:out>题，100分*		<br>
				*单项选择题<c:out value="${row.qty_sing}"></c:out>道，每道3分，共15分*		<br>
				*多项选择题<c:out value="${row.qty_muti}"></c:out>道，每道5分，共20分*		<br>
				*判断题<c:out value="${row.qty_jud}"></c:out>道，每道4分，共20分*		<br>
				*填空题<c:out value="${row.qty_fill}"></c:out>道，每道3分，共15分*		<br>
				*简答题<c:out value="${row.qty_ess}"></c:out>道，每道10分，共30分*		<br>
				*点击开始考试按钮，倒计时即刻开始* <br>
				*开始考试后不得中途停止*		<br>
				*请诚信考试，不得作弊*	<br>
			</p>
			</c:forEach>
			<form action="${basepath}/HandlePaper" target="_top">
				<div class="btn">
					<input type="submit" value="开始考试">
				</div>
			</form>
		</c:if>
		<c:if test="${not isAbsent}">
			<p>${loginBean.name}同学，你已经参加过该次考试。</p>
			<p>
				[ <a href="student_score.jsp">查看成绩</a> ]
			</p>
		</c:if>
	</div>

</body>
</html>