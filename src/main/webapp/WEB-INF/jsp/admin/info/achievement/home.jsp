<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //头像
    function imgFunc(targets, field) {
        return {
            targets: targets,
            data: field,
            render: function (data, type, full, meta) {
                if (isEmpty(data)){
                    return "";
                }
                return '<img src="${BASE_URL}${AttributePath.FILE_PREVIEW_URL}' + data + '"  style="width:50px;height:50px" data-action="zoom"/>';
            }
        };
    }
</script>
<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    //添加
    $('#addBtn').on('click', function () {
        ajax.getHtml('${BASE_URL}${Url.ACHIEVEMENT_ADD_URL}', {}, function (html) {
                model.show({
                    title: '添加成就墙',
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

                        ajax.post('${BASE_URL}${Url.ACHIEVEMENT_ADD_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, true);
                        })
                    }
                });
            }
        );
    });

    /**
     * 最终成就
     */
    function endAchievement() {
        var $this = $(this);
        var id = '${fns:AESEncode(1)}';
        var typeCode = 'BUS_ACHIEVEMENT_END';
        var sdtCode = 'BUS_ACHIEVEMENT_END';
        var textName = '最终成就';

        ajax.getHtml('${BASE_URL}${Url.FILE_SERVER_UPDATE_URL}/' + id, {
                typeCode: typeCode,
                sdtCode: sdtCode,
                multiple: false,
            }, function (html) {
                model.show({
                    title: textName,
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                });
            }
        );
    }

    //打卡记录
    $dataGridTable.find('tbody').on('click', '#clockin', function () {
        var data = getRowData(this);
        var param = {
            BA_ID: data.ID,
            TITLE: data.BA_NAME,
        };
        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("MOBILE:CLOCKIN")}' + urlEncode(param));
    });

    //分享图片管理
    $dataGridTable.find('tbody').on('click', '#share', function () {
        var data = getRowData(this);
        var param = {
            BA_ID: data.ID,
            TITLE: data.BA_NAME,
        };
        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("MOBILE:ACHIEVEMENT_SHARE")}' + urlEncode(param));
    });

    //修改
    $dataGridTable.find('tbody').on('click', '#edit', function () {
        var data = getRowData(this);
        var id = data.ID;

        ajax.getHtml('${BASE_URL}${Url.ACHIEVEMENT_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改成就墙',
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    <shiro:hasPermission name="MOBILE:ACHIEVEMENT_UPDATE_SAVE">
                    isConfirm: true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.put('${BASE_URL}${Url.ACHIEVEMENT_UPDATE_URL}', params, function (data) {
                            ajaxReturn.data(data, $model, $dataGrid, false);
                        });
                    }
                    </shiro:hasPermission>
                });
            }
        );
    });

    //删除
    $dataGridTable.find('tbody').on('click', '#del', function () {
        var data = getRowData(this);
        var id = data.ID;

        model.show({
            title: '删除成就墙',
            content: '是否删除成就墙:' + data.BDM_NAME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.ACHIEVEMENT_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });

    //切换状态
    function onSwitchChange($this, field, check, IS_STATUS) {
        showLoadingContentDiv();
        ajax.put('${BASE_URL}${Url.ACHIEVEMENT_SWITCHSTATUS_URL}', {
            ID: $this.val(),
            IS_STATUS: IS_STATUS
        }, function (data) {
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