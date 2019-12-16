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
		user="root" password="0000" />
		
	<sql:query dataSource="${db}" var="score">
		SELECT * from score where ID = ${loginBean.ID};
	</sql:query>

	<div id="divmin">
		<c:if test="${isAbsent}">
			<p>请${loginBean.name}同学先完成考试。</p>
			<p>
				[ <a href="student_exam_pre.jsp">申请考试</a> ]
			</p>
		</c:if>
		<c:if test="${not isAbsent}">
			<c:forEach var="score_row" items="${score.rows}" varStatus="status">

				<fieldset>
					<legend>考生成绩单</legend>
					<table width="100%" />
					<tr bgcolor="#dfe4ea">
						<td width="30%"><b>考生号：</b></td>
						<td width="70%"><c:out value="${score_row.ID}" /></td>
					</tr>
					<tr>
						<td><b>姓&nbsp;&nbsp;&nbsp;名：</b></td>
						<td><c:out value="${loginBean.name}" /></td>
					</tr>

					<tr bgcolor="#dfe4ea">
						<td><b>单选题：</b></td>
						<td><c:out value="${score_row.score_sing}" /></td>
					</tr>
					<tr>
						<td><b>多选题：</b></td>
						<td><c:out value="${score_row.score_muti}" /></td>
					</tr>
					<tr bgcolor="#dfe4ea">
						<td><b>判断题：</b></td>
						<td><c:out value="${score_row.score_jud}" /></td>
					</tr>
					<tr>
						<td><b>填空题：</b></td>
						<td><c:out value="${score_row.score_fill}" /></td>
					</tr>
					<tr bgcolor="#dfe4ea">
						<td><b>简答题：</b></td>
						<td><c:out value="${score_row.score_ess}" /></td>
					</tr>
					<tr>
						<td><b>总&nbsp;&nbsp;&nbsp;分：</b></td>
						<td><c:out value="${score_row.score}" /></td>
					</tr>
					<tr bgcolor="#dfe4ea">
						<td><b>评&nbsp;&nbsp;&nbsp;价：</b></td>
						<td><c:choose>
								<c:when test="${score_row.score>=95}">
									<c:out value="优秀" />
								</c:when>
								<c:when test="${score_row.score>=85&&score_row.score<95}">
									<c:out value="良好" />
								</c:when>
								<c:when test="${score_row.score>=75&&score_row.score<85}">
									<c:out value="中等" />
								</c:when>
								<c:when test="${score_row.score>=60&&score_row.score<75}">
									<c:out value="及格" />
								</c:when>
								<c:when test="${flag}">
									<c:out value="缺考" />
								</c:when>
								<c:otherwise>
									<c:out value="不及格" />
								</c:otherwise>
							</c:choose></td>
					</tr>
					</table>
				</fieldset>

			</c:forEach>
		</c:if>
	</div>
</body>
</html>