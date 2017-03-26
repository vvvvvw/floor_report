<%@page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row">
    <div class="col-md-12">
        <nav class="navbar navbar-default" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span
                        class="icon-bar"></span><span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">报备系统-管理后台</a>
            </div>
            <c:choose>
                <c:when test="${null ne sessionScope.adminUser}">
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">${sessionScope.adminUser.name}<strong
                                        class="caret"></strong></a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a href="/admin/login/logout">登出</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </c:when>
            </c:choose>
        </nav>
    </div>
</div>
