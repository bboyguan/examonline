<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="basepath" value="${pageContext.request.contextPath}" />
<html>
<head>
<link href="${basepath}/css/student_exam_paper_style.css"
	rel="stylesheet">
<link href="${basepath}/square/square.css" rel="stylesheet">
<script src="${basepath}/js/jquery.js"></script>
<script src="${basepath}/js/icheck.js"></script>
<%
	long curTime = System.currentTimeMillis() / 1000;
	request.setAttribute("curTime", curTime);
%>
<c:if test="${empty endTime}">
	<c:set var="endTime" scope="session" value="${curTime+sessionScope.examTime*60}" />
</c:if>
<script>
	var second =(${sessionScope.endTime-curTime});
	var timer=null;
	var showTime = function(){
		var s = second % 60; // 秒
		var mi = (second - s) / 60 % 60; // 分钟
		var h = ((second - s) / 60 - mi ) / 60 % 24; // 小时
		return h + "时" + mi + "分" + s + "秒";
	}

	timer=setInterval(function(){
		second --;
		document.getElementById("times").innerHTML = showTime ();
		if(second<=0){
			second=0;
			clearInterval(timer);
			alert("作答时间结束！");
			document.getElementById("paperForm").submit();
		}
	}, 1000); 
	
	$(document).ready(function() {
		$('input').iCheck({
			checkboxClass : 'icheckbox_square',
			radioClass : 'iradio_square',
			increaseArea : '20%' // optional
		});
		$("input:radio").on('ifClicked',function(){
			var opt=$(this).val();$('.ans'+this.name).html(opt);
        });
		$("input:checkbox").on('ifChecked',function(){
			var opt=$(this).val();$("#s"+this.name+opt).append(opt);
        });
        $("input:checkbox").on('ifUnchecked',function(){
			var opt=$(this).val();$("#s"+this.name+opt).empty(opt);
        });
        $("input:text").on('change',function(){
			var opt=$(this).val();$('.ans'+this.name).html(opt);
        });
	});


        
</script>
</head>
<body>


	<c:set var="count" scope="request" value="0"></c:set>
	<div id="content">
		<div id="top">
			<h1>欢迎使用在线考卷</h1>
			<p>
				准考证号：
				<c:out value="${loginBean.ID}" />
			</p>
			<p>
				考生姓名：
				<c:out value="${loginBean.name}" />
			</p>
			<p>
				所在班级：
				<c:out value="${loginBean.CLASS}" />
			</p>
		</div>
		<br>
		<hr>
		<br>
		<div id="paper">
			<form action="${basepath}/CalScoreServlet" method="post" name="paper"
				id="paperForm">

				<c:forEach var="que" items="${sessionScope.ques}" varStatus="status">
					<c:choose>
						<c:when test="${que.q_type eq '单选题'}">
							<c:if test="${count==0}">
								<h3>一、单选题（每道3分,共15分）</h3>
								<c:set value="${count+1}" var="count"></c:set>
							</c:if>

							<div class="que">
								<span id="${que.q_id}">${que.q_id}&nbsp;.&nbsp; </span><span>${que.q_title}</span>
								<c:if test="${not empty  que.q_img }">
									<div class="img">
										<img alt="配图" src="${basepath}/images/${que.q_img}">
									</div>
								</c:if>
								<br> <br>
								<div class="option">
									<label><input type="radio" name="${que.q_id}" value="A" />A.${que.options[0]}</label><br />
									<label><input type="radio" name="${que.q_id}" value="B" />B.${que.options[1]}</label><br />
									<label><input type="radio" name="${que.q_id}" value="C" />C.${que.options[2]}</label><br />
									<label><input type="radio" name="${que.q_id}" value="D" />D.${que.options[3]}</label><br />
								</div>
							</div>
							<hr>
						</c:when>

						<c:when test="${que.q_type eq '多选题'}">
							<c:if test="${count==1}">
								<h3>二、多选题 （每道5分，共20分）</h3>
								<c:set value="${count+1}" var="count"></c:set>
							</c:if>
							<div class="que">
								<span id="${que.q_id}">${que.q_id}&nbsp;.&nbsp;</span> <span>${que.q_title}</span>
								<c:if test="${not empty  que.q_img }">
									<div class="img">
										<img alt="配图" src="${basepath}/images/${que.q_img}">
									</div>
								</c:if>
								<br> <br>
								<div class="option">
									<label><input type="checkbox" name="${que.q_id}"
										value="A" />A.${que.options[0]}</label><br /> <label><input
										type="checkbox" name="${que.q_id}" value="B" />B.${que.options[1]}</label><br />
									<label><input type="checkbox" name="${que.q_id}"
										value="C" />C.${que.options[2]}</label><br /> <label><input
										type="checkbox" name="${que.q_id}" value="D" />D.${que.options[3]}</label><br />
								</div>
							</div>
							<hr>
						</c:when>


						<c:when test="${que.q_type eq '判断题'}">
							<c:if test="${count==2}">
								<h3>三、判断题（每道4分，共20分）</h3>
								<c:set value="${count+1}" var="count"></c:set>
							</c:if>
							<div>
								<span id="${que.q_id}">${que.q_id}&nbsp;.&nbsp; </span><span>${que.q_title}</span>
								<c:if test="${not empty  que.q_img }">
									<div class="img">
										<img alt="配图" src="${basepath}/images/${que.q_img}">
									</div>
								</c:if>
								<br> <br>
								<div class="option">
									<label><input type="radio" name="${que.q_id}" value="对" />对</label>
									<label><input type="radio" name="${que.q_id}" value="错" />错</label>
								</div>
								<br />
							</div>
							<hr>
						</c:when>


						<c:when test="${que.q_type eq '填空题'}">
							<c:if test="${count==3}">
								<h3>四、填空题（每道3分，共15分）</h3>
								<c:set value="${count+1}" var="count"></c:set>
							</c:if>
							<div class="que">
								<span id="${que.q_id}">${que.q_id}&nbsp;.&nbsp;</span><span>${que.q_title}</span>
								<c:if test="${not empty  que.q_img }">
									<div class="img">
										<img alt="配图" src="${basepath}/images/${que.q_img}">
									</div>
								</c:if>
								<br> <br> <input type="text" name="${que.q_id}"
									placeholder="请在此处作答" />
							</div>
							<br>
							<hr>
						</c:when>


						<c:when test="${que.q_type eq '简答题'}">
							<c:if test="${count==4}">
								<h3>五、简答题（每道10分，共30分）</h3>
								<c:set value="${count+1}" var="count"></c:set>
							</c:if>
							<div class="que">
								<span id="${que.q_id}">${que.q_id}&nbsp;.&nbsp; </span><span>${que.q_title}</span>
								<c:if test="${not empty  que.q_img }">
									<div class="img">
										<img alt="配图" src="${basepath}/images/${que.q_img}">
									</div>
								</c:if>

								<br> <br>
								<div class="option">
									<textarea rows="6" cols="50" name="${que.q_id}"></textarea>
								</div>
							</div>
							<hr>
						</c:when>
					</c:choose>
				</c:forEach>
			</form>
			<div id="submit">
				<input type="button" value="提交答卷" id="examEnd"
					onclick="javascript:if(confirm('考试时间尚未结束，确认交卷吗？')){paper.submit()}" />
			</div>
		</div>
	</div>

	<div id="showTime">
		<div class="navs">
			时间剩余：
			<hr>
			<div id="times"></div>
		</div>
	</div>
	<c:set value="0" var="count"></c:set>
	<div id="queNav">
		<div class="navs">题目导航</div>
		<c:forEach var="que" items="${sessionScope.ques}" varStatus="status">

			<c:choose>
				<c:when test="${que.q_type eq '单选题'}">
					<a href="#${que.q_id}"> <c:if test="${count==0}">
							—${que.q_type}—<br>
							<c:set value="${count+1}" var="count"></c:set>
						</c:if>>${que.q_id}. &nbsp;<span class="ans${que.q_id}"></span></a>
				</c:when>
				<c:when test="${que.q_type eq '多选题'}">
					<a href="#${que.q_id}"> <c:if test="${count==1}">
							—${que.q_type}—<br>
							<c:set value="${count+1}" var="count"></c:set>
						</c:if>>${que.q_id}.&nbsp; <span class="ans${que.q_id}"> <span
							id="s${que.q_id}A"></span> <span id="s${que.q_id}B"></span> <span
							id="s${que.q_id}C"></span> <span id="s${que.q_id}D"></span>
					</span></a>
				</c:when>
				<c:when test="${que.q_type eq '判断题'}">
					<a href="#${que.q_id}"><c:if test="${count==2}">
							—${que.q_type}—<br>
							<c:set value="${count+1}" var="count"></c:set>
						</c:if> >${que.q_id}.&nbsp;<span class="ans${que.q_id}"></span></a>
				</c:when>
				<c:when test="${que.q_type eq '填空题'}">
					<a href="#${que.q_id}"> <c:if test="${count==3}">
							—${que.q_type}—<br>
							<c:set value="${count+1}" var="count"></c:set>
						</c:if> >${que.q_id}.&nbsp;<span class="ans${que.q_id}"></span></a>
				</c:when>
				<c:when test="${que.q_type eq '简答题'}">
					<a href="#${que.q_id}"><c:if test="${count==4}">
							—${que.q_type}—<br>
							<c:set value="${count+1}" var="count"></c:set>
						</c:if>>${que.q_id}.&nbsp; <span class="ans${que.q_id}"></span></a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:set value="0" var="count"></c:set>
	</div>
</body>
</html>