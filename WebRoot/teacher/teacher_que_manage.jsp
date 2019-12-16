<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basepath" value="${pageContext.request.contextPath}" />
<html>
<head>
<link href="${basepath}/css/teacher_manage_style.css" rel="stylesheet">
<script src="${basepath}/js/jquery.js"></script>
</head>

<body>
	<script type="text/javascript">
		function del() {
			var msg = "您真的确定删除该条题目信息吗？\n\n请再次确认。"
			if (confirm(msg) == true) {
				return true;
			} else {
				return false;
			}
	
		}
	
		function change(e) {
			var filePath = $('#img').val();
			if (filePath.indexOf("jpg") != -1 || filePath.indexOf("png") != -1) {
				var arr = filePath.split('\\');
				var fileName = arr[arr.length - 1];
				$(".showFileName").html(fileName);
				console.log(fileName);
			}
		}
	
		$(document).ready(function() {
			if (localStorage.getItem('q_type')) {
				$("#q_type option").eq(localStorage.getItem('q_type')).prop('selected', true);
			}
	
			$('#q_type').change(function() {
				localStorage.setItem('q_type', $('option:selected', this).index());
				$('#form_type').submit();
			})
		})
	</script>


	<table>
		<caption>
			题库信息管理 <span>（共有${requestScope.total}条题目）</span>
			<a href="${basepath}/BatchOutServlet?mode=2" id="btn_excel" type="button">下载本表</a>
		</caption>
		<tr>
			<td class="short"><b>题号</b></td>
			<form name="form_type" id="form_type"
				action="${basepath}/ShowQuePage">
				<td class="short"><b><select name="q_type" id="q_type">
							<option value="">题型</option>
							<option value="单选题">单选题</option>
							<option value="多选题">多选题</option>
							<option value="判断题">判断题</option>
							<option value="填空题">填空题</option>
							<option value="简答题">简答题</option>
					</select></b></td>
			</form>
			<form action="${basepath}/ShowQuePage">
				<td class="long"><b>题目 <input type="text" name="q_title"
						size="10" placeholder="查询题目"> <input type="submit"
						value="查询"></b></td>
			</form>
			<td class="med"><b>选项A</b></td>
			<td class="med"><b>选项B</b></td>
			<td class="med"><b>选项C</b></td>
			<td class="med"><b>选项D</b></td>
			<td class="short"><b>分值</b></td>
			<td class="med"><b>答案/得分点</b></td>
			<td><b>配图</b></td>
			<td><b>操作</b></td>
		</tr>
		<c:forEach var="row" items="${requestScope.queTableList}"
			varStatus="status">
			<c:if test="${param.modify_id!= row.q_id}" var="flag"
				scope="request">
				<form action="" method="post" name="f${row.q_id}"></form>
				<c:if test="${status.count%2==0}">
					<tr align="left">
				</c:if>
				<c:if test="${status.count%2==1}">
					<tr align="left" bgcolor="#dfe4ea">
				</c:if>
				<td><c:out value="${row.q_id}" /></td>
				<td><c:out value="${row.q_type}" /></td>
				<td><c:out value="${row.q_title}" /></td>
				<td><c:out value="${row.options[0]}" /></td>
				<td><c:out value="${row.options[1]}" /></td>
				<td><c:out value="${row.options[2]}" /></td>
				<td><c:out value="${row.options[3]}" /></td>
				<td><c:out value="${row.q_score}" /></td>
				<td><c:out value="${row.q_key}" /></td>
				<td><c:if test="${not empty row.q_img}">
						<div class="img">
							<img alt="配图" src="${basepath}/images/${row.q_img}" style="width:100px;height:60px;object-fit:cover;">
						</div>
					</c:if></td>
				<td><input type=button value="修改"
					onclick="f${row.q_id}.action='?modify_id=${row.q_id}&cpage=${requestScope.cpage}&per=${requestScope.per}';f${row.q_id}.submit();">
					<input type=button value="删除"
					onclick="javascript:if(del()) {f${row.q_id}.action='HandleQue?executeMode=2&number=${row.q_id}&cpage=${requestScope.cpage}&per=${requestScope.per}';f${row.q_id}.submit();} ">
				</td>
				</tr>
			</c:if>
			<c:if test="${not flag}">

				<c:if test="${status.count%2==0}">
					<tr align="left">
				</c:if>
				<c:if test="${status.count%2==1}">
					<tr align="left" bgcolor="#dfe4ea">
				</c:if>
				<form action="" method="post" name="f${row.q_id}"
					enctype="multipart/form-data">
					<td><input type="text" value="${row.q_id}" name="number"
						readonly="readonly" class="text1" /></td>
					<td><input type="text" value="${row.q_type}" name="type"
						class="text1" /></td>
					<td><input type="text" value="${row.q_title}" name="title"
						class="text1" /></td>
					<td><input type="text" value="${row.options[0]}" name="select"
						class="text1" /></td>
					<td><input type="text" value="${row.options[1]}" name="select"
						class="text1" /></td>
					<td><input type="text" value="${row.options[2]}" name="select"
						class="text1" /></td>
					<td><input type="text" value="${row.options[3]}" name="select"
						class="text1" /></td>
					<td><input type="text" value="${row.q_score}" name="score"
						class="text1" /></td>
					<td><input type="text" value="${row.q_key}" name="key"
						class="text1" /></td>
					<td><a href="javascript:;" class="file"> <c:if
								test="${empty row.q_img}">
								<div class="showFileName">上传图片</div>
							</c:if> <c:if test="${not empty row.q_img}">
								<div class="showFileName">
									<c:out value="${row.q_img}" />
								</div>
							</c:if> <input type="file" value="${row.q_img}" name="img" class="text1"
							onchange="change(this)" id="img" /></a></td>
					<td><input type=button value="提交"
						onclick="f${row.q_id}.action='HandleQue?executeMode=1&cpage=${requestScope.cpage}&per=${requestScope.per}';f${row.q_id}.submit();">
						<input type=button value="删除"
						onclick="javascript:if(del()) {f${row.q_id}.action='HandleQue?executeMode=2&cpage=${requestScope.cpage}&per=${requestScope.per}';f${row.q_id}.submit();} ">
					</td>
				</form>
				</tr>
			</c:if>
		</c:forEach>
	</table>


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
								<%--其他页赋予相应的链接，通过get方法，给ShowQuePage生成相应的testtableList输出--%>
								<a href="./ShowQuePage?cpage=${page-1}&per=${requestScope.per}">${page}</a>
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
											href="./ShowQuePage?cpage=${page-1}&per=${requestScope.per}">${page}</a>
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


		每页 <a href="./ShowQuePage?cpage=${requestScope.cpage}&per=1">1</a> <a
			href="./ShowQuePage?cpage=${requestScope.cpage}&per=5">5</a> <a
			href="./ShowQuePage?cpage=${requestScope.cpage}&per=10">10</a> <a
			href="./ShowQuePage?cpage=${requestScope.cpage}&per=20">20</a> <a
			href="./ShowQuePage?cpage=${requestScope.cpage}&per=30">30</a> <a
			href="./ShowQuePage?cpage=${requestScope.cpage}&per=${requestScope.total}">ALL</a>
		条记录
	</div>

</body>
</html>