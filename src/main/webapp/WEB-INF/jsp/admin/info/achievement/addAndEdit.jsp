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
    <input type="hidden" name="ID" value="${achievement.ID}">
    <input type="hidden" name="insertId" value="${insertId}">
    <div class="form-group has-feedback">
        <label>成就墙名称:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_ACHIEVEMENT, "BA_NAME")}
               value="${achievement.BA_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>经度:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_ACHIEVEMENT, "BA_LONGITUDE")}
               value="${achievement.BA_LONGITUDE}">
    </div>
    <div class="form-group has-feedback">
        <label>纬度:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_ACHIEVEMENT, "BA_LATITUDE")}
               value="${achievement.BA_LATITUDE}">
    </div>
    <div class="form-group has-feedback">
        <label>范围:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_ACHIEVEMENT, "BA_RANGE")}
               value="${achievement.BA_RANGE}">
    </div>
    <s:fileInput title="附件" sdtCode="BUS_FILE_DEFAULT"
                 tableId="${not empty achievement ? achievement.ID: insertId}"
                 tableName="${TableName.BUS_ACHIEVEMENT}" typeCode="${TableName.BUS_ACHIEVEMENT}"
                 multiple="false"
    ></s:fileInput>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>