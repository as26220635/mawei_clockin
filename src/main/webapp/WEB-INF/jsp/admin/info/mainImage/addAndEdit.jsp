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
    <input type="hidden" name="ID" value="${mainImage.ID}">
    <input type="hidden" name="insertId" value="${insertId}">
    <div class="form-group has-feedback">
        <label>名称:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_MAIN_IMAGE, "BMI_NAME")}
               value="${mainImage.BMI_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>备注:</label>
        <textarea ${fns:validField(TableName.BUS_MAIN_IMAGE,"BMI_REMARKS")}
                class="form-control form-textarea"
                rows="5">${mainImage.BMI_REMARKS}</textarea>
    </div>
    <s:fileInput title="附件" sdtCode="BUS_FILE_DEFAULT"
                 tableId="${not empty mainImage ? mainImage.ID: insertId}"
                 tableName="${TableName.BUS_MAIN_IMAGE}" typeCode="${TableName.BUS_MAIN_IMAGE}"
                 multiple="false"
    ></s:fileInput>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>