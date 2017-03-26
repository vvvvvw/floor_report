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
            $("#projectUpdateForm").validationEngine('attach');
            $("#projectAddForm").validationEngine('attach');
        });
        Date.prototype.Format = function (fmt) { //author: meizz
            var o = {
                "M+": this.getMonth() + 1, //月份
                "d+": this.getDate(), //日
                "HH+": this.getHours(), //小时
                "m+": this.getMinutes(), //分
                "s+": this.getSeconds(), //秒
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度
                "S": this.getMilliseconds() //毫秒
            };
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        }
    </script>
    <div class="container-fluid" id="database">
        <div class="row">
        </div>
        <div class="row">
            <div class="col-md-12">
                <c:choose>
                <c:when test="${null ne projectBeanList and 0 ne projectBeanList.size()}">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>
                                    序号
                                </th>
                                <th>
                                    客户名字
                                </th>
                                <th>
                                    客户地址
                                </th>
                                <th>
                                    客户电话
                                </th>
                                <th>
                                    客户email
                                </th>
                                <th>
                                    项目详情
                                </th>
                                <th>
                                    设计师详情
                                </th>
                                <th>
                                    最近访问时间
                                </th>
                                <th>
                                    创建时间
                                </th>
                                <th>
                                    操作
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${projectBeanList}" varStatus="status">
                                <tr>
                                    <td>
                                            ${status.index+project_startnum}
                                    </td>
                                    <td id="clientDetailName${item.floorProjectEntity.id}">
                                            ${item.floorClientEntity.name}
                                    </td>
                                    <td id="clientDetailAddress${item.floorProjectEntity.id}">
                                            ${item.floorClientEntity.address}
                                    </td>
                                    <td id="clientDetailPhoneNumber${item.floorProjectEntity.id}">
                                            ${item.floorClientEntity.phoneNumber}
                                    </td>
                                    <td id="clientDetailEmail${item.floorProjectEntity.id}">
                                            ${item.floorClientEntity.email}
                                    </td>
                                    <td>
                                        <a data-toggle="modal" data-target="#projectDetailModal" id="projectDetailButton"
                                           onclick="showProjectDetail(${item.floorProjectEntity.id})">查看</a>
                                        <p class="hidden" id="projectDetailIsFloorHeating${item.floorProjectEntity.id}">
                                                ${item.floorProjectEntity.floorHeating}
                                        </p>
                                        <p class="hidden" id="projectDetailProgress${item.floorProjectEntity.id}">
                                                ${item.floorProjectEntity.progress}
                                        </p>
                                        <p class="hidden" id="projectDetailFloorType${item.floorProjectEntity.id}">
                                                ${item.floorProjectEntity.floorType}
                                        </p>
                                        <p class="hidden"
                                           id="projectDetailCommunicationProgress${item.floorProjectEntity.id}">
                                                ${item.floorProjectEntity.communicationProgress}
                                        </p>
                                    </td>
                                    <td>
                                        <a data-toggle="modal" data-target="#designerDetailModal" id="designerDetailButton"
                                           onclick="showDesignerDetail(${item.floorProjectEntity.id})">查看</a>
                                        <p class="hidden" id="designerDetailName${item.floorProjectEntity.id}">
                                                ${item.floorDesignerEntity.name}
                                        </p>
                                        <p class="hidden" id="designerDetailPhoneNumber${item.floorProjectEntity.id}">
                                                ${item.floorDesignerEntity.phoneNumber}
                                        </p>
                                        <p class="hidden" id="designerDetailEmail${item.floorProjectEntity.id}">
                                                ${item.floorDesignerEntity.email}
                                        </p>
                                    </td>
                                    <td class="time" id="projectDetailVisitTime${item.floorProjectEntity.id}">
                                        <c:if test="${null ne item.floorProjectEntity.visitTime}">
                                        <c:out value="${sdf.format(item.floorProjectEntity.visitTime*1000)}"/>
                                        </c:if>
                                    </td>
                                    <td class="time">
                                        <c:out value="${sdf.format(item.floorProjectEntity.createTime*1000)}"/>
                                    </td>
                                    <td>
                                        <div class="dropdown">
                                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu${item.floorProjectEntity.id}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                操作
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu${item.floorProjectEntity.id}">
                                                <li><a href="javascript:top.location='/project/delete/${item.floorProjectEntity.id}'">
                                                    <em class="glyphicon glyphicon-remove"></em>
                                                    删除</a></li>
                                                <li><a  data-toggle="modal" data-target="#projectUpdateModal" onclick="updateProject(${item.floorProjectEntity.id})">
                                                    <em class="glyphicon glyphicon-list-alt"></em>
                                                    修改</a></li>
                                            </ul>
                                        </div>
                                       <%-- <div class="btn-group">
                                            <button class="btn btn-default" type="button" onclick="javascript:top.location='/project/delete/${item.floorProjectEntity.id}'">
                                                <em class="glyphicon glyphicon-remove"></em>
                                                删除
                                            </button>
                                            <button data-toggle="modal" data-target="#projectUpdateModal" onclick="updateProject(${item.floorProjectEntity.id})">
                                                <em class="glyphicon glyphicon-list-alt"></em>
                                                修改
                                            </button>
                                        </div>--%>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        没有数据
                    </c:otherwise>
                    </c:choose>
                <div style="text-align:center">
                    <div id="page">
                    </div>
                    <div class="btn-group">
                        <button class="btn btn-default"  data-toggle="modal" data-target="#projectAddModal"  type="button">
                            <em class="glyphicon glyphicon-plus" aria-hidden="true"></em>
                            添加
                        </button>
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
        pages: ${project_pages}, //可以叫服务端把总页数放在某一个隐藏域，再获取。假设我们获取到的是18
        curr: ${project_currentPage},
        jump: function (e, first) { //触发分页后的回调
            if (!first) { //一定要加此判断，否则初始时会无限刷新
                location.href = '/project/list/' + e.curr;
            }
        },
        skin: 'molv', //皮肤
        first: 1, //将首页显示为数字1,。若不显示，设置false即可
        last: ${project_pages}, //将尾页显示为总页数。若不显示，设置false即可
        prev: '<', //若不显示，设置false即可
        next: '>' //若不显示，设置false即可
    });
</script>

    <!-- 项目详情模体框 -->
    <div class="modal fade" id="projectDetailModal" tabindex="-1" role="dialog"
         aria-labelledby="projectDetail" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="projectDetail">
                        项目详情
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="row clearfix">
                        <div class="col-md-12 column">
                            <dl>
                                <dt>
                                    是否地暖
                                </dt>
                                <dd id="projectDetailIsFloorHeatingInModal">
                                    否
                                </dd>
                                <dt>
                                    施工进度
                                </dt>
                                <dd id="projectDetailProgressInModal">
                                    无
                                </dd>
                                <dt>
                                    地板类型
                                </dt>
                                <dd id="projectDetailFloorTypeInModal">
                                    无
                                </dd>
                                <dt>
                                    沟通情况
                                </dt>
                                <dd id="projectDetailCommunicationProgressInModal">
                                    无
                                </dd>
                            </dl>
                        </div>
                    </div>

                    <button type="button" class="btn btn-default center-block"
                            data-dismiss="modal">关闭
                    </button>
                </div>
            </div>
        </div>
    </div>
<script>
    function showProjectDetail(projectId) {
        var projectDetailIsFloorHeating = "#projectDetailIsFloorHeating" + projectId;
        var content = $(projectDetailIsFloorHeating).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "无";
        }
        content = content.trim();
        if('1'==content){
            content = "是";
        }else if('0'==content){
            content = "否";
        }
        $("#projectDetailIsFloorHeatingInModal").text(content);
        var projectDetailProgress = "#projectDetailProgress" + projectId;
        content = $(projectDetailProgress).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "无";
        }
        $("#projectDetailProgressInModal").text(content.trim());
        var projectDetailFloorType = "#projectDetailFloorType" + projectId;
        content = $(projectDetailFloorType).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "无";
        }
        $("#projectDetailFloorTypeInModal").text(content.trim());
        var projectDetailCommunicationProgress = "#projectDetailCommunicationProgress" + projectId;
        content = $(projectDetailCommunicationProgress).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "无";
        }
        $("#projectDetailCommunicationProgressInModal").text(content.trim());
    }
</script>
<!-- 设计师详情模体框 -->
<div class="modal fade" id="designerDetailModal" tabindex="-1" role="dialog"
     aria-labelledby="designerDetail" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="designerDetail">
                    设计师详情
                </h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <dl>
                            <dt>
                                姓名
                            </dt>
                            <dd id="designerDetailNameModal">
                                无
                            </dd>
                            <dt>
                                电话
                            </dt>
                            <dd id="designerDetailPhoneNumberModal">
                                无
                            </dd>
                            <dt>
                                电子邮件
                            </dt>
                            <dd id="designerDetailEmailModal">
                                无
                            </dd>
                        </dl>
                    </div>
                </div>

                <button type="button" class="btn btn-default center-block"
                        data-dismiss="modal">关闭
                </button>
            </div>
        </div>
    </div>
</div>
<script>
    function showDesignerDetail(projectId) {
        var designerDetailName = "#designerDetailName" + projectId;
        var content = $(designerDetailName).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "无";
        }
        $("#designerDetailNameModal").text(content.trim());
        var designerDetailPhoneNumber = "#designerDetailPhoneNumber" + projectId;
        content = $(designerDetailPhoneNumber).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "无";
        }
        $("#designerDetailPhoneNumberModal").text(content.trim());
        var designerDetailEmail = "#designerDetailEmail" + projectId;
        content = $(designerDetailEmail).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "无";
        }
        $("#designerDetailEmailModal").text(content.trim());
        }
</script>
<!-- 更新模体框 -->
<div class="modal fade" id="projectUpdateModal" tabindex="-1" role="dialog"
     aria-labelledby="projectUpdate" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="projectUpdate">
                    修改
                </h4>
            </div>
            <div class="modal-body">
                <form id="projectUpdateForm" action="/project/update"
                      method="post">
                    <input type="hidden" name="floorProjectEntity.id" id="update_floorProjectEntity_id"/>
                    <div class="form-group">
                        <label for="update_floorClientEntity_name">客户姓名</label>
                        <input type="text" class="form-control" name="floorClientEntity.name" id="update_floorClientEntity_name"
                               placeholder="客户姓名"/>
                    </div>
                    <div class="form-group">
                        <label for="update_floorClientEntity_address">客户地址</label>
                        <input type="text" class="form-control validate[required]" name="floorClientEntity.address" id="update_floorClientEntity_address"
                                  placeholder="客户地址"/>
                    </div>
                    <div class="form-group">
                        <label for="update_floorClientEntity_phoneNumber">客户电话</label>
                        <input type="text" class="form-control validate[custom[phone]]" name="floorClientEntity.phoneNumber" id="update_floorClientEntity_phoneNumber"
                               placeholder="客户电话"/>
                    </div>
                    <div class="form-group">
                        <label for="update_floorClientEntity_email">客户电子邮件</label>
                        <input type="email" class="form-control validate[custom[email]]" name="floorClientEntity.email" id="update_floorClientEntity_email"
                               placeholder="客户电子邮件"/>
                    </div>
                    <div role="separator" class="divider"></div>
                    <div class="form-group">
                        是否地暖
                        <label class="radio-inline">
                            <input type="radio" name="floorProjectEntity.floorHeating" id="update_floorProjectEntity_floorHeating1" value="1"> 是
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="floorProjectEntity.floorHeating" id="update_floorProjectEntity_floorHeating0" value="0"> 否
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="update_floorProjectEntity_progress">施工进度</label>
                        <input type="text" class="form-control" name="floorProjectEntity.progress" id="update_floorProjectEntity_progress"
                               placeholder="施工进度"/>
                    </div>
                    <div class="form-group">
                        <label for="update_floorProjectEntity_floorType">地板类型</label>
                        <input type="text" class="form-control" name="floorProjectEntity.floorType" id="update_floorProjectEntity_floorType"
                               placeholder="地板类型"/>
                    </div>
                    <div class="form-group">
                        <label for="update_floorProjectEntity_communicationProgress">沟通情况</label>
                        <input type="text" class="form-control" name="floorProjectEntity.communicationProgress" id="update_floorProjectEntity_communicationProgress"
                               placeholder="沟通情况"/>
                    </div>
                    <div class="form-group">
                        <label for="update_floorProjectEntity_visitTime">访问时间</label>
                        <input type="text" class="form-control form_datetime" name="floorProjectEntity.visitTime" id="update_floorProjectEntity_visitTime"/>
                    </div>
                    <div role="separator" class="divider"></div>
                    <div class="form-group">
                        <label for="update_floorDesignerEntity_name">设计师姓名</label>
                        <input type="text" class="form-control" name="floorDesignerEntity.name" id="update_floorDesignerEntity_name"
                               placeholder="设计师姓名"/>
                    </div>
                    <div class="form-group">
                        <label for="update_floorDesignerEntity_phoneNumber">设计师电话</label>
                        <input type="text" class="form-control validate[custom[phone]]" name="floorDesignerEntity.phoneNumber" id="update_floorDesignerEntity_phoneNumber"
                               placeholder="设计师电话"/>
                    </div>
                    <div class="form-group">
                        <label for="update_floorDesignerEntity_email">设计师电子邮件</label>
                        <input type="email" class="form-control validate[custom[email]]" name="floorDesignerEntity.email" id="update_floorDesignerEntity_email"
                               placeholder="设计师电子邮件"/>
                    </div>
                        <div style="text-align:center">
                    <button type="submit" class="btn btn-default" id = "update_submit" onclick="updateAndSubmit()">提交</button>
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
    function updateProject(projectId) {
        $("#update_floorProjectEntity_id").val(projectId);
        var clientDetailName = "#clientDetailName" + projectId;
        var content = $(clientDetailName).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "";
        }
        $("#update_floorClientEntity_name").val(content.trim());
        var clientDetailAddress = "#clientDetailAddress" + projectId;
        content = $(clientDetailAddress).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "";
        }
        $("#update_floorClientEntity_address").val(content.trim());
        var clientDetailPhoneNumber = "#clientDetailPhoneNumber" + projectId;
        content = $(clientDetailPhoneNumber).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "";
        }
        $("#update_floorClientEntity_phoneNumber").val(content.trim());
        var clientDetailEmail = "#clientDetailEmail" + projectId;
        content = $(clientDetailEmail).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "";
        }
        $("#update_floorClientEntity_email").val(content.trim());
        var projectDetailIsFloorHeating = "#projectDetailIsFloorHeating" + projectId;
        content = $(projectDetailIsFloorHeating).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = 0;
        }
        content = content.trim();
        if(content == '1'){
            content = 1;
        }else if(content == '0'){
            content = 0;
        }
        var selected = content;
        var unselected = 1 - content;
        $('#update_floorProjectEntity_floorHeating'+selected).attr("checked",true);
        $('#update_floorProjectEntity_floorHeating'+unselected).attr("checked",false);
        var projectDetailProgress = "#projectDetailProgress" + projectId;
        content = $(projectDetailProgress).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "";
        }
        $("#update_floorProjectEntity_progress").val(content.trim());
        var projectDetailFloorType = "#projectDetailFloorType" + projectId;
        content = $(projectDetailFloorType).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "";
        }
        $("#update_floorProjectEntity_floorType").val(content.trim());
        var projectDetailCommunicationProgress = "#projectDetailCommunicationProgress" + projectId;
        content = $(projectDetailCommunicationProgress).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "";
        }
        $("#update_floorProjectEntity_communicationProgress").val(content.trim());
        var projectVisitTime = "#projectDetailVisitTime" + projectId;
        content = $(projectVisitTime).text();
        if (content == null || content == undefined || content.trim() == '') {
            var content = "";
        }
        $("#update_floorProjectEntity_visitTime").val(content.trim());
        var designerDetailName = "#designerDetailName" + projectId;
        content = $(designerDetailName).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "";
        }
        $("#update_floorDesignerEntity_name").val(content.trim());
        var designerDetailPhoneNumber = "#designerDetailPhoneNumber" + projectId;
        content = $(designerDetailPhoneNumber).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "";
        }
        $("#update_floorDesignerEntity_phoneNumber").val(content.trim());
        var designerDetailEmail = "#designerDetailEmail" + projectId;
        content = $(designerDetailEmail).text();
        if (content == null || content == undefined || content.trim() == '') {
            content = "";
        }
        $("#update_floorDesignerEntity_email").val(content.trim());
    }
    function updateAndSubmit() {
        var time = $("#update_floorProjectEntity_visitTime").val().trim();
        if (time != null && time != undefined && time != '') {
            var unixTimestamp = Date.parse(new Date(time))/1000;
            $("#update_floorProjectEntity_visitTime").val(unixTimestamp);
        }
        $("#projectUpdateForm").submit();
    }
</script>
<!-- 添加模体框 -->
<div class="modal fade" id="projectAddModal" tabindex="-1" role="dialog"
     aria-labelledby="projectAdd" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="projectAdd">
                    新增
                </h4>
            </div>
            <div class="modal-body">
                <form id="projectAddForm" action="/project/add"
                      method="post">
                    <div class="form-group">
                        <label for="add_floorClientEntity_name">客户姓名</label>
                        <input type="text" class="form-control" name="floorClientEntity.name" id="add_floorClientEntity_name"
                               placeholder="客户姓名"/>
                    </div>
                    <div class="form-group">
                        <label for="add_floorClientEntity_address">客户地址</label>
                        <input type="text" class="form-control validate[required]" name="floorClientEntity.address" id="add_floorClientEntity_address"
                               placeholder="客户地址"/>
                    </div>
                    <div class="form-group">
                        <label for="add_floorClientEntity_phoneNumber">客户电话</label>
                        <input type="text" class="form-control validate[custom[phone]]" name="floorClientEntity.phoneNumber" id="add_floorClientEntity_phoneNumber"
                               placeholder="客户电话"/>
                    </div>
                    <div class="form-group">
                        <label for="add_floorClientEntity_email">客户电子邮件</label>
                        <input type="email" class="form-control validate[custom[email]]" name="floorClientEntity.email" id="add_floorClientEntity_email"
                               placeholder="客户电子邮件"/>
                    </div>
                    <div role="separator" class="divider"></div>
                    <div class="form-group">
                        是否地暖
                        <label class="radio-inline">
                            <input type="radio" name="floorProjectEntity.floorHeating" checked="checked" id="inlineRadio3" value="1"> 是
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="floorProjectEntity.floorHeating" id="inlineRadio4" value="0"> 否
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="add_floorProjectEntity_progress">施工进度</label>
                        <input type="text" class="form-control" name="floorProjectEntity.progress" id="add_floorProjectEntity_progress"
                               placeholder="施工进度"/>
                    </div>
                    <div class="form-group">
                        <label for="add_floorProjectEntity_floorType">地板类型</label>
                        <input type="text" class="form-control" name="floorProjectEntity.floorType" id="add_floorProjectEntity_floorType"
                               placeholder="地板类型"/>
                    </div>
                    <div class="form-group">
                        <label for="add_floorProjectEntity_communicationProgress">沟通情况</label>
                        <input type="text" class="form-control" name="floorProjectEntity.communicationProgress" id="add_floorProjectEntity_communicationProgress"
                               placeholder="沟通情况"/>
                    </div>
                    <div class="form-group">
                        <label for="update_floorProjectEntity_visitTime">访问时间</label>
                        <input type="text" class="form-control form_datetime" name="floorProjectEntity.visitTime" id="add_floorProjectEntity_visitTime"/>
                    </div>
                    <div role="separator" class="divider"></div>
                    <div class="form-group">
                        <label for="add_floorDesignerEntity_name">设计师姓名</label>
                        <input type="text" class="form-control" name="floorDesignerEntity.name" id="add_floorDesignerEntity_name"
                               placeholder="设计师姓名"/>
                    </div>
                    <div class="form-group">
                        <label for="add_floorDesignerEntity_phoneNumber">设计师电话</label>
                        <input type="text" class="form-control validate[custom[phone]]" name="floorDesignerEntity.phoneNumber" id="add_floorDesignerEntity_phoneNumber"
                               placeholder="设计师电话"/>
                    </div>
                    <div class="form-group">
                        <label for="add_floorDesignerEntity_email">设计师电子邮件</label>
                        <input type="email" class="form-control validate[custom[email]]" name="floorDesignerEntity.email" id="add_floorDesignerEntity_email"
                               placeholder="设计师电子邮件"/>
                    </div>
                    <div style="text-align:center">
                    <button type="submit" class="btn btn-default" onclick="addAndSubmit()">提交</button>
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
    function addAndSubmit() {
        var time = $("#add_floorProjectEntity_visitTime").val().trim();
        if (time != null && time != undefined && time != '') {
            var unixTimestamp = Date.parse(new Date(time)) / 1000;
            $("#add_floorProjectEntity_visitTime").val(unixTimestamp);
        }
        $("#projectAddForm").submit();
/*
        $("#add_floorProjectEntity_visitTime").val(time);
*/
    }
</script>

<script>
    $('.form_datetime').datetimepicker({
        language : 'zh-CN',
        format: "yyyy-mm-dd hh:ii",
        weekStart : 1,
        todayBtn : 1,
        autoclose : 1,
        todayHighlight : 1,
        startView : 0,
        minView : 0,
        forceParse : true
    });
    <c:if test="${null ne msg}">
    layer.alert("${msg}", {icon: 0});
    </c:if>
</script>