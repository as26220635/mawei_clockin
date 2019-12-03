<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/5/22
  Time: 23:48
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box" id="boxContentDiv">
                <div class="box-header">
                    <div class="col-md-12 btn-group-header">
                        <s:button back="false"></s:button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="col-md-12">
                        <div class="box box-default">
                            <div class="box-body">
                                <form id="addAndEditForm">
                                    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
                                    <div class="form-group has-feedback">
                                        <label>青春打卡:</label>
                                        <s:combobox sdtCode="SYS_YES_NO"
                                                    custom='${fns:validField(TableName.SYS_ALLOCATION,"MOBILE_BOTTOM_MENU_CLOCKIN")}'
                                                    value="${MOBILE_BOTTOM_MENU_CLOCKIN}" defaultValue="1"></s:combobox>
                                    </div>
                                    <div class="form-group has-feedback">
                                        <label>活动:</label>
                                        <s:combobox sdtCode="SYS_YES_NO"
                                                    custom='${fns:validField(TableName.SYS_ALLOCATION,"MOBILE_BOTTOM_MENU_ACTIVITY")}'
                                                    value="${MOBILE_BOTTOM_MENU_ACTIVITY}"
                                                    defaultValue="1"></s:combobox>
                                    </div>
                                    <div class="form-group has-feedback">
                                        <label>排行榜:</label>
                                        <s:combobox sdtCode="SYS_YES_NO"
                                                    custom='${fns:validField(TableName.SYS_ALLOCATION,"MOBILE_BOTTOM_MENU_RANK")}'
                                                    value="${MOBILE_BOTTOM_MENU_RANK}" defaultValue="1"></s:combobox>
                                    </div>
                                    <div class="form-group has-feedback">
                                        <label>成就墙:</label>
                                        <s:combobox sdtCode="SYS_YES_NO"
                                                    custom='${fns:validField(TableName.SYS_ALLOCATION,"MOBILE_BOTTOM_MENU_ACHIEVEMENT")}'
                                                    value="${MOBILE_BOTTOM_MENU_ACHIEVEMENT}"
                                                    defaultValue="1"></s:combobox>
                                    </div>
                                    <div class="form-group has-feedback">
                                        <label>个人中心:</label>
                                        <s:combobox sdtCode="SYS_YES_NO"
                                                    custom='${fns:validField(TableName.SYS_ALLOCATION,"MOBILE_BOTTOM_MENU_MY")}'
                                                    value="${MOBILE_BOTTOM_MENU_MY}" defaultValue="1"></s:combobox>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>


<script>
    editMenuTitle('前端底部菜单管理');
    //保存
    $('#save').click(function () {
        var $form = $('#addAndEditForm');
        //验证
        if (!validator.formValidate($form)) {
            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
            return;
        }
        var params = packFormParams($form);

        ajax.put('${BASE_URL}${Url.MOBILE_BOTTOM_MENU_BASE_URL}', params, function (data) {
            ajaxReturn.data(data, null, null, null);
        })
    });

    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>