<%@page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="col-md-3">
    <div class="panel-group" id="accordion">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a href="/messageType/list">
                        留言
                    </a>
                </h4>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a data-toggle="collapse" data-parent="#accordion"
                       href="#collapseThree">
                        活动<b class="caret"></b>
                    </a>
                </h4>
            </div>
            <div id="collapseThree" class="panel-collapse collapse">
                <ul class="list-group">
                    <li class="list-group-item"><a href="/vote/topic/2/page/1">活动</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>