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

    .weui-cell__ft {
        font-size: 24px;
        color: #07C160;
    }

    .weui-cell__ft.strong {
        color: #ffc300 !important;
    }

    .weui-avatar-circle {
        width: 40px;
        height: 40px;
    }

    .weui-cell__hd img {
        margin-left: 10px;
        margin-right: 35px;
        width: 40px;
        height: 40px;
    }

    .weui-cell__bd {
        margin-left: 20px;
    }

    .weui-cell__rank {

    }
</style>

<div class="container container-page">
    <div class="page__hd">
        <h1 class="page__title">排行榜</h1>
        <p class="page__desc">只显示前10名</p>
    </div>
    <div class="weui-cells">
        <div class="weui-cell weui-cell_example">
            <div class="weui-cell__rank">
                ${myRank.WECHAT_RANK}
            </div>
            <div class="weui-cell__hd weui-avatar-circle">
                <img src="${myRank.BW_AVATAR}"
                     alt="" style="margin-right:16px;display:block"></div>
            <div class="weui-cell__bd">
                <p>${myRank.BW_USERNAME}</p>
            </div>
            <div class="weui-cell__ft ${fns:trueOrFalse(myRank.WECHAT_RANK <= 3, 'strong' ,'')}">${myRank.CLOCKIN_COUNT}</div>
        </div>
    </div>
    <div class="weui-cells">
        <c:forEach items="${rankList}" var="rank">
            <div class="weui-cell weui-cell_example">
                <div class="weui-cell__rank">
                        ${rank.WECHAT_RANK}
                </div>
                <div class="weui-cell__hd weui-avatar-circle">
                    <img src="${rank.BW_AVATAR}"
                         alt="" style="margin-right:16px;display:block"></div>
                <div class="weui-cell__bd">
                    <p>${rank.BW_USERNAME}</p>
                </div>
                    <%--前三名加粗--%>
                <div class="weui-cell__ft ${fns:trueOrFalse(rank.WECHAT_RANK <= 3, 'strong' ,'')}">${rank.CLOCKIN_COUNT}</div>
            </div>
        </c:forEach>
    </div>
</div>
<script>
    showBottpmMenu();
    switchTabbar('rankTabbar');
    mainInit.initPjax();
</script>
