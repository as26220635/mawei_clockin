<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .zoom-img-wrap{
        position: absolute;
    }
</style>
<script>
    //图片
    function formatterImg(value, row, index) {
        return '<img src="${BASE_URL}${AttributePath.FILE_PREVIEW_URL}' + value + '"  style="width:50px;height:auto;" data-action="zoom"/>';
    }
</script>
<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/treeGrid.jsp" %>
<script>
    //添加
    $('#addBtn').on('click', function () {
        ajax.getHtml('${BASE_URL}${Url.MAINIMAGE_ADD_URL}', {}, function (html) {
                model.show({
                    title: '添加主页图片',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    isConfirm: true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.post('${BASE_URL}${Url.MAINIMAGE_ADD_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, true);
                        })
                    }
                });
            }
        );
    });

    //区域管理
    $treeGridTable.find('tbody').on('click', '#area', function () {
        var data = getRowData(this);
        var id = data.ID;
        var param = {
            BMI_ID: id,
            TITLE: data.BMI_NAME,
        };
        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("MOBILE:MAINIMAGE_AREA")}' + urlEncode(param));
    });

    //修改
    $treeGridTable.find('tbody').on('click', '#edit', function () {
        var data = getRowData(this);
        var id = data.ID;
        var index = $(this).attr("data-index");

        ajax.getHtml('${BASE_URL}${Url.MAINIMAGE_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改主页图片',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    <shiro:hasPermission name="MOBILE:MAINIMAGE_UPDATE_SAVE">
                    isConfirm: true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.put('${BASE_URL}${Url.MAINIMAGE_UPDATE_URL}', params, function (data) {
                            if (data.code == STATUS_SUCCESS) {
                                model.hide($model);
                                demo.showNotify(ALERT_SUCCESS, data.message);
                                //刷新菜单
                                $treeGridTable.bootstrapTable('updateRow', {index: index, row: params});
                            } else {
                                demo.showNotify(ALERT_WARNING, data.message);
                            }
                        });
                    }
                    </shiro:hasPermission>
                });
            }
        );
    });

    //成就墙
    $treeGridTable.find('tbody').on('click', '#achievement', function () {
        var data = getRowData(this);
        var id = data.ID;

        treeBox.init({
            title: '选择成就墙',
            url:'${BASE_URL}${Url.MAINIMAGE_TREE_DATA_URL}',
            modelSize: model.size.LG,
            searchParams: {
                BMI_ID: id
            },
            isConfirm: true,
            confirm: function ($model, nodes) {
                var achievementIds = "";
                for (var i = 0; i < nodes.length; i++) {
                    achievementIds += (nodes[i].id + SERVICE_SPLIT);
                }
                var params = {};
                params.ID = id;
                params.achievementIds = achievementIds;

                ajax.put('${BASE_URL}${Url.MAINIMAGE_TREE_UPDATE_URL}', params, function (data) {
                    ajaxReturn.tree(data, $model, null, null);
                })
            }
        });
    });

    //删除
    $treeGridTable.find('tbody').on('click', '#del', function () {
        var data = getRowData(this);
        var id = data.ID;

        model.show({
            title: '删除主页图片',
            content: '是否删除主页图片:' + data.BMI_NAME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.MAINIMAGE_DELETE_URL}/' + id, {}, function (data) {
                    if (data.code == STATUS_SUCCESS) {
                        model.hide($model);
                        demo.showNotify(ALERT_SUCCESS, data.message);
                        $treeGridTable.bootstrapTable('refresh', {silent: false});
                    } else {
                        demo.showNotify(ALERT_WARNING, data.message);
                    }
                })
            }
        });
    });

    //切换状态
    function onSwitchChange($this, field, check, IS_STATUS) {
        showLoadingContentDiv();
        ajax.put('${BASE_URL}${Url.MAINIMAGE_SWITCHSTATUS_URL}', {
            ID: $this.val(),
            IS_STATUS: IS_STATUS
        }, function (data) {
            if (data.code == STATUS_SUCCESS) {
                demo.showNotify(ALERT_SUCCESS, '状态修改成功!');
            } else {
                $this.bootstrapSwitch('toggleState', true);
                demo.showNotify(ALERT_WARNING, data.message);
            }
            removeLoadingDiv();
        });
    }
</script>