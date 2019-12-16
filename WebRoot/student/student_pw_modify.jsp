<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="basepath" value="${pageContext.request.contextPath}/" />
<html>
<head>
<link href="${basepath}/css/common_add_style.css" rel="stylesheet">
</head>
<body>
	<div id="div">
		<fieldset>
			<legend>修改密码</legend>
			<form action="${basepath}HandlePassword" method="post">
				<div class="add">
					<label for="newPassword">新密码：</label> <input type="text"
						name="newPassword" maxlength="16" required="required">
				</div>

				<div class="add">
					<label for="newPasswordAgain">再确认密码：</label> <input type="text"
						name="newPasswordAgain" required="required">
				</div>

				<div class="btn">
					<input type="submit" value="提交">
				</div>
			</form>
		</fieldset>
	</div>
</body>
</html>