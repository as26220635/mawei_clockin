<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //封面
    function imgFunc(targets, field) {
        return {
            targets: targets,
            data: field,
            render: function (data, type, full, meta) {
                if (isEmpty(data)){
                    return "";
                }
                return '<img src="${BASE_URL}${AttributePath.FILE_PREVIEW_URL}' + data + '"  style="width:100px;height:auto;" data-action="zoom"/>';
            }
        };
    }
</script>
<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    //添加
    $('#addBtn').on('click', function () {
        var param = {
            TITLE: '添加活动',
        };
        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("MOBILE:ACTIVITY_INSERT")}' + urlEncode(param));
    });

    //修改
    $dataGridTable.find('tbody').on('click', '#edit', function () {
        var data = getRowData(this);
        var id = data.ID;

        var param = {
            TITLE: data.BA_TITLE,
        };
        //切换主界面
        var url = '${fns:getUrlByMenuCode("MOBILE:ACTIVITY_UPDATE")}';
        url = url.replace('{ID}', id);
        loadUrl('${BASE_URL}' + url + urlEncode(param));
    });

    //删除
    $dataGridTable.find('tbody').on('click', '#del', function () {
        var data = getRowData(this);
        var id = data.ID;

        model.show({
            title: '删除活动',
            content: '是否删除活动:' + data.BA_TITLE,
            class: model.class.DANGER,
            okBtnName: model.btnName.DEL,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                ajax.del('${BASE_URL}${Url.ACTIVITY_DELETE_URL}/' + id, {}, function (data) {
                    ajaxReturn.data(data, $model, $dataGrid, false);
                })
            }
        });
    });

    //切换状态
    function onSwitchChange($this, field, check, IS_STATUS) {
        showLoadingContentDiv();
        ajax.put('${BASE_URL}${Url.ACTIVITY_SWITCHSTATUS_URL}', {
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