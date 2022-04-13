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
    <div class="col-md-4 col-md-offset-2">
        当前为第页，总共页，总记录数为条
    </div>
    <div class="col-md-6">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                <c:if test="${pageInfo.hasPreviousPage}">
                    <li>
                        <a href="${APP_PATH}/emps?pn= ${pageInfo.pageNum -1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                    <c:if test="${page_Num == pageInfo.pageNum}">
                        <li class="active"><a href="#">${page_Num}</a></li>
                    </c:if>
                    <c:if test="${page_Num!=pageInfo.pageNum}">
                        <li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a> </li>
                    </c:if>
                </c:forEach>
                <c:if test="${pageInfo.hasNextPage}">
                    <li>
                        <a href="${APP_PATH}/emps?pn= ${pageInfo.pageNum + 1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
                <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">尾页</a></li>
            </ul>
        </nav>
    </div>
</div>
<script type="text/javascript">
    //页面加载完成之后，直接发送ajax请求
    $(function () {
        to_page();
    })
    //发起请求，得到请求数据
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+1,
            type:"GET",
            dataType:"json",
            success:function (result) {
                build_emps_table(result)
            }
        })
    }
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
</script>

</body>
</html>
