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
    .weui-form {
        padding-top: 0px;
    }

    .weui-gallery {
        height: 100%;
    }

    .weui-gallery__img {
        width: 100%;
        height: 100%;
    }

    .weui-video {
        height: auto;
        width: 50%;
        display: none;
    }

    .weui-uploader__file img {
        width: 100%;
        height: 100%;
    }

    .weui-form__opr-area {
        margin-top: 30px;
    }

    .weui-form__date{
        font-size: 14px;
        color: rgba(0,0,0,.5);
    }
</style>
<div id="weuiCellsItems" class="container container-page">
    <%@ include file="/WEB-INF/jsp/mobile/common/common_top.jspf" %>
    <div class="weui-form">
        <div class="weui-form__text-area">
            <h2 class="weui-form__title">打卡地点:</h2>
            <div class="weui-form__desc">${detail.BAD_ADDRESS}
                <div class="weui-form__date">${detail.BAD_ENTERTIME}</div>
            </div>
        </div>
        <div class="weui-form__control-area">
            <div class="weui-cells__group weui-cells__group_form">
                <div class="weui-cells__title">概述</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            ${detail.BAD_REMARKS}
                        </div>
                    </div>
                </div>
            </div>

            <c:choose>
                <c:when test="${detail.BAD_FILETYPE eq 1}">
                    <!--图片-->
                    <div class="weui-cells__group">
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <div class="weui-uploader">
                                    <div class="weui-uploader__hd">
                                        <p class="weui-uploader__title">图片</p>
                                    </div>
                                    <div class="weui-uploader__bd">
                                        <ul class="weui-uploader__files" id="uploader_files">
                                            <c:forEach items="${fileIds}" var="FILE_ID">
                                                <li class="weui-uploader__file">
                                                    <img src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${FILE_ID}">
                                                </li>
                                                <%--                                                <li id="" class="weui-uploader__file"--%>
                                                <%--                                                    style="background-image:url(${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${FILE_ID})">--%>
                                                <%--                                                    <input type="hidden"--%>
                                                <%--                                                           value="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${FILE_ID}"/>--%>
                                                <%--                                                </li>--%>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:when test="${detail.BAD_FILETYPE eq 2}">
                    <!--视频-->
                    <div class="weui-cells__group">
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <div class="weui-uploader">
                                    <div class="weui-uploader__hd">
                                        <p class="weui-uploader__title">视频</p>
                                    </div>
                                    <div class="weui-uploader__bd">
                                        <div id="dplayer"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </c:when>
            </c:choose>

            <div class="weui-form__opr-area">
                <button class="weui-btn weui-btn_warn" href="javascript:" id="deleteBtn">删除</button>
            </div>
        </div>
    </div>
</div>

<script>
    hideBottpmMenu();
    switchTabbar('myTabbar');
    mainInit.initPjax();
    $('#deleteBtn').unbind('click').on('click', function () {
        $.confirm("您确定要删除吗?", "确认删除?", function () {
            $.showLoading('删除中');
            ajax.del('${BASE_URL}my/clockin/delete/${detail.ID}', {}, function (data) {
                $.hideLoading();
                if (data.code == 1) {
                    $.toast('删除成功', 2000, function () {
                        backHtml();
                    });
                } else {
                    $.toast("删除失败", "forbidden");
                }
            });
        }, function () {
        });
    })
</script>
<c:choose>
    <c:when test="${detail.BAD_FILETYPE eq 1}">
        <script>
            $('#uploader_files').viewer({
                fullscreen: false
            });
        </script>
    </c:when>
    <c:when test="${detail.BAD_FILETYPE eq 2}">
        <script>
            var dp = new DPlayer({
                container: document.getElementById('dplayer'),
                loop: true,
                video: {
                    url: '${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PLAYER_URL}${detail.FILE_PATH}',
                    pic: '${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${detail.FILE_PATH_THUMBNAILS}',
                    thumbnails: '${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${detail.FILE_PATH_THUMBNAILS}'
                }
            });
            $('#dplayer').one('click', function () {
                dp.play();
            })
        </script>
    </c:when>
</c:choose>