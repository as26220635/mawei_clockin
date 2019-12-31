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
    .share-img {
        width: 100%;
        height: auto;
    }

    .weui-msg__share {
        padding: 0 !important;
        margin: 0 !important;
    }

    .weui-msg{
        padding: 0;
    }

    #shareBtn{
        width: 55px;
        height: 55px;
        padding: 18px 12px;
        margin: 5px;
        font-size: 15px;
        -moz-border-radius: 50px;
        -webkit-border-radius: 50px;
        border-radius: 50px;
        position: fixed;
        bottom: 5%;
        right: 5%;
        z-index: 888;
        box-shadow: 2px 2px 2px #888888;
    }
    #shareBtn:active{
        background-color: #069746;
    }
</style>

<div class="container container-page">
    <%@ include file="/WEB-INF/jsp/mobile/common/common_top.jspf" %>
<%--        <c:choose>--%>
<%--            <c:when test="${action eq 1}">--%>
<%--                <div class="weui-msg__icon-area"><i class="weui-icon-success weui-icon_msg"></i></div>--%>
<%--                <div class="weui-msg__text-area">--%>
<%--                    <h2 class="weui-msg__title">打卡成功</h2>--%>
<%--                    <p class="weui-msg__desc">--%>
<%--                        <img class="share-img"--%>
<%--                             src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${IMG_PATH}">--%>
<%--                    </p>--%>
<%--                </div>--%>
<%--            </c:when>--%>
<%--            <c:otherwise>--%>
<%--                <img class="share-img" src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${IMG_PATH}">--%>
<%--            </c:otherwise>--%>
<%--        </c:choose>--%>

        <img class="share-img" src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${IMG_PATH}">

<%--        <a href="javascript:;" class="weui-btn weui-btn_primary" id="shareBtn">分享</a>--%>
</div>
<script>
    hideBottpmMenu();
    switchTabbar('achievementTabbar');
    mainInit.initPjax();
</script>
<script>
    console.log('${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${IMG_PATH_THUMBNAIL}')
    $('#shareBtn').unbind('click').on('click', function () {
        var sharetpl = '<div class="weui-share" onclick="$(this).remove();">\n' +
            '<div class="weui-share-box">\n' +
            '点击右上角发送给指定朋友或分享到朋友圈 <i></i>\n' +
            '</div>\n' +
            '</div>';
        var sharetpl = $.t7.compile(sharetpl);
        $("body").append(sharetpl());
    });

    var defaults = {
        //标题
        title: '红色领航  青春打卡',
        //描述
        desc: '快来一起加入我们吧～',
        //分享页面地址,不能为空，这里可以传递参数！！！！！！！
        link: '${WebConfig.WEBCONFIG_SERVER_URL}/share/${shareFeedbackParam}',
        //分享是封面图片，不能为空
        imgUrl: '${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${IMG_PATH_THUMBNAIL}',
        success: function () {
            //分享成功触发
            $('.weui-share').remove();
            // $.toast("分享成功");
        },
        cancel: function () {
            //分享取消触发，需要时可以调用
            $('.weui-share').remove();
        }
    }
    //调用分享
    weixinShare(defaults.title, defaults.desc, defaults.link, defaults.imgUrl, defaults.success, defaults.cancel);
</script>
