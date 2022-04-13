<%--
  Created by IntelliJ IDEA.
  User: Mr.Zhang
  Date: 2022/4/11
  Time: 20:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>员工列表</title>
    <% pageContext.setAttribute("APP_PATH",request.getContextPath()); %>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--第一行信息--%>
<div class="row">
    <div class="col-md-6 col-md-offset-1">
        <h1>SSM-Combine</h1>
    </div>
</div>
<%--第二行信息--%>
<div class="row">
    <div class="col-md-4 col-md-offset-8">
        <button class="btn btn-success">
            <span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>  增加
        </button>
        <button class="btn btn-danger">
            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>  删除
        </button>
    </div>
</div>
<%--第三行信息--%>
<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <table class="table table-hover" id="emps_table">
            <thead>
            <tr>
                <th>EmpID</th>
                <th>EmpName</th>
                <th>Gender</th>
                <th>Email</th>
                <th>DeptName</th>
                <th>Operation</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</div>
<%--第四行信息--%>
<div class="row">
<%--    展示当前页码，页码总数，总数据量--%>
    <div class="col-md-4 col-md-offset-2" id="pageShow"></div>
<%--    显示分页导航栏--%>
    <div class="col-md-6" id="navigate"></div>
</div>
<script type="text/javascript">
    //页面加载完成之后，直接发送ajax请求
    $(function () {
        to_page(1);
    })
    //发起请求，得到请求数据，将要跳转的页码赋值给pn
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            dataType:"json",
            success:function (result) {
                console.log(result.extend)
                //显示查询到的浏览器条数
                build_emps_table(result);
                //显示搜索的总体信息
                build_page_show(result);
                //页面导航栏
                build_page_navigate(result);
            }
        })
    }
    //员工数据显示
    function build_emps_table(result) {
        //清空表格
        $("#emps_table tbody").empty();
        var emps=result.extend.pageInfo.list;
        //对查到的数据进行列表显示
        $.each(emps,function (index,item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptName = $("<td></td>").append(item.dept.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("修改");
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            var BtnTb = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptName)
                .append(BtnTb)
                .appendTo("#emps_table tbody");
        })
    }
    //页码条数显示
    function build_page_show(result) {
        $("#pageShow").empty();
        var pageInfo = result.extend.pageInfo;
        $("#pageShow").append("当前页码为第"+pageInfo.pageNum+"页,共有"
            +pageInfo.pages+"页,共有"
            +pageInfo.total+"条数据")
    }
    //页码导航栏显示
    function build_page_navigate(result) {
        $("#navigate").empty();
        var pageInfo = result.extend.pageInfo;
        var ul = $("<ul></ul>").addClass("pagination");
        var firstLi = $("<li></li>").append($("<a></a>").append("首页"))
        var upLi = $("<li></li>").append($("<a></a>").append("&laquo;"))
        if (pageInfo.hasPreviousPage == false){
            firstLi.addClass("disabled");
            upLi.addClass("disabled");
        }else{
            firstLi.click(function () {
                to_page(1);
            })
            upLi.click(function () {
                to_page(pageInfo.pageNum-1)
            })
        }
        ul.append(firstLi).append(upLi);
        $.each(pageInfo.navigatepageNums,function (index,item) {
            var page = $("<li></li>").append($("<a></a>").append(item))
            if (pageInfo.pageNum == item){
                    page.addClass("active");
            }else {
                page.click(function () {
                    to_page(item);
                })
            }
            ul.append(page);
        })
        var nextLi = $("<li></li>").append($("<a></a>").append("&raquo;"))
        var lastLi = $("<li></li>").append($("<a></a>").append("尾页"))
        if (pageInfo.hasNextPage == false){
            nextLi.addClass("disabled");
            lastLi.addClass("disabled");
        }else{
            nextLi.click(function () {
                to_page(pageInfo.pageNum+1);
            })
            lastLi.click(function () {
                to_page(pageInfo.pages)
            })
        }
        var nav=ul.append(nextLi).append(lastLi).appendTo($("<nav></nav>"));
        $("#navigate").append(nav);
    }
</script>

</body>
</html>
