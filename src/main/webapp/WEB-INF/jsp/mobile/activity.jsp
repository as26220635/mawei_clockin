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

    .weui-media-box__hd {
        display: flex;
        align-items: center;
    }

    .weui-media-box__hd .weui-media-box__thumb {
        align-items: center;
    }

    .weui-media-box__title {
        white-space: normal;
    }
</style>

<div class="container container-page" id="activityContainer">
    <div class="page__hd">
        <h1 class="page__title">活动信息</h1>
    </div>
    <div class="weui-panel weui-panel_access">
        <div class="weui-panel__bd">
            <c:choose>
                <c:when test="${count eq 0}">
                    <div class="page__bd">
                        <div class="weui-loadmore weui-loadmore_line">
                            <span class="weui-loadmore__tips">暂无数据</span>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div id="itemList">
                        <div id="activityList">
                        </div>

                        <div class="loadmore">
                            <div class="weui-loadmore" id="more">
                                <i class="weui-loading"></i>
                                <span class="weui-loadmore__tips">正在加载</span>
                            </div>
                            <div class="weui-loadmore weui-loadmore_line weui-loadmore_dot" style="display: none;">
                                <span class="weui-loadmore__tips"></span>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<script>
    showBottpmMenu();
    switchTabbar('activityTabbar');
    mainInit.initPjax();
</script>
<script>
    $(function () {
        var loading = false;
        var isLast = false;
        //每页数据条数
        var extraCount = parseInt(document.documentElement.clientHeight / 73);
        extraCount = extraCount <= 10 ? 0 : extraCount - 10;
        var pagesize = 10 + extraCount;
        var page = 0;
        var maxpage = Math.ceil('${count}' / pagesize);
        $('#more').hide();

        function ajaxpage(page) {
            ajax.getMHtml('${BASE_URL}activity/' + pagesize + '/' + page, {}, function () {
                $("#more").show();
            }, function (html) {
                $("#activityList").append(html);
                $("#more").hide();
                if (isLast) {
                    $('.weui-loadmore_dot').show();
                }
                loading = false;
            });
        }

        $('#activityContainer').infinite(100).on("infinite", function () {
            if (loading) return;
            loading = true;
            if (page < (maxpage - 1)) {
                page++;
                if (page == (maxpage - 1)) {
                    isLast = true;
                }
                ajaxpage(page);
            }
        });

        ajaxpage(0);
    });
</script>