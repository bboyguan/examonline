# GZHMT_JSP课设项目——在线考试系统
本项目内容JSP课程期末课设，将保持持续更新；

如果觉得对您有用，欢迎点击Star按钮，感谢支持；

任何建议欢迎邮件联系。

- 邮箱：18302087427@163.com
- Github：https://github.com/acrx016


## 目录
* [GZHMT_JSP课设项目——在线考试系统](#GZHMT_JSP课设项目——在线考试系统)
  * [项目介绍](#项目介绍)
    * [系统功能](#系统功能)
    * [技术栈](#技术栈)
    * [相关工具组件](#相关工具组件)
  * [启动](#启动)
  * [业务流程](#业务流程)
  * [项目运行图](#项目运行图)

## 项目介绍
本系统设计综合应用所学知识开发一个基于MVC模式的考试系统

### 系统功能
![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/17/%E7%B3%BB%E7%BB%9F%E5%8A%9F%E8%83%BD%E7%BB%93%E6%9E%84%E5%9B%BE-1576513902384.png)

### 技术栈
java 8 + jsp + mysql + tomcat + javascript + css

### 相关工具组件
- 项目开发语言：java 8；
- Excel工具包：[apache-poi 4.1.0](https://poi.apache.org/)；
- JSP标准标签库：jstl；
- 本地服务器：tomcat9.0；
- 数据库：mysql8；


## 启动
1. 从git克隆项目导入到编译器
```
git clone https://github.com/acrx016/examOnline.git
```
2. 导入数据库文件到MySQL
```
examination.sql
连接账号：root；密码：root
数据库连接账号访问可以在examOnline\src\examdao\model\DatabassAccessObject.java中修改
```
3. 部署到tomcat既可运行启动,本地访问路径:
```
http://localhost:8080/examOnline/login.jsp
```

## 业务流程
1. 学生端业务流程

![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/17/%E5%AD%A6%E7%94%9F%E7%AB%AF%E4%B8%9A%E5%8A%A1%E6%B5%81%E7%A8%8B-1576514414379.png)

2. 教师端业务流程

![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/17/%E6%95%99%E5%B8%88%E7%AB%AF%E4%B8%9A%E5%8A%A1%E6%B5%81%E7%A8%8B-1576514471660.png)

3. 抽题组卷流程

![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/20/%E6%8A%BD%E9%A2%98%E6%B5%81%E7%A8%8B-1576808363172.png)

## 项目运行图
1. 登录

![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/17/%E7%99%BB%E5%BD%95-1576514775059.png)

2. 信息展示

![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/20/%E4%BF%A1%E6%81%AF%E5%B1%95%E7%A4%BA-1576808294900.png)

3. 试卷展示

![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/20/%E8%AF%95%E5%8D%B7-1576808341940.png)

4. 管理模块

![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/20/%E7%AE%A1%E7%90%86%E6%A8%A1%E5%9D%97-1576808483232.png)
![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/20/%E9%A2%98%E7%9B%AE%E6%9F%A5%E8%AF%A2%E6%A8%A1%E5%9D%97-1576808521297.png)
![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/20/%E4%BF%AE%E6%94%B9%E6%A8%A1%E5%9D%97-1576808563413.png)
![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/20/%E8%AF%95%E5%8D%B7%E8%AE%BE%E7%BD%AE-1576808505300.png)

5. Excel导入导出模块

![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/20/%E8%A1%A8%E5%8D%95%E4%B8%8B%E8%BD%BD-1576808592965.png)
![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/20/%E8%A1%A8%E5%8D%95%E5%AF%BC%E5%87%BA-1576808605738.png)

6. 学生端功能

![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/20/%E5%AD%A6%E7%94%9F%E4%BF%A1%E6%81%AF-1576808933627.png)

7. 学生成绩详情

![title](https://raw.githubusercontent.com/acrx016/myImage/master/JavaEE%20SSM%20Design/2019/12/20/1576809427971-1576809427974.png)
