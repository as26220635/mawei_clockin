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
    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
    <input type="hidden" name="ID" value="${detail.ID}">
    <input type="hidden" name="insertId" value="${insertId}">
    <div class="form-group has-feedback">
        <label>概述:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_ACHIEVEMENT_DETAIL, "BAD_REMARKS")}
               value="${detail.BAD_REMARKS}">
    </div>
    <s:fileInput title="附件" sdtCode="${Attribute.BUS_FILE_DEFAULT}"
                 tableId="${not empty detail ? detail.ID: insertId}"
                 tableName="${TableName.BUS_ACHIEVEMENT_DETAIL}" typeCode="${TableName.BUS_ACHIEVEMENT_DETAIL}"
                 maxFilesNum="${fns:trueOrFalse(detail.BAD_FILETYPE eq 1 , 9 , 1)}"
                 maxFileCount="${fns:trueOrFalse(detail.BAD_FILETYPE eq 1 , 9 , 1)}"
                 multiple="${fns:trueOrFalse(detail.BAD_FILETYPE eq 1 , true , false)}"
                 allowFile="${fns:trueOrFalse(detail.BAD_FILETYPE eq 1 , FileInput.IMAGE , FileInput.VIDEO)}"
    ></s:fileInput>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>