
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
            $("#adminUserInformationUpdateForm").validationEngine('attach');
        });
    </script>
    <div class="container-fluid" id="database">
        <div class="row">
        </div>
        <div class="row">
            <jsp:include page="../left.jsp"/>
            <div class="col-md-9">
                <form id="adminUserInformationUpdateForm" action="/admin/user/updateInformation"
                      method="post">
                    <div class="form-group">
                        <label for="update.floorAdminEntity.name">姓名</label>
                        <input type="text" class="form-control" name="name" id="update.floorAdminEntity.name"
                               placeholder="${floorAdminEntity.name}" value="${floorAdminEntity.name}" />
                    </div>
                    <div class="form-group">
                        <label for="update.floorAdminEntity.employeeId">工号</label>
                        <input type="text" class="form-control" name="employeeId" id="update.floorAdminEntity.employeeId"
                               placeholder="${floorAdminEntity.employeeId}" value="${floorAdminEntity.employeeId}" readonly = "readonly"/>
                    </div>
                    <div class="form-group">
                        <label for="update.floorAdminEntity.password">密码</label>
                        <input type="password" class="form-control" name="password" id="update.floorAdminEntity.password"
                               placeholder="密码"/>
                    </div>
                    <div class="form-group">
                        <label for="update.floorAdminEntity.phoneNumber">电话</label>
                        <input type="text" class="form-control validate[custom[phone]]" name="phoneNumber" id="update.floorAdminEntity.phoneNumber"
                               placeholder="${floorAdminEntity.phoneNumber}" value="${floorAdminEntity.phoneNumber}"/>
                    </div>
                    <div class="form-group">
                        <label for="update.floorAdminEntity.email">电子邮件</label>
                        <input type="email" class="form-control validate[custom[email]]" name="email" id="update.floorAdminEntity.email"
                               placeholder="${floorAdminEntity.email}" value="${floorAdminEntity.email}"/>
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