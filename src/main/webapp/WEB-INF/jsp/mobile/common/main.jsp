<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2017/4/6
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/common_config.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0,">
    <%--    <meta http-equiv="Access-Control-Allow-Origin" content="*" />--%>
    <%--    <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">--%>
    <title>${WEBCONFIG_HEAD_TITLE}</title>
    <%@ include file="/WEB-INF/jsp/mobile/common/common_css.jsp" %>
    <style>
        .container-page {
            overflow-y: scroll;
        }

        .weui-tabbar__icon {
            height: 52px;
            width: 52px;
        }

        .weui-bar__item_on {
            /* Chrome, Safari, Opera */
            -webkit-filter: drop-shadow(0px 2px 1px #09C161);
            filter: drop-shadow(0px 2px 1px #09C161);
        }

        .weui-tab__container {
            height: 92%;
        }

        @media screen and (min-width: 600px) and (max-width: 960px) {
            .weui-tab__container {
                height: 94%;
            }
        }

        @media screen and (min-width: 960px) {
            .weui-tab__container {
                height: 95%;
            }
        }

        @media screen and (max-width: 330px) {
            .weui-tab__container {
                height: 88%;
            }
        }

        .weui-dialog {
            -webkit-transform: translate(0%, -50%);
            transform: translate(0%, -50%);
            margin: auto !important;
        }

        .weui-grid__gray {
            -webkit-filter: grayscale(100%);
            -moz-filter: grayscale(100%);
            -ms-filter: grayscale(100%);
            -o-filter: grayscale(100%);
            filter: grayscale(100%);
            filter: gray;
        }
        .weui-tabbar__disabled{
            pointer-events: none;
        }

        .weui-tabbar__disabled a{
            pointer-events: none;
        }
    </style>
    <script>
        //是否定位
        var isLocate = false;
    </script>
</head>
<body>
<div class="page tabbar js_show">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-tab__panel weui-tab__container" id="${CONTAINER}" style="height: 92%;">

            </div>
            <div class="weui-tabbar" id="tabbar">
                <c:if test="${bottomMenuConfig.MOBILE_BOTTOM_MENU_CLOCKIN ne Attribute.STATUS_ERROR}">
                    <a id="clockinTabbar" href="${BASE_URL}clockin" class="weui-tabbar__item weui-bar__item_on"
                       data-pjax="#${CONTAINER}">
                        <img src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${bottomMenuConfig.MOBILE_BOTTOM_MENU_CLOCKIN_ICON}"
                             class="weui-tabbar__icon">
                    </a>
                </c:if>
                <c:if test="${bottomMenuConfig.MOBILE_BOTTOM_MENU_ACTIVITY ne Attribute.STATUS_ERROR}">
                    <a id="activityTabbar" href="${BASE_URL}activity" class="weui-tabbar__item"
                       data-pjax="#${CONTAINER}">
                        <img src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${bottomMenuConfig.MOBILE_BOTTOM_MENU_ACTIVITY_ICON}"
                             class="weui-tabbar__icon">
                    </a>
                </c:if>
                <c:if test="${bottomMenuConfig.MOBILE_BOTTOM_MENU_RANK ne Attribute.STATUS_ERROR}">
                    <a id="rankTabbar" href="${BASE_URL}rank" class="weui-tabbar__item" data-pjax="#${CONTAINER}">
                        <img src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${bottomMenuConfig.MOBILE_BOTTOM_MENU_RANK_ICON}"
                             class="weui-tabbar__icon">
                    </a>
                </c:if>
                <c:if test="${bottomMenuConfig.MOBILE_BOTTOM_MENU_ACHIEVEMENT ne Attribute.STATUS_ERROR}">
                    <a id="achievementTabbar" href="${BASE_URL}achievement" class="weui-tabbar__item"
                       data-pjax="#${CONTAINER}">
                        <img src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${bottomMenuConfig.MOBILE_BOTTOM_MENU_ACHIEVEMENT_ICON}"
                             class="weui-tabbar__icon">
                    </a>
                </c:if>
                <c:if test="${bottomMenuConfig.MOBILE_BOTTOM_MENU_MY ne Attribute.STATUS_ERROR}">
                    <a id="myTabbar" href="${BASE_URL}my" class="weui-tabbar__item" data-pjax="#${CONTAINER}">
                        <img src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${bottomMenuConfig.MOBILE_BOTTOM_MENU_MY_ICON}"
                             class="weui-tabbar__icon">
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</div>

<%--<%@ include file="/WEB-INF/jsp/common/common_params.jsp" %>--%>
<%@ include file="/WEB-INF/jsp/mobile/common/common_bottom.jsp" %>
<script type="text/javascript">
    var SERVICE_SPLIT = ',';

    mainInit.initPjax();
    // 加载内容到指定容器
    $.pjax({url: this.href, container: '#${CONTAINER}', replace: true});

    $(document).on('pjax:click', function (options) {
        $('#tabbar').addClass('weui-tabbar__disabled');
        isLocate = false;
        removeMap();
    })

    //pjax完成回调后的操作
    $(document).on('ready pjax:end', function (event) {
        //pjax
        mainInit.initPjax();
        $('#tabbar').removeClass('weui-tabbar__disabled');
    });

    $('.weui-tabbar__item').on('click', function () {
        $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
    });

    function showBottpmMenu() {
        $('.weui-tabbar').fadeIn();
        $('#${CONTAINER}').css('height', '').addClass('weui-tab__container')
        $('.container-page').css('height', '').addClass('weui-tab__container')
    }

    function hideBottpmMenu() {
        $('.weui-tabbar').fadeOut();
        $('#${CONTAINER}').css('height', '100%').removeClass('weui-tab__container');
        $('.container-page').css('height', '100%').removeClass('weui-tab__container');
    }

    function switchTabbar(id) {
        $('#' + id).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
    }

    function goHome() {
        loadUrl('${BASE_URL}clockin');
    }

    //后退
    function backHtml() {
        window.history.back();
    }

    //pjax加载
    function loadUrl(url) {
        $.pjax({url: url, container: '#${CONTAINER}'});
    }

    function removeMap() {
        $("script[src^='https://api.map.baidu.com/']").remove();
        $("iframe[src^='https://api.map.baidu.com/res/staticPages/location.html']").remove();
    }
</script>
<script>
    let confettiAmount = 60,
        confettiColors = [
            '#7d32f5',
            '#f6e434',
            '#63fdf1',
            '#e672da',
            '#295dfe',
            '#6e57ff'
        ],
        random = (min, max) => {
            return Math.floor(Math.random() * (max - min + 1) + min);
        },
        createConfetti = to => {
            let elem = document.createElement('i'),
                set = Math.random() < 0.5 ? -1 : 1;
            elem.style.setProperty('--x', random(-260, 260) + 'px');
            elem.style.setProperty('--y', random(-160, 160) + 'px');
            elem.style.setProperty('--r', random(0, 360) + 'deg');
            elem.style.setProperty('--s', random(.6, 1));
            elem.style.setProperty('--b', confettiColors[random(0, 5)]);
            to.appendChild(elem);
        };
</script>
<script>
    function weixinShare(title, desc, link, imgUrl, success, cancel) {
        // 登录微信jssdk
        ajax.get('${BASE_URL}JSSDKConfig', {url: location.href.split('#')[0]}, function (data) {
            if (data.code == 1) {
                var message = $.parseJSON(data.message);

                wx.config({
                    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: message.appId, // 必填，公众号的唯一标识
                    timestamp: message.timestamp, // 必填，生成签名的时间戳
                    nonceStr: message.nonceStr, // 必填，生成签名的随机串
                    signature: message.signature,// 必填，签名
                    jsApiList: [
                        'updateAppMessageShareData',
                        'updateTimelineShareData',
                        'onMenuShareAppMessage',
                        'onMenuShareTimeline',
                    ] // 必填，需要使用的JS接口列表
                });

                wx.ready(function () {
                    var defaults = {
                        //标题
                        title: title,
                        //描述
                        desc: desc,
                        //分享页面地址,不能为空，这里可以传递参数！！！！！！！
                        link: link,
                        //分享是封面图片，不能为空
                        imgUrl: imgUrl,
                        success: success,
                        cancel: cancel,
                    }

                    // if (wx.updateAppMessageShareData) {
                    //     wx.updateAppMessageShareData({
                    //         title: defaults.title,
                    //         desc: defaults.desc,
                    //         link: defaults.link,
                    //         imgUrl: defaults.imgUrl,
                    //         success: function () {
                    //             defaults.success();
                    //         },
                    //         cancel: function () {
                    //             defaults.cancel();
                    //         }
                    //     });
                    // } else {
                        wx.onMenuShareAppMessage({
                            title: defaults.title,
                            desc: defaults.desc,
                            link: defaults.link,
                            imgUrl: defaults.imgUrl,
                            type: '', // 分享类型,music、video或link，不填默认为link
                            dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
                            success: function () {
                                defaults.success();
                            },
                            cancel: function () {
                                defaults.cancel();
                            }
                        });
                    // }
                    //分享给朋友圈
                    // if (wx.updateTimelineShareData) {
                    //     wx.updateTimelineShareData({
                    //         title: defaults.title,
                    //         link: defaults.link,
                    //         imgUrl: defaults.imgUrl,
                    //         success: function () {
                    //             defaults.success();
                    //         },
                    //         cancel: function () {
                    //             defaults.cancel();
                    //         }
                    //     });
                    // } else {
                        wx.onMenuShareTimeline({
                            title: defaults.title,
                            link: defaults.link,
                            imgUrl: defaults.imgUrl,
                            success: function () {
                                defaults.success();
                            },
                            cancel: function () {
                                defaults.cancel();
                            }
                        });
                    // }

                });
            } else {
                $.toast("JSSDK登录失败", "forbidden");
            }
        });
    }
</script>
</body>
</html>
