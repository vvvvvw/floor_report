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
            $("#userInformationUpdateForm").validationEngine('attach');
        });
    </script>
    <div class="container-fluid" id="database">
        <div class="row">
        </div>
        <div class="row">
            <div class="col-md-12">
                <form id="userInformationUpdateForm" action="/user/updateInformation"
                      method="post">
                    <div class="form-group">
                        <label for="update.floorEmployeeEntity.name">姓名</label>
                        <input type="text" class="form-control" name="name" id="update.floorEmployeeEntity.name"
                               placeholder="${floorEmployeeEntity.name}" value="${floorEmployeeEntity.name}" />
                    </div>
                    <div class="form-group">
                        <label for="update.floorEmployeeEntity.employeeId">工号</label>
                        <input type="text" class="form-control" name="employeeId" id="update.floorEmployeeEntity.employeeId"
                               placeholder="${floorEmployeeEntity.employeeId}" value="${floorEmployeeEntity.employeeId}" readonly = "readonly"/>
                    </div>
                    <div class="form-group">
                        <label for="update.floorEmployeeEntity.password">密码</label>
                        <input type="password" class="form-control" name="password" id="update.floorEmployeeEntity.password"
                               placeholder=""/>
                    </div>
                    <div class="form-group">
                        <label for="update.floorEmployeeEntity.phoneNumber">电话</label>
                        <input type="text" class="form-control validate[custom[phone]]" name="phoneNumber" id="update.floorEmployeeEntity.phoneNumber"
                               placeholder="${floorEmployeeEntity.phoneNumber}" value="${floorEmployeeEntity.phoneNumber}"/>
                    </div>
                    <div class="form-group">
                        <label for="update.floorEmployeeEntity.email">电子邮件</label>
                        <input type="email" class="form-control validate[custom[email]]" name="email" id="update.floorEmployeeEntity.email"
                               placeholder="${floorEmployeeEntity.email}" value="${floorEmployeeEntity.email}"/>
                    </div>
                    <button type="submit" class="btn btn-default center-block">更新</button>
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