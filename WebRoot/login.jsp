<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="basepath" value="${pageContext.request.contextPath}" />
<html>
<head>

<link href="square/yellow.css" rel="stylesheet">
<link href="${basepath}/css/common_login_style.css" rel="stylesheet">
<script src="js/jquery.js"></script>
<script src="js/icheck.js"></script>

<script>
	$(document).ready(function() {
		$('input').iCheck({
			checkboxClass : 'icheckbox_square-yellow',
			radioClass : 'iradio_square-yellow',
			increaseArea : '20%' // optional
		});
	});
</script>
</head>
<body>

	<form action="HandleLogin" method="post" class="login-style">
		<table style="border-collapse:separate; border-spacing:0px 20px;"
			width="90%">
			<h1>
				在线考试系统|LOGIN <span>请登录.</span>
			</h1>
			<tr height="30px";>
				<td width="14%"><span>账&nbsp;&nbsp;号 :</span></td>
				<td width="70%"><input type="text" name="ID"
					placeholder="您的学号/教职工号" required="required" /></td>
			</tr>
			<tr>
				<td><span>密&nbsp;&nbsp;码 :</span></td>
				<td><input type="password" name="password" placeholder="您的密码" required="required"/></td>
			</tr>
			<tr>
				<td><span>身&nbsp;&nbsp;份 :</span></td>
				<td><input id="role" type="radio" name="role" value="teacher" />教师&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="role" type="radio" name="role" value="student"
					checked="checked" />学生</td>
			</tr>
			<tr>
				<td><span>&nbsp;</span></td>
				<td><input type="submit" value="登录" />&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value="重置" /></td>
			</tr>
		</table>
	</form>

</body>
</html>