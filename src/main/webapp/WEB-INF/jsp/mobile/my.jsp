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
    .weui-icon-home {
        width: 100%;
        height: 140px;
        margin-top: 0px;
    }

    .weui-icon-home .weui-avatar {
        top: calc(20%);
        width: 100%;
        text-align: center;
    }

    .weui-icon-home img {
        width: 60px;
        height: 60px;
    }

    #iconName {
        margin-top: 10px;
        font-size: 20px;
    }
</style>

<div class="container container-page">
    <div class="weui-cells weui-icon-home">
        <div class="weui-avatar">
            <img src="${wechatUser.avatar}">
            <div id="iconName">${wechatUser.username}</div>
<%--            <img src="${BASE_URL}resources/assets/images/main/map.jpg">--%>
<%--            <div id="iconName">as26220635</div>--%>
        </div>
    </div>
    <div class="weui-cells">
        <a class="weui-cell weui-cell_access" href="${BASE_URL}my/clockin" data-pjax="#${CONTAINER}">
            <div class="weui-cell__bd">
                <p>打卡记录</p>
            </div>
            <div class="weui-cell__ft">
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="javascript:;">
            <div class="weui-cell__bd">
                <p>联系客服</p>
            </div>
            <div class="weui-cell__ft">
            </div>
        </a>
    </div>
</div>
<script>
    showBottpmMenu();
    switchTabbar('myTabbar');
    mainInit.initPjax();
</script>
