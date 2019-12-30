<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2019/11/27
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<style>
    .page__hd{
        background: url("${BASE_URL}resources/assets/images/main/achievement.jpg");
        background-size: 100%;
        background-size: cover;
        height: 55px;
    }
    .weui-grid__icon {
        width: 100px;
        height: 100px;
    }

    .weui-grid__icon img {
        width: auto;
        height: 88px;
        margin: auto;
    }
</style>

<div class="container container-page">
    <div class="page__hd">
<%--        <h1 class="page__title">成就墙</h1>--%>
<%--        <p class="page__desc">已收集${clockinCount}/${achievementList.size()}个成就</p>--%>
    </div>
    <div class="weui-grids weui-cells">
        <c:forEach items="${achievementList}" var="achievement">
            <c:choose>
                <c:when test="${achievement.BAD_COUNT > 0}">
<%--                    href="${BASE_URL}achievement/share/${achievement.ID}/${wechatUser.id}?action=2" data-pjax="#${CONTAINER}"--%>
                    <a class="weui-grid"  href="${BASE_URL}achievement/share/${achievement.BAD_ID}/${achievement.ID}/${wechatUser.id}?action=2" data-pjax="#${CONTAINER}">
                        <div class="weui-grid__icon">
                            <img src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${achievement.IMG_PATH_IN}">
                        </div>
                        <p class="weui-grid__label">${achievement.BA_NAME}</p>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="javascript:;" class="weui-grid">
                        <div class="weui-grid__icon weui-grid__gray">
                            <img src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${achievement.IMG_PATH_IN}">
                        </div>
                        <p class="weui-grid__label">${achievement.BA_NAME}</p>
                    </a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</div>
<script>
    showBottpmMenu();
    switchTabbar('achievementTabbar');
    mainInit.initPjax();
</script>
