<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/3/27
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form id="addAndEditForm">
    <div class="form-group has-feedback">
        <label>类型:</label>
        <s:combobox sdtCode="${DictTypeCode.BUS_ACHIEVEMENT_SHARE_TYPE}" custom='${fns:validField(TableName.BUS_ACHIEVEMENT_SHARE,"BAS_TYPE")}'
                    value="${share.BAS_TYPE}"></s:combobox>
    </div>
<%--    <div class="form-group has-feedback">--%>
<%--        <label>概述:</label>--%>
<%--        <textarea ${fns:validField(TableName.BUS_ACHIEVEMENT_SHARE,"BAS_TEXT")}--%>
<%--                class="form-control form-textarea"--%>
<%--                rows="5">${share.BAS_TEXT}</textarea>--%>
<%--    </div>--%>
<%--    <s:fileInput title="附件" sdtCode="BUS_FILE_DEFAULT"--%>
<%--                 tableId="${ID}"--%>
<%--                 tableName="${TableName.BUS_ACHIEVEMENT_SHARE}" typeCode="${TableName.BUS_ACHIEVEMENT_SHARE}"--%>
<%--                 multiple="false"--%>
<%--    ></s:fileInput>--%>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>