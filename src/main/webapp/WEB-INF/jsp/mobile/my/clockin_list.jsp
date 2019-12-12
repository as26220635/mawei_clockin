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
    .weui-cell__ft {
        width: 90px;
        font-size: 14px;
    }

    .weui-cells {
        margin-top: 0px !important;
    }

    .container {
        background-color: #ffffff;
    }
</style>

<div id="weuiCellsItems" class="container container-page">
    <%@ include file="/WEB-INF/jsp/mobile/common/common_top.jspf" %>
    <c:choose>
        <c:when test="${clockinCount eq 0}">
            <div class="page__bd">
                <div class="weui-loadmore weui-loadmore_line">
                    <span class="weui-loadmore__tips">暂无数据</span>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div id="itemList" class="weui-cells-items">
                <div class="weui-cells" id="clockinList">
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

<script>
    hideBottpmMenu();
    switchTabbar('myTabbar');
    mainInit.initPjax();
</script>
<script>
    $(function () {
        console.log()
        var loading = false;
        var isLast = false;
        //每页数据条数
        var extraCount = parseInt(document.documentElement.clientHeight / 70);
        extraCount = extraCount <= 10 ? 0 : extraCount - 10;
        var pagesize = 10 + extraCount;
        var page = 0;
        var maxpage = Math.ceil('${clockinCount}' / pagesize);
        $('#more').hide();

        function ajaxpage(page) {
            ajax.getMHtml('${BASE_URL}my/clockin/' + pagesize + '/' + page, {}, function () {
                $("#more").show();
            }, function (html) {
                $("#clockinList").append(html);
                $("#more").hide();
                if (isLast){
                    $('.weui-loadmore_dot').show();
                }
                loading = false;
            });
        }

        $("#weuiCellsItems").infinite(100).on("infinite", function() {
            if(loading) return;
            loading = true;
            if (page < (maxpage - 1)) {
                page++;
                ajaxpage(page);
            } else {
                isLast = true;
                return false;
            }
        });
        ajaxpage(0);
    });
</script>
