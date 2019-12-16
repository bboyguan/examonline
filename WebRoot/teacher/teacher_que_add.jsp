<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basepath" value="${pageContext.request.contextPath}" />
<html>
<head>
<link href="${basepath}/css/common_add_style.css" rel="stylesheet">
</head>
<body>
	<div id="div">
		<fieldset style="float:left">
			<legend>添加题目</legend>
			<form action="${basepath}/HandleQue?executeMode=0" method="post"
				enctype="multipart/form-data">
				<div class="add">
					<label for="number">题号：</label> <input type="text" name="number"
						maxlength="15" required="required">
				</div>
				<div class="add">
					<label for="img">配图：</label> <input type="file" name="img"
						maxlength="15">
				</div>
				<div class="add">
					<label for="type">题型：</label> <br /> <select name="type">
						<option value="单选题">单选题</option>
						<option value="多选题">多选题</option>
						<option value="判断题">判断题</option>
						<option value="填空题">填空题</option>
						<option value="简答题">简答题</option>
					</select>

				</div>
				<div class="add">
					<label for="title">题目：</label>
					<textarea rows="6" cols="50" name="title" required="required"></textarea>
				</div>

				<div class="select">
					<span>选项（选择题必填）：</span><br>
					<table width=90%>
						<tr>
							<td width=25%>A选项：</td>
							<td width=50%><input type="text" name="select"></td>
						</tr>
						<tr>
							<td>B选项：</td>
							<td><input type="text" name="select"></td>
						</tr>
						<tr>
							<td>C选项：</td>
							<td><input type="text" name="select"></td>
						</tr>
						<tr>
							<td>D选项：</td>
							<td><input type="text" name="select"></td>
						</tr>
					</table>
				</div>
				<div class="add">
					<label for="score">分值：</label> <input type="text" name="score"
						required="required">
				</div>
				<div class="add">
					<label for="key">答案/得分点：</label> <input type="text" name="key"
						required="required">
				</div>
				<div class="btn">
					<input type="submit" value="提交">
				</div>
			</form>
		</fieldset>
		<fieldset>
			<legend>批量添加题目</legend>
			<form action="${basepath}/HandleBatchAdd?mode=1" method="post"
				enctype="multipart/form-data" accept-charset="UTF-8">
				<div class="add">
					<label for="excel">表单：</label><input type="file" name="excel"
						id="excel" /><br>
					<br> <label for="img">配图：</label> <input type="file"
						name="img" id="img" multiple="multiple" />
				</div>
				<div class="btn">
					<input type="submit" value="提交">
				</div>
			</form>
		</fieldset>
	</div>
</body>
</html>