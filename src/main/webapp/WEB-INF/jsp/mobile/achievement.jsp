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
    .weui-grid__icon {
        width: 100px;
        height: 100px;
    }

    .weui-grid__icon img {
        height: 85px;
    }

    .weui-grid__gray {
        -webkit-filter: grayscale(100%);
        -moz-filter: grayscale(100%);
        -ms-filter: grayscale(100%);
        -o-filter: grayscale(100%);
        filter: grayscale(100%);
        filter: gray;
    }
</style>

<div class="container container-page">
    <div class="page__hd">
        <h1 class="page__title">成就墙</h1>
        <p class="page__desc">已收集${clockinCount}/${achievementList.size()}个成就</p>
    </div>
    <div class="weui-grids">
        <c:forEach items="${achievementList}" var="achievement">
            <a href="javascript:;" class="weui-grid">
                <div class="weui-grid__icon ${fns:trueOrFalse(achievement.BAD_COUNT > 0,'' , 'weui-grid__gray')}">
                    <img src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${achievement.IMG_PATH}">
                </div>
                <p class="weui-grid__label">${achievement.BA_NAME}</p>
            </a>
        </c:forEach>
    </div>
</div>
<script>
    showBottpmMenu();
    switchTabbar('achievementTabbar');
    mainInit.initPjax();
</script>
