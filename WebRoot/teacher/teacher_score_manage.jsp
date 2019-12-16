<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basepath" value="${pageContext.request.contextPath}" />
<html>
<head>
<link href="${basepath}/css/teacher_manage_style.css" rel="stylesheet">
</head>

<body>
	<script type="text/javascript">
		function del() {
			var msg = "您真的确定删除该学生信息吗？\n\n请再次确认。"
			if (confirm(msg) == true) {
				return true;
			} else {
				return false;
			}
	
		}
	</script>

	<table>
		<caption>

			<form action="${basepath}/ShowScorePage" id="queryForm"
				style="margin:0px;display:inline; float:left">
				<input type="text" name="s_ID" size="10" placeholder="查询学号">
				<input type="submit" value="查询">
			</form>
			学生成绩管理 <span>（共有${requestScope.total}名学生）</span> <a
				href="${basepath}/BatchOutServlet?mode=3" id="btn_excel"
				type="button">下载本表</a>
		</caption>
		<tr>
			<td class="med"><b>学号 </b></td>
			<td class="med"><b>班级</b></td>
			<td class="med"><b>姓名</b></td>
			<td class="med"><b>单选分</b></td>
			<td class="med"><b>多选分</b></td>
			<td class="med"><b>判断分</b></td>
			<td class="med"><b>填空分</b></td>
			<td class="med"><b>问答分</b></td>
			<td class="med"><b>总分</b></td>
			<td class="med"><b>评价</b></td>
			<td><b>操作</b></td>
		</tr>
		<c:forEach var="row" items="${requestScope.stuTableList}"
			varStatus="status">
			<c:if test="${param.modify_id != row.ID}" var="flag"
				scope="request">
				<form action="" method="post" name="f${row.ID}"
					enctype="multipart/form-data">
					<c:if test="${status.count%2==0}">
						<tr align="left">
					</c:if>
					<c:if test="${status.count%2==1}">
						<tr align="left" bgcolor="#dfe4ea">
					</c:if>
					<td><c:out value="${row.ID}" /></td>
					<td><c:out value="${row.CLASS}" /></td>
					<td><c:out value="${row.name}" /></td>
					<td><c:out value="${row.score_sing}" /></td>
					<td><c:out value="${row.score_muti}" /></td>
					<td><c:out value="${row.score_jud}" /></td>
					<td><c:out value="${row.score_fill}" /></td>
					<td><c:out value="${row.score_ess}" /></td>
					<td><c:out value="${row.score}" /></td>
					<td><c:choose>
							<c:when test="${row.score>=95}">
								<c:out value="优秀" />
							</c:when>
							<c:when test="${row.score>=85&&row.score<95}">
								<c:out value="良好" />
							</c:when>
							<c:when test="${row.score>=75&&row.score<85}">
								<c:out value="中等" />
							</c:when>
							<c:when test="${row.score>=60&&row.score<75}">
								<c:out value="及格" />
							</c:when>
							<c:when test="${empty row.score||row.score==-1}">
								<c:out value="缺考" />
							</c:when>
							<c:otherwise>
								<c:out value="不及格" />
							</c:otherwise>
						</c:choose></td>
					<td><input type=button value="修改"
						onclick="f${row.ID}.action='?modify_id=${row.ID}&cpage=${requestScope.cpage}&per=${requestScope.per}';f${row.ID}.submit()">
						<input type=button value="删除"
						onclick="javascript:if(del()){f${row.ID}.action='ScoreModify?executeMode=2&ID=${row.ID}&cpage=${requestScope.cpage}&per=${requestScope.per}';f${row.ID}.submit();}">
					</td>
					</tr>
				</form>
			</c:if>
			<c:if test="${not flag}">
				<form action="" method="post" name="f${row.ID}">
					<c:if test="${status.count%2==0}">
						<tr align="left">
					</c:if>
					<c:if test="${status.count%2==1}">
						<tr align="left" bgcolor="#dfe4ea">
					</c:if>
					<td><input type="text" size="10" value="${row.ID}" name="ID"
						readonly="readonly" class="text1" /></td>
					<td><input type="text" size="10" value="${row.CLASS}"
						name="class" class="text1" /></td>
					<td><input type="text" size="10" value="${row.name}"
						name="name" class="text1" /></td>
					<td><input type="text" size="10" value="${row.score_sing}"
						name="score_sing" class="text1" /></td>
					<td><input type="text" size="10" value="${row.score_muti}"
						name="score_muti" class="text1" /></td>
					<td><input type="text" size="10" value="${row.score_jud}"
						name="score_jud" class="text1" /></td>
					<td><input type="text" size="10" value="${row.score_fill}"
						name="score_fill" class="text1" /></td>
					<td><input type="text" size="10" value="${row.score_ess}"
						name="score_ess" class="text1" /></td>
					<td><input type="text" size="10" value="${row.score}"
						name="score" class="text1" /></td>
					<td><c:choose>
							<c:when test="${row.score>=95}">
								<c:out value="优秀" />
							</c:when>
							<c:when test="${row.score>=85&&row.score<95}">
								<c:out value="良好" />
							</c:when>
							<c:when test="${row.score>=75&&row.score<85}">
								<c:out value="中等" />
							</c:when>
							<c:when test="${row.score>=60&&row.score<75}">
								<c:out value="及格" />
							</c:when>
							<c:when test="${empty row.score||row.score==-1}">
								<c:out value="缺考" />
							</c:when>
							<c:otherwise>
								<c:out value="不及格" />
							</c:otherwise>
						</c:choose></td>
					<td><input type=button value="提交"
						onclick="f${row.ID}.action='ScoreModify?executeMode=1&cpage=${requestScope.cpage}&per=${requestScope.per}';f${row.ID}.submit()">
						<input type=button value="删除"
						onclick="javascript:if(del()){f${row.ID}.action='ScoreModify?executeMode=2&cpage=${requestScope.cpage}&per=${requestScope.per}';f${row.ID}.submit();}">
					</td>
					</tr>
				</form>
			</c:if>

		</c:forEach>
	</table>


	<h3 style="text-align:center">
		<c:if test="${not empty param.modify_id }">
		**注意：您正在修改<c:out value="${param.modify_id}"></c:out>号考生的信息！**
		</c:if>
	</h3>


	<div style="margin-top:1em;text-align:center">
		<c:if test="${requestScope.totalPage>1}">
		[
		<%--定义计算缩略点的变量count_points，当发现已经输出3个.则没必要继续输出缩略点了--%>
			<c:set var="count_points" value="0" />
			<%--循环从第一页一直到总页数--%>
			<c:forEach var="page" begin="1" end="${requestScope.totalPage}">
				<c:choose>
					<%--如果少于直接输出全部页面--%>
					<c:when test="${requestScope.totalPage<7}">
						<c:choose>
							<%--当前页不给予超级链接--%>
							<%--后台Java方法的处理是从第0页开始，因此当前页的判断是cpage+1=page--%>
							<c:when test="${requestScope.cpage+1==page}">${requestScope.cpage+1}</c:when>
							<c:otherwise>
								<%--其他页赋予相应的链接，通过get方法，给ShowScorePage生成相应的testtableList输出--%>
								<a href="./ShowScorePage?cpage=${page-1}&per=${requestScope.per}">${page}</a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
							<%--如超过7页，输出当前页的前1页、后1页、首页、末页--%>
							<c:when
								test="${(page<(requestScope.cpage+1)+2) and (page>(requestScope.cpage+1)-2) or (page==1) or (page==totalPage)}">
								<c:choose>
									<c:when test="${requestScope.cpage+1==page}">${requestScope.cpage+1}</c:when>
									<c:otherwise>
										<a
											href="./ShowScorePage?cpage=${page-1}&per=${requestScope.per}">${page}</a>
									</c:otherwise>
								</c:choose>
								<c:set var="count_points" value="0" />
							</c:when>
							<c:otherwise>
								<c:if test="${count_points<3}">
									<%--否则，则输出缩略点，同时保证缩略点不超过三个--%>
									<c:set var="count_points" value="${count_points+1}" />.
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		]第${requestScope.cpage+1}/${requestScope.totalPage}页
		</c:if>


		每页 <a href="./ShowScorePage?cpage=${requestScope.cpage}&per=1">1</a> <a
			href="./ShowScorePage?cpage=${requestScope.cpage}&per=5">5</a> <a
			href="./ShowScorePage?cpage=${requestScope.cpage}&per=10">10</a> <a
			href="./ShowScorePage?cpage=${requestScope.cpage}&per=20">20</a> <a
			href="./ShowScorePage?cpage=${requestScope.cpage}&per=30">30</a> <a
			href="./ShowScorePage?cpage=${requestScope.cpage}&per=${requestScope.total}">ALL</a>
		条记录
	</div>

</body>
</html>