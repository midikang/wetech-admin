<%--
  Created by IntelliJ IDEA.
  User: cjbi
  Date: 2018/4/6
  Time: 7:43
  空页面.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!-- Content Header (Page header) -->
<section class="content-header" style="">
    <h1>
        用户管理
        <small>系统用户管理页面</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 主页</a></li>
        <li><a href="#">用户管理</a></li>
        <li class="active">系统用户管理</li>
    </ol>
</section>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="btn-group btn-group-sm" id="toolbar">
                        <!-- Provides extra visual weight and identifies the primary action in a set of buttons -->
                        <shiro:hasPermission name="user:create">
                        <button type="button" id="addBtn" class="btn btn-default" data-toggle="modal"
                                data-target="#addModal"><i class="glyphicon glyphicon-plus"></i> 新增
                        </button>
                        </shiro:hasPermission>
                        <!-- Indicates caution should be taken with this action -->
                        <shiro:hasPermission name="user:update">
                        <button type="button" id="editBtn" class="btn btn-default" data-toggle="modal"
                                data-target="#editModal"
                                data-action="{type:'editable',form:'#editForm',table:'#table',after:'editAfter'}"
                                disabled><i class="glyphicon glyphicon-edit"></i> 修改
                        </button>
                        </shiro:hasPermission>
                        <!-- Indicates a dangerous or potentially negative action -->
                        <shiro:hasPermission name="user:delete">
                        <button type="button" id="deleteBtn" class="btn btn-default" data-toggle="modal"
                                data-target="#deleteModal"
                                data-action="{type:'delete',form:'#deleteForm',idField:'id',table:'#table'}" disabled><i
                                class="glyphicon glyphicon-remove"></i> 删除
                        </button>
                        </shiro:hasPermission>
                    </div>
                    <table id="table"></table>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->

        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->
</section>
<!-- /.content -->

<!-- add Modal -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="addModalLabel">添加用户</h4>
            </div>
            <div class="modal-body">
                <form id="addForm">
                    <div class="form-group">
                        <label class="control-label" for="username"><span class="asterisk">*</span>用户名:</label>
                        <input id="username" type="text" class="form-control" name="username" placeholder="输入用户名"
                               minlength="3" required>
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="password"><span class="asterisk">*</span>密码:</label>
                        <input type="password" id="password" class="form-control" id="password" minlength="6"
                               name="password" placeholder="输入密码" required>
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="inputPasswordConfirm"><span
                                class="asterisk">*</span>确认密码:</label>
                        <input type="password" class="form-control" id="inputPasswordConfirm" minlength="6"
                               data-match="#password" data-match-error="密码输入不一致。" name="chkpassowrd" placeholder="确认密码"
                               required>
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="organizationName"><span class="asterisk">*</span>所属组织:</label>
                        <input type="text" class="form-control" id="organizationName" name="organizationName" readonly
                               required>
                        <input type="hidden" id="organizationId" name="organizationId" readonly required>
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="roleIds"><span class="asterisk">*</span>角色列表:</label>
                        <select name="roleIds" id="roleIds" multiple class="form-control chosen-select"
                                data-placeholder="请从列表选择一项" required>
                            <c:forEach items="${roleList}" var="role">
                                <option value="${role.id}">${role.description}</option>
                            </c:forEach>
                        </select>
                        <div class="help-block with-errors"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="submit" form="addForm" class="btn btn-primary"
                        data-action="{type:'submit',form:'#addForm',url:'<%=request.getContextPath()%>/user/create',after:'$.myAction.refreshTable'}">
                    确定
                </button>
            </div>
        </div>
    </div>
</div>
<!-- edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="editModalLabel">修改用户</h4>
            </div>
            <div class="modal-body">
                <form id="editForm">
                    <input type="hidden" name="id"/>
                    <div class="form-group">
                        <label class="control-label" for="username"><span class="asterisk">*</span>用户名:</label>
                        <input id="editUsername" type="text" class="form-control" name="username" placeholder="输入用户名"
                               minlength="3" readonly required>
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="organizationName"><span class="asterisk">*</span>所属组织:</label>
                        <input type="text" class="form-control" id="editOrganizationName" name="organizationName"
                               readonly required>
                        <input type="hidden" id="editOrganizationId" name="organizationId" required>
                        <div class="help-block with-errors"></div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="editRoleIds"><span class="asterisk">*</span>角色列表:</label>
                        <select name="roleIds" id="editRoleIds" multiple class="form-control chosen-select"
                                data-placeholder="请从列表选择一项" required>
                            <c:forEach items="${roleList}" var="role">
                                <option value="${role.id}">${role.description}</option>
                            </c:forEach>
                        </select>
                        <div class="help-block with-errors"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="submit" form="editForm" class="btn btn-primary"
                        data-action="{type:'submit',form:'#editForm',url:'<%=request.getContextPath()%>/user/update',after:'$.myAction.refreshTable'}">
                    确定
                </button>
            </div>
        </div>
    </div>
</div>

<!-- delete modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteSmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="deleteSmallModalLabel">删除用户</h4>
            </div>
            <div class="modal-body">
                <form id="deleteForm"></form>
                确定要删除选中的 <span class="records"></span> 条记录?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" form="deleteForm" class="btn btn-primary"
                        data-action="{type:'submit',form:'#deleteForm',url:'<%=request.getContextPath()%>/user/delete',after:'$.myAction.refreshTable'}">
                    确定
                </button>
            </div>
        </div>
    </div>
</div>

<!-- zTree -->
<div id="menuContent" class="menuContent"
     style="display:none;z-index:1989101600;position: absolute;border: 1px solid #ccc; background-color: #fff;">
    <ul id="tree" class="ztree"></ul>
</div>
<script>

    var $table = $('#table');

    $(function () {
        // bootstrap table初始化
        // http://bootstrap-table.wenzhixin.net.cn/zh-cn/documentation/
        $table.bootstrapTable({
            url: path + '/user/list',
            idField: 'id',
            searchOnEnterKey: false,
            columns: [
                {field: 'state', checkbox: true},
                {field: 'id', title: '编号', sortable: true, halign: 'left'},
                {field: 'username', title: '用户名', sortable: true, halign: 'left'},
                {field: 'organizationName', title: '所属组织', sortable: true, halign: 'left'},
                {field: 'roleNames', title: '角色列表', sortable: true, halign: 'left'},
                {
                    field: 'action',
                    title: '操作',
                    halign: 'center',
                    align: 'center',
                    formatter: 'actionFormatter',
                    events: 'actionEvents',
                    clickToSelect: false
                }
            ]
        });
    });

    // 数据表格展开内容
    function detailFormatter(index, row) {
        var html = [];
        $.each(row, function (key, value) {
            html.push('<p><b>' + key + ':</b> ' + value + '</p>');
        });
        return html.join('');
    }

    function editAfter(obj,row) {
        var roleIdList = row.roleIdList;
        for (i in roleIdList) {
            var roleId = roleIdList[i];
            $('#editForm').find('[name=roleIds]').find('option[value=' + roleId + ']').prop('selected', true);
        }
        $(".chosen-select").trigger("chosen:updated");
    }

    function actionFormatter(value, row, index) {
        return '\
        <a class="like" href="javascript:void(0)" data-toggle="tooltip" title="Like"><i class="glyphicon glyphicon-heart"></i></a>　\
        <shiro:hasPermission name="user:update">\
        <a class="edit ml10" href="javascript:void(0)" data-toggle="tooltip" title="编辑"><i class="glyphicon glyphicon-edit"></i></a>　\
        </shiro:hasPermission>\
        <shiro:hasPermission name="user:delete">\
        <a class="remove ml10" href="javascript:void(0)" data-toggle="tooltip" title="删除"><i class="glyphicon glyphicon-remove"></i></a>　\
        </shiro:hasPermission>\
        ';
    }

    window.actionEvents = {
        'click .like': function (e, value, row, index) {
            alert('You click like icon, row: ' + JSON.stringify(row));
            console.log(value, row, index);
        },
        'click .edit': function (e, value, row, index) {
            $('#editModal').modal('show')
            $('#editForm').fillForm(row);
            editAfter('',row);
            console.log(value, row, index);
        },
        'click .remove': function (e, value, row, index) {
            $('#deleteModal').modal('show');
            $('.records').html('1');
            var html = '';
            for (var key in row) {
                html += '<input type="hidden" name="' + key + '" value="' + row[key] + '">';
            }
            $('#deleteForm').html(html);
        }
    };

    var setting = {
        view: {
            dblClickExpand: false
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onClick: onClick
        }
    };

    var zNodes = [
        <c:forEach items="${organizationList}" var="o">
        <c:if test="${not o.rootNode}">
        {id:${o.id}, pId:${o.parentId}, name: "${o.name}"},
        </c:if>
        </c:forEach>
    ];

    function onClick(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("tree"),
            nodes = zTree.getSelectedNodes(),
            id = "",
            name = "";
        nodes.sort(function compare(a, b) {
            return a.id - b.id;
        });
        for (var i = 0, l = nodes.length; i < l; i++) {
            id += nodes[i].id + ",";
            name += nodes[i].name + ",";
        }
        if (id.length > 0) id = id.substring(0, id.length - 1);
        if (name.length > 0) name = name.substring(0, name.length - 1);
        $("#organizationId").val(id);
        $("#organizationName").val(name);
        $("#editOrganizationId").val(id);
        $("#editOrganizationName").val(name);
        hideMenu();
    }

    function showMenu() {
        var cityObj = $("#organizationName");
        var cityOffset = $("#organizationName").offset();
        $("#menuContent").css({
            left: cityOffset.left + "px",
            top: cityOffset.top + cityObj.outerHeight()
        }).slideDown("fast");

        $("body").bind("mousedown", onBodyDown);
    }

    function showMenuOfEdit() {
        var cityObj = $("#editOrganizationName");
        var cityOffset = $("#editOrganizationName").offset();
        $("#menuContent").css({
            left: cityOffset.left + "px",
            top: cityOffset.top + cityObj.outerHeight()
        }).slideDown("fast");

        $("body").bind("mousedown", onBodyDown);
    }

    function hideMenu() {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }

    function onBodyDown(event) {
        if (!(event.target.id == "organizationName" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
            hideMenu();
        }
    }

    $.fn.zTree.init($("#tree"), setting, zNodes);
    $("#organizationName").click(showMenu);
    $("#editOrganizationName").click(showMenuOfEdit);
</script>