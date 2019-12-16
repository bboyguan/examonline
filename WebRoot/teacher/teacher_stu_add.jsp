<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basepath" value="${pageContext.request.contextPath}" />
<html>
<head>
<link href="${basepath}/css/common_add_style.css" rel="stylesheet">
</head>
<body>
	<div id="div">

		<fieldset style="float:left">
			<legend>添加学生</legend>
			<form action="${basepath}HandleStuInfo?executeMode=0" method="post">
				<div class="add">
					<label for="id">学号：</label> <input type="text" name="ID"
						maxlength="15" required="required">
				</div>
				<div class="add">
					<label for="password">密码：</label> <input type="text"
						name="password" maxlength="8" required="required">
				</div>
				<div class="add">
					<label for="name">姓名：</label> <input type="text" name="name"
						required="required">
				</div>
				<div class="add">
					<label for="class">班级：</label> <input type="text" name="class">
				</div>
				<div class="add">
					<label for="password">成绩：</label> <input type="text" name="score">
				</div>
				<div class="btn">
					<input type="submit" value="提交">
				</div>
			</form>
		</fieldset>
		<fieldset>
			<legend>批量添加学生</legend>
			<form action="${basepath}/HandleBatchAdd?mode=2" method="post"
				enctype="multipart/form-data">
				<div class="add">
					<label for="excel">表单：</label> <input type="file" name="excel"
						id="excel" />
				</div>
				<div class="btn">
					<input type="submit" value="提交">
				</div>
			</form>
		</fieldset>
	</div>
</body>
</html>