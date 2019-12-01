<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2019/11/26
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>

<c:forEach items="${detailList}" var="detail">
    <a class="weui-cell weui-cell_access" href="${BASE_URL}my/clockin/${detail.ID}" data-pjax="#${CONTAINER}">
        <div class="weui-cell__bd">
            <p>${detail.BA_NAME}</p>
        </div>
        <div class="weui-cell__ft">${detail.BAD_ENTERTIME}</div>
    </a>
</c:forEach>
<script>
    mainInit.initPjax();
</script>