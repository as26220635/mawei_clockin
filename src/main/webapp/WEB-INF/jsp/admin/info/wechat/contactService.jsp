<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/3/27
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box" id="boxContentDiv">
                <form id="addAndEditForm">
                    <s:fileInput title="客服二维码" sdtCode="${Attribute.BUS_FILE_DEFAULT}"
                                 tableId="${contactServiceFileId}"
                                 tableName="CONTACT_SERVICE" typeCode="CONTACT_SERVICE"
                                 maxFilesNum="1" maxFileCount="1"
                    ></s:fileInput>
                </form>
            </div>
        </div>
    </div>
</section>


<script>
    editMenuTitle('联系客服');
</script>