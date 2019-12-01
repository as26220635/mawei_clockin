<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //查询额外参数
    function searchParams(param) {
        param.BA_ID = '${EXTRA.BA_ID}';
        param.BW_ID = '${EXTRA.BW_ID}';
    }
</script>
<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    <c:choose>
    <c:when test="${empty EXTRA.BA_ID and empty EXTRA.BW_ID}">
    $('#return').remove();
    </c:when>
    <c:otherwise>
    tableView.reload($dataGrid, true);
    </c:otherwise>
    </c:choose>
    //添加
    $('#addBtn').on('click', function () {
        ajax.getHtml('${BASE_URL}${Url.CLOCKIN_ADD_URL}', {}, function (html) {
                model.show({
                    title: '添加打卡记录',
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

                        ajax.post('${BASE_URL}${Url.CLOCKIN_ADD_URL}', params, function (data) {
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

        ajax.getHtml('${BASE_URL}${Url.CLOCKIN_UPDATE_URL}/' + id, {}, function (html) {
                model.show({
                    title: '修改打卡记录,微信用户:' + data.BW_USERNAME + ',时间;' + data.BAD_ENTERTIME,
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                    <shiro:hasPermission name="MOBILE:CLOCKIN_UPDATE_SAVE">
                    isConfirm: true,
                    confirm: function ($model) {
                        var $form = $('#addAndEditForm');
                        //验证
                        if (!validator.formValidate($form)) {
                            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                            return;
                        }
                        var params = packFormParams($form);

                        ajax.put('${BASE_URL}${Url.CLOCKIN_UPDATE_URL}', params, function (data) {
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
            title: '删除打卡记录',
            content: '是否删除打卡记录:' + data.BDM_NAME,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.CLOCKIN_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });
</script>