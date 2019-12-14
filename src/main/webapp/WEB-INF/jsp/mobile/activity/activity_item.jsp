<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2019/11/26
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<style>
    .weui-cell__ft{
        width: 90px;
        font-size: 14px;
    }
</style>

<div class="container container-page">
    <%@ include file="/WEB-INF/jsp/mobile/common/common_top.jspf" %>
    <div class="weui-content">
        <div class="weui-c-inner">
            <div class="weui-c-content">
                <h2 class="weui-c-title">${activity.BA_TITLE}</h2>
                <div class="weui-c-meta">
<%--                    <span class="weui-c-nickname"><a href="javascript:;">Yoby开发者</a></span>--%>
                    <em class="weui-c-nickname">${activity.BA_ENTRY_TIME}</em>
                </div>
                <div class="weui-c-article">
                    ${activity.BA_CONTENT}
                </div>
            </div>
        </div>

    </div>
</div>
<script>
    hideBottpmMenu();
    switchTabbar('activityTabbar');
    mainInit.initPjax();
</script>
