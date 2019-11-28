<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2017/4/6
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <title>${HEAD_TITLE}</title>
    <%@ include file="/WEB-INF/jsp/mobile/common/common_css.jsp" %>
    <style>
        .container-page {
            overflow-y: scroll;
        }

        .weui-tabbar__icon {
            height: 42px;
            width: 55px;
        }

        .weui-bar__item_on {
            /* Chrome, Safari, Opera */
            -webkit-filter: drop-shadow(0px 2px 1px #09C161);
            filter: drop-shadow(0px 2px 1px #09C161);
        }
    </style>
</head>
<body>
<div class="page tabbar js_show">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-tab__panel" id="${CONTAINER}" style="height: 92%;">

            </div>
            <div class="weui-tabbar">
                <a id="clockinTabbar" href="${BASE_URL}clockin" class="weui-tabbar__item weui-bar__item_on"
                   data-pjax="#${CONTAINER}">
                    <img src="${BASE_URL}resources/assets/images/main/clockin.png" alt="" class="weui-tabbar__icon">
                </a>
                <%--                <a id="activityTabbar" href="${BASE_URL}activity" class="weui-tabbar__item" data-pjax="#${CONTAINER}">--%>
                <%--                    <img src="${BASE_URL}resources/assets/images/main/activity.png" alt="" class="weui-tabbar__icon">--%>
                <%--                </a>--%>
                <%--                <a id="rankTabbar" href="${BASE_URL}rank" class="weui-tabbar__item" data-pjax="#${CONTAINER}">--%>
                <%--                    <img src="${BASE_URL}resources/assets/images/main/rank.png" alt="" class="weui-tabbar__icon">--%>
                <%--                </a>--%>
                <a id="achievementTabbar" href="${BASE_URL}achievement" class="weui-tabbar__item"
                   data-pjax="#${CONTAINER}">
                    <img src="${BASE_URL}resources/assets/images/main/achievement.png" alt="" class="weui-tabbar__icon">
                </a>
                <a id="myTabbar" href="${BASE_URL}my" class="weui-tabbar__item" data-pjax="#${CONTAINER}">
                    <img src="${BASE_URL}resources/assets/images/main/my.png" alt="" class="weui-tabbar__icon">
                </a>
            </div>
        </div>
    </div>
</div>

<%--<%@ include file="/WEB-INF/jsp/common/common_params.jsp" %>--%>
<%@ include file="/WEB-INF/jsp/mobile/common/common_bottom.jsp" %>
<script type="text/javascript">
    mainInit.initPjax();
    // 加载内容到指定容器
    $.pjax({url: this.href, container: '#${CONTAINER}', replace: true});

    //pjax完成回调后的操作
    $(document).on('ready pjax:end', function (event) {
        //pjax
        mainInit.initPjax();
    });

    $('.weui-tabbar__item').on('click', function () {
        $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
    });

    function showBottpmMenu() {
        $('.weui-tabbar').fadeIn();
        $('#${CONTAINER}').css('height', '92%');
        $('.container-page').css('height', '92%');
    }

    function hideBottpmMenu() {
        $('.weui-tabbar').fadeOut();
        $('#${CONTAINER}').css('height', '100%');
        $('.container-page').css('height', '100%');
    }

    function switchTabbar(id) {
        $('#' + id).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
    }

    //后退
    function backHtml() {
        window.history.back();
    }

    //pjax加载
    function loadUrl(url) {
        $.pjax({url: url, container: '#${CONTAINER}'});
    }
</script>
</body>
</html>
