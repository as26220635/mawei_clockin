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

</style>

<div class="container container-page">
    <%@ include file="/WEB-INF/jsp/mobile/common/common_top.jspf" %>
    <div class="weui-msg">
        <c:choose>
            <c:when test="${action eq 1}">
                <div class="weui-msg__icon-area"><i class="weui-icon-success weui-icon_msg"></i></div>
                <div class="weui-msg__text-area">
                    <h2 class="weui-msg__title">打卡成功</h2>
                    <p class="weui-msg__desc">
                        <img class="share-img"
                             src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${IMG_PATH}">
                    </p>
                </div>
            </c:when>
            <c:otherwise>
                <img class="share-img" src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${IMG_PATH}">
            </c:otherwise>
        </c:choose>
        <div class="weui-msg__opr-area">
            <p class="weui-btn-area">
                <a href="javascript:;" class="weui-btn weui-btn_primary" id="shareBtn">分享</a>
            </p>
        </div>
    </div>
</div>
<script>
    hideBottpmMenu();
    switchTabbar('achievementTabbar');
    mainInit.initPjax();
</script>
<script>
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
        title: '${WEBCONFIG_HEAD_TITLE}',
        //描述
        desc: '打卡位置:${achievement.BA_NAME}',
        //分享页面地址,不能为空，这里可以传递参数！！！！！！！
        link: '${WebConfig.WEBCONFIG_SERVER_URL}/share/${shareFeedbackParam}',
        //分享是封面图片，不能为空
        imgUrl: '${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${IMG_PATH}',
        success: function () {
            //分享成功触发
            $('.weui-share').remove();
            $.toast("分享成功");
        },
        cancel: function () {
            //分享取消触发，需要时可以调用
            $('.weui-share').remove();
        }
    }

    //调用分享
    weixinShare(defaults.title, defaults.desc, defaults.link, defaults.imgUrl, defaults.success, defaults.cancel);
</script>
