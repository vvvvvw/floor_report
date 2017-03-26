<%@ page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    request.setAttribute("sdf", sdf); //request域
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="container">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#employeeUpdateForm").validationEngine('attach');
            $("#employeeAddForm").validationEngine('attach');

        });
    </script>
    <div class="container-fluid" id="database">
        <div class="row">
            <jsp:include page="../left.jsp"/>
            <div class="col-md-9">
                <c:choose>
                <c:when test="${null ne floorEmployeeEntityList and 0 ne floorEmployeeEntityList.size()}">
                <div class="row">
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>
                                    序号
                                </th>
                                <th>
                                    姓名
                                </th>
                                <th>
                                    工号
                                </th>
                                <th>
                                    电话
                                </th>
                                <th>
                                    email地址
                                </th>
                                <th>
                                    操作
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${floorEmployeeEntityList}" varStatus="status" begin="0">
                                <tr>
                                    <td>
                                            ${status.index+1}
                                    </td>
                                    <td id="employeeDetailName${item.employeeId}">
                                            ${item.name}
                                    </td>
                                    <td id="employeeDetailEmployeeId${item.employeeId}">
                                            ${item.employeeId}
                                    </td>
                                    <td id="employeeDetailPhoneNumber${item.employeeId}">
                                            ${item.phoneNumber}
                                    </td>
                                    <td id="employeeDetailEmail${item.employeeId}">
                                            ${item.email}
                                    </td>
                                    <td>
                                        <div class="dropdown">
                                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu${item.employeeId}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                操作
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu${item.employeeId}">
                                                <li><a href="javascript:top.location='/admin/employee/delete/${item.employeeId}'">
                                                    <em class="glyphicon glyphicon-remove"></em>
                                                    删除</a></li>
                                                <li><a data-toggle="modal" data-target="#employeeUpdateModal" onclick="updateEmployee(${item.employeeId})">
                                                    <em class="glyphicon glyphicon-list-alt"></em>
                                                    修改</a></li>
                                                <li><a href="javascript:top.location='/admin/employee/resetPassword/${item.employeeId}'">
                                                    <em class="glyphicon glyphicon-backward"></em>
                                                    重置密码</a></li>
                                            </ul>
                                        </div>
                                        <%--<div class="btn-group">
                                            <button class="btn btn-default" type="button" onclick="javascript:top.location='/admin/employee/delete/${item.employeeId}'">
                                                <em class="glyphicon glyphicon-remove"></em>
                                                删除
                                            </button>
                                            <button data-toggle="modal" data-target="#employeeUpdateModal" onclick="updateEmployee(${item.employeeId})">
                                                <em class="glyphicon glyphicon-list-alt"></em>
                                                修改
                                            </button>
                                            <button class="btn btn-default" type="button" onclick="javascript:top.location='/admin/employee/resetPassword/${item.employeeId}'">
                                                <em class="glyphicon glyphicon-backward"></em>
                                                重置密码
                                            </button>
                                        </div>--%>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    </div>
                    </c:when>
                    <c:otherwise>
                        没有数据
                    </c:otherwise>
                    </c:choose>
                    <div style="text-align:center">
                        <div id="page"></div>
                        <div class="btn-group">
                            <button class="btn btn-default"  data-toggle="modal" data-target="#employeeAddModal"  type="button">
                                <em class="glyphicon glyphicon-plus" aria-hidden="true"></em>
                                添加
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    //好像很实用的样子，后端的同学再也不用写分页逻辑了。
    laypage({
        cont: "page",
        pages: ${admin_employee_pages}, //可以叫服务端把总页数放在某一个隐藏域，再获取。假设我们获取到的是18
        curr: ${admin_employee_currentPage},
        jump: function (e, first) { //触发分页后的回调
            if (!first) { //一定要加此判断，否则初始时会无限刷新
                location.href = '/admin/employee/list/' + e.curr;
            }
        },
        skin: 'molv', //皮肤
        first: 1, //将首页显示为数字1,。若不显示，设置false即可
        last: ${admin_employee_pages}, //将尾页显示为总页数。若不显示，设置false即可
        prev: '<', //若不显示，设置false即可
        next: '>' //若不显示，设置false即可
    });
</script>

<!-- 更新模体框 -->
<div class="modal fade" id="employeeUpdateModal" tabindex="-1" role="dialog"
     aria-labelledby="employeeUpdate" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="employeeUpdate">
                    修改
                </h4>
            </div>
            <div class="modal-body">
                <form id="employeeUpdateForm" action="/admin/employee/update"
                      method="post">
                    <div class="form-group">
                        <label for="update_name">姓名</label>
                        <input type="text" class="form-control validate[required]" name="name" id="update_name"
                               placeholder="姓名"/>
                    </div>
                    <div class="form-group">
                        <label for="update_employeeId">工号</label>
                        <input type="text" class="form-control" name="employeeId" id="update_employeeId"
                               placeholder="工号" readonly = "readonly"/>
                    </div>
                    <div class="form-group">
                        <label for="update_phoneNumber">电话</label>
                        <input type="text" class="form-control  validate[custom[phone]" name="phoneNumber" id="update_phoneNumber"
                               placeholder="电话" value="123"/>
                    </div>
                    <div class="form-group">
                        <label for="update_email">电子邮件</label>
                        <input type="email" class="form-control  validate[custom[email]" name="email" id="update_email"
                               placeholder="电子邮件"/>
                    </div>
                    <div style="text-align:center">
                    <button type="submit" class="btn btn-default">提交</button>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    function updateEmployee(employeeId) {
        var employeeDetailName = "#employeeDetailName" + employeeId;
        var content = $(employeeDetailName).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = '';
        }
        $("#update_name").val(content.trim());
        var employeeDetailEmployeeId = "#employeeDetailEmployeeId" + employeeId;
        var content = $(employeeDetailEmployeeId).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = '';
        }
        $("#update_employeeId").val(content.trim());
        var employeeDetailPhoneNumber = "#employeeDetailPhoneNumber" + employeeId;
        content = $(employeeDetailPhoneNumber).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = '';
        }
        $("#update_phoneNumber").val(content.trim());
        var employeeDetailEmail = "#employeeDetailEmail" + employeeId;
        content = $(employeeDetailEmail).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = '';
        }
        $("#update_email").val(content.trim());
    }
</script>
<!-- 添加模体框 -->
<div class="modal fade" id="employeeAddModal" tabindex="-1" role="dialog"
     aria-labelledby="employeeAdd" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="employeeAdd">
                    添加
                </h4>
            </div>
            <div class="modal-body">
                <form id="employeeAddForm" action="/admin/employee/add"
                      method="post">
                    <div class="form-group">
                        <label for="add.name">姓名</label>
                        <input type="text" class="form-control validate[required]" name="name" id="add.name"
                               placeholder="姓名"/>
                    </div>
                    <div class="form-group">
                        <label for="add.employeeId">工号</label>
                        <input type="text" class="form-control  validate[required,custom[integer]]" name="employeeId" id="add.employeeId"
                               placeholder="工号"/>
                    </div>
                    <div class="form-group">
                        <label for="update_phoneNumber">电话</label>
                        <input type="text" class="form-control  validate[custom[phone]" name="phoneNumber" id="add.phoneNumber"
                               placeholder="电话"/>
                    </div>
                    <div class="form-group">
                        <label for="add.email">电子邮件</label>
                        <input type="email" class="form-control  validate[custom[email]" name="email" id="add.email"
                               placeholder="电子邮件"/>
                    </div>
                    <button type="submit" class="btn btn-default">提交</button>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    <c:if test="${null ne msg}">
    layer.alert("${msg}", {icon: 0});
    </c:if>
</script>