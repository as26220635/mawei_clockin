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
        <%--                <a href="javascript:;" class="weui-grid ">--%>
        <%--                    <div class="weui-grid__icon">--%>
        <%--                        <img src="${BASEURL}resources/assets/images/achievement/czbwg.png" alt="">--%>
        <%--                    </div>--%>
        <%--                    <p class="weui-grid__label">船政博物馆</p>--%>
        <%--                </a>--%>
        <%--                <a href="javascript:;" class="weui-grid">--%>
        <%--                    <div class="weui-grid__icon">--%>
        <%--                        <img src="${BASEURL}resources/assets/images/achievement/czgzy.png" alt="">--%>
        <%--                    </div>--%>
        <%--                    <p class="weui-grid__label">船政格致园</p>--%>
        <%--                </a>--%>
        <%--                <a href="javascript:;" class="weui-grid">--%>
        <%--                    <div class="weui-grid__icon">--%>
        <%--                        <img src="${BASEURL}resources/assets/images/achievement/hghgy.png" alt="">--%>
        <%--                    </div>--%>
        <%--                    <p class="weui-grid__label">红光湖公园</p>--%>
        <%--                </a>--%>
        <%--                <a href="javascript:;" class="weui-grid weui-grid__gray">--%>
        <%--                    <div class="weui-grid__icon">--%>
        <%--                        <img src="${BASEURL}resources/assets/images/achievement/jtlsy.png" alt="">--%>
        <%--                    </div>--%>
        <%--                    <p class="weui-grid__label">江涛烈士园</p>--%>
        <%--                </a>--%>
        <%--                <a href="javascript:;" class="weui-grid weui-grid__gray">--%>
        <%--                    <div class="weui-grid__icon">--%>
        <%--                        <img src="${BASEURL}resources/assets/images/achievement/lxt.png" alt="">--%>
        <%--                    </div>--%>
        <%--                    <p class="weui-grid__label">罗星塔</p>--%>
        <%--                </a>--%>
        <%--                <a href="javascript:;" class="weui-grid">--%>
        <%--                    <div class="weui-grid__icon">--%>
        <%--                        <img src="${BASEURL}resources/assets/images/achievement/magz.png" alt="">--%>
        <%--                    </div>--%>
        <%--                    <p class="weui-grid__label">闽安古镇</p>--%>
        <%--                </a>--%>
        <%--                <a href="javascript:;" class="weui-grid weui-grid__gray">--%>
        <%--                    <div class="weui-grid__icon">--%>
        <%--                        <img src="${BASEURL}resources/assets/images/achievement/mczx.png" alt="">--%>
        <%--                    </div>--%>
        <%--                    <p class="weui-grid__label">名城中心</p>--%>
        <%--                </a>--%>
        <%--                <a href="javascript:;" class="weui-grid">--%>
        <%--                    <div class="weui-grid__icon">--%>
        <%--                        <img src="${BASEURL}resources/assets/images/achievement/ndgmjyjd.png" alt="">--%>
        <%--                    </div>--%>
        <%--                    <p class="weui-grid__label">南兜革命教育基地</p>--%>
        <%--                </a>--%>

        <c:forEach items="${achievementList}" var="achievement">
            <a href="javascript:;" class="weui-grid">
                <div class="weui-grid__icon ${fns:trueOrFalse(achievement.BAD_COUNT > 0,'' , 'weui-grid__gray')}">
                    <img src="${BASE_URL}${Url.IMG_URL}${achievement.IMG_ID}">
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
