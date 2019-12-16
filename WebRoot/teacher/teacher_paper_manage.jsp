<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<c:set var="basepath" value="${pageContext.request.contextPath}" />
<html>
<head>
<link href="${basepath}/css/teacher_manage_style.css" rel="stylesheet">
</head>

<body>

	<sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/examination?useUnicode=true&serverTimezone=UTC&characterEncoding=utf-8"
		user="root" password="0000" />
	<sql:query dataSource="${db}" var="paper">
		SELECT * FROM paper ;
	</sql:query>

	<table>
		<caption>
			试卷设置
		</caption>
		<tr>
			<td class="med"><b>卷号</b></td>
			<td class="med"><b>答题时间（分钟）</b></td>
			<td class="med"><b>单选题数量</b></td>
			<td class="med"><b>多选题数量</b></td>
			<td class="med"><b>判断题数量</b></td>
			<td class="med"><b>填空题数量</b></td>
			<td class="med"><b>简答题数量</b></td>
			<td class="med"><b>总题目数量</b></td>
			<td class="med"><b>操作</b></td>
		</tr>
		<c:forEach var="row" items="${paper.rows}"
			varStatus="status">
			<c:if test="${param.modify_id != row.id}" var="flag"
				scope="request">
				<form action="" method="post" name="f${row.id}">
					<c:if test="${status.count%2==0}">
						<tr align="left">
					</c:if>
					<c:if test="${status.count%2==1}">
						<tr align="left" bgcolor="#dfe4ea">
					</c:if>
					<td><c:out value="${row.id}" /></td>
					<td><c:out value="${row.time}" /></td>
					<td><c:out value="${row.qty_sing}" /></td>
					<td><c:out value="${row.qty_muti}" /></td>
					<td><c:out value="${row.qty_jud}" /></td>
					<td><c:out value="${row.qty_fill}" /></td>
					<td><c:out value="${row.qty_ess}" /></td>
					<td><c:out value="${row.quantity}" /></td>
					<td><input type=button value="修改"
						onclick="f${row.id}.action='?modify_id=${row.ID}';f${row.ID}.submit()">
					</td>
					</tr>
				</form>
			</c:if>
			<c:if test="${not flag}">
				<form action="" method="post" name="f${row.id}">
					<c:if test="${status.count%2==0}">
						<tr align="left">
					</c:if>
					<c:if test="${status.count%2==1}">
						<tr align="left" bgcolor="#dfe4ea">
					</c:if>
					<td><input type="text"  value="${row.id}" name="id"
						readonly="readonly" class="text1" /></td>
					<td><input type="text" value="${row.time}"
						name="time" class="text1" /></td>
					<td><input type="text"  value="${row.qty_sing}"
						name="qty_sing" class="text1" /></td>
					<td><input type="text"  value="${row.qty_muti}"
						name="qty_muti" class="text1" /></td>
					<td><input type="text"  value="${row.qty_jud}"
						name="qty_jud" class="text1" /></td>
					<td><input type="text" value="${row.qty_fill}"
						name="qty_fill" class="text1" /></td>
					<td><input type="text"  value="${row.qty_ess}"
						name="qty_ess" class="text1" /></td>
					<td><input type="text"  value="${row.quantity}"
						name="quantity" class="text1" /></td>
					<td><input type=button value="提交"
						onclick="f${row.ID}.action='${basepath}/PaperQuantity';f${row.ID}.submit()">
					</td>
					</tr>
				</form>
			</c:if>

		</c:forEach>
	</table>
</body>
</html>