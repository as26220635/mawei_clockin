<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/3/27
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .bottom-icon {
        width: 50px;
        height: 50px;
    }
</style>
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box" id="boxContentDiv">
                <div class="box-header">
                    <div class="col-md-12 btn-group-header">
                        <s:button smId="${MENU.ID}"></s:button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="col-md-12">
                        <div class="box box-default">
                            <div class="box-body">
                                <form id="addAndEditForm">
                                    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
                                    <input type="hidden" name="ID" value="${activity.ID}">
                                    <input type="hidden" name="insertId" value="${insertId}">
                                    <div class="form-group has-feedback">
                                        <label>标题:</label>
                                        <input type="text"
                                               class="form-control" ${fns:validField(TableName.BUS_ACTIVITY, "BA_TITLE")}
                                               value="${activity.BA_TITLE}">
                                    </div>
                                    <s:fileInput title="封面" sdtCode="${Attribute.BUS_FILE_DEFAULT}"
                                                 tableId="${not empty activity ? activity.ID: insertId}"
                                                 tableName="${TableName.BUS_ACTIVITY}"
                                                 typeCode="${TableName.BUS_ACTIVITY}"
                                                 multiple="false"
                                    ></s:fileInput>
                                    <div class="form-group has-feedback">
                                        <label>内容:</label>
                                        <textarea ${fns:validField(TableName.BUS_ACTIVITY, "BA_CONTENT")}>${activity.BA_CONTENT}</textarea>
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

<%--标题--%>
<c:if test="${!fns:isEmpty(EXTRA.TITLE)}">
    <c:set scope="request" var="MENU_TITLE" value="${EXTRA.TITLE}-"></c:set>
</c:if>
<%@ include file="/WEB-INF/jsp/admin/component/setTitleParams.jsp" %>
<script>
    function save(){
        var $form = $('#addAndEditForm');
        //验证
        if (!validator.formValidate($form)) {
            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
            return;
        }
        var params = packFormParams($form);
        params['BA_CONTENT']  = editText.getTinyMceContent('BA_CONTENT');

        <c:choose>
        <c:when test="${action eq 1}">
        ajax.post('${BASE_URL}${Url.ACTIVITY_ADD_URL}', params, function (data) {
            ajaxReturn.data(data, null, null, null, {
                success: function () {
                    backHtml();
                }
            });
        })
        </c:when>
        <c:otherwise>
        ajax.put('${BASE_URL}${Url.ACTIVITY_UPDATE_URL}', params, function (data) {
            ajaxReturn.data(data, null, null, null);
        })
        </c:otherwise>
        </c:choose>

    }

    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>
<script>
    //创建富文本
    editText.initEdit({
        selector: '#BA_CONTENT',
        form: '#my_form',
        imgInput: '#imgUpload',
        fileServiceUrl:'${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}',
        uploadUrl: '${BASE_URL}${AttributePath.FILE_UPLOAD_TEXTAREA_URL}',
        tableId: '${not empty activity ? activity.ID: insertId}',
        tableName: '${TableName.BUS_ACTIVITY}',
        typeCode: '${TableName.BUS_ACTIVITY}',
        seeType: '${Attribute.STATUS_SUCCESS}',
    });
</script>