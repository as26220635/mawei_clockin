<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    clearOrderColor();

    //查询额外参数
    function searchParams(param) {
        param.SV_ID = '${EXTRA.SV_ID}';
    }

    //格式化组
    function formatterValidateGroups(targets, field) {
        return {
            targets: targets,
            data: field,
            render: function (data, type, full, meta) {
                var btns = '<div class="btn-list">';
                if (!isEmpty(data)) {
                    var names = data.split(SERVICE_SPLIT);
                    for (var i in names) {
                        var name = names[i];
                        var color = getOrderColor(name);
                        btns += '<button class="btn btn-xs ' + color + '">' + name + '</button>';
                    }
                }
                btns += "</div>";
                return btns;
            }
        };
    }
</script>
<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    setTimeout(function () {
        setMenuActive('admin-dataGrid-${MENU.SM_PARENTID}');
        editMenuTitle('${EXTRA.SV_TABLE}-' + getMenuTitle());
    }, 50);

    //验证组
    $('#group').on('click', function () {
        var param = {
            SV_ID: '${EXTRA.SV_ID}',
            SV_TABLE: '${EXTRA.SV_TABLE}',
        };
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("SYSTEM:VALIDATE_GROUP")}' + urlEncode(param));
    });

    //添加
    $('#addBtn').on('click', function () {
        ajax.getHtml('${BASE_URL}${Url.VALIDATE_FIELD_ADD_URL}', {SV_ID: '${EXTRA.SV_ID}'}, function (html) {
                model.show({
                    title: '添加验证字段',
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

                        ajax.post('${BASE_URL}${Url.VALIDATE_FIELD_ADD_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, true);
                        })
                    }
                });
            }
        );
    });

    //修改
    $dataGridTable.find('tbody').on('click', '#edit', function () {
        var data = getRowData(this);
        var id = data.ID;

        ajax.getHtml('${BASE_URL}${Url.VALIDATE_FIELD_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改验证字段',
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

                        ajax.put('${BASE_URL}${Url.VALIDATE_FIELD_UPDATE_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, false);
                        });
                    }
                });
            }
        );
    });

    //删除
    $dataGridTable.find('tbody').on('click', '#del', function () {
        var data = getRowData(this);
        var id = data.ID;

        model.show({
            title: '删除验证字段',
            content: '是否删除验证字段:' + data.SVF_NAME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.VALIDATE_FIELD_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });

    //切换状态
    function onSwitchChange($this, field, check, IS_STATUS) {
        showLoadingContentDiv();
        ajax.put('${BASE_URL}${Url.VALIDATE_FIELD_SWITCH_STATUS_URL}', {ID: $this.val(), IS_STATUS: IS_STATUS}, function (data) {
            if (data.code == STATUS_SUCCESS) {
                demo.showNotify(ALERT_SUCCESS, '状态修改成功!');
            } else {
                $this.bootstrapSwitch('toggleState', true);
                demo.showNotify(ALERT_WARNING, '状态修改失败!');
            }
            removeLoadingDiv();
        });
    }
</script>