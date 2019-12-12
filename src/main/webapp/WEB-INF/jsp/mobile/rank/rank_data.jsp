<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2019/11/26
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>

<c:choose>
    <c:when test="${detailList.size() ne 0}">
        <c:forEach items="${detailList}" var="rank">
            <div class="weui-cell weui-cell_example">
                <div class="weui-cell__rank">
                        ${rank.WECHAT_RANK}
                </div>
                <div class="weui-cell__hd weui-avatar-circle">
                    <img src="${rank.BW_AVATAR}"
                         alt="" style="margin-right:16px;display:block"></div>
                <div class="weui-cell__bd">
                    <p>${rank.BW_USERNAME}</p>
                    <div class="weui-cell__desc">
                        <c:forEach items="${rank.IMG_PATHS.split(Attribute.SERVICE_SPLIT)}" var="IMG_PATH">
                            <img class="weui-cell__achievement" src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${IMG_PATH}">
                        </c:forEach>
                    </div>
                </div>
                    <%--前三名加粗--%>
                <div class="weui-cell__ft ${fns:trueOrFalse(rank.WECHAT_RANK <= 3, 'strong' ,'')}">${rank.CLOCKIN_COUNT}
                    <a href="javascript:;" class="paw-button click ${fns:trueOrFalse(rank.isPraise, 'liked confetti' ,'')}" data-id="${rank.ID}">
                        <div class="text">
                            <svg>
                                <use xlink:href="#heart">
                            </svg>
                        </div>
                        <span class="paw-number">${rank.BWP_NUMBER}</span>
                        <div class="paws">
                            <svg class="paw">
                                <use xlink:href="#paw">
                            </svg>
                            <div class="paw-effect">
                                <div></div>
                            </div>
                            <svg class="paw-clap">
                                <use xlink:href="#paw-clap">
                            </svg>
                        </div>
                    </a>
                </div>
            </div>
        </c:forEach>

        <script>
            likedPaw();
        </script>
    </c:when>
    <c:otherwise>
        <div class="page__bd">
            <div class="weui-loadmore weui-loadmore_line">
                <span class="weui-loadmore__tips">暂无数据</span>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<script>
    mainInit.initPjax();
</script>