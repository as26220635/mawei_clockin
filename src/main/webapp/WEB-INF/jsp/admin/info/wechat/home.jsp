<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    //头像
    function avatarFunc(targets, field) {
        return {
            targets: targets,
            data: field,
            render: function (data, type, full, meta) {
                return '<img src="' + data + '" class="img-rounded" style="width:45px;height:45px" data-action="zoom"/>';
            }
        };

    }
</script>
<%--通用列表--%>
<%@ include file="/WEB-INF/jsp/admin/component/grid/dataGrid.jsp" %>
<script>
    //打卡记录
    $dataGridTable.find('tbody').on('click', '#clockin', function () {
        var data = getRowData(this);
        var param = {
            BW_ID: data.ID,
            TITLE: data.BW_USERNAME,
        };
        //切换主界面
        loadUrl('${BASE_URL}${fns:getUrlByMenuCode("MOBILE:CLOCKIN")}' + urlEncode(param));
    });

    //分享图片管理
    $dataGridTable.find('tbody').on('click', '#share', function () {
        var data = getRowData(this);
        var $this = $(this);

        var id = data.ID;
        var tableName = '${TableName.BUS_WECHAT}';
        var typeCode = '${TableName.BUS_ACHIEVEMENT_SHARE}';
        var sdtCode = '${TableName.BUS_ACHIEVEMENT_SHARE}';
        var textName = '分享图片:' + data.BW_USERNAME;

        ajax.getHtml('${BASE_URL}${Url.FILE_SERVER_UPDATE_URL}/' + id, {
                tableName: tableName,
                typeCode: typeCode,
                sdtCode: sdtCode,
                multiple: false,
                showUpload: false,
                showRemove: false,
            }, function (html) {
                model.show({
                    title: textName,
                    content: html,
                    footerModel: model.footerModel.ADMIN,
                });
            }
        );
    });

    //切换状态
    function onSwitchChange($this, field, check, IS_STATUS) {
        showLoadingContentDiv();
        ajax.put('${BASE_URL}${Url.WECHAT_SWITCHSTATUS_URL}', {
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