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
    <a  class="weui-media-box weui-media-box_appmsg" href="${BASE_URL}activity/item/${detail.ID}" data-pjax="#${CONTAINER}">
        <c:if test="${not empty detail.IMG_PATH}}">
            <div class="weui-media-box__hd">
                <img class="weui-media-box__thumb" src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${detail.IMG_PATH}" alt="">
            </div>
        </c:if>
        <div class="weui-media-box__bd">
            <h4 class="weui-media-box__title">${detail.BA_TITLE}</h4>
            <p class="weui-media-box__desc">${detail.BA_ENTRY_TIME}</p>
        </div>
    </a>
</c:forEach>
<script>
    mainInit.initPjax();
</script>