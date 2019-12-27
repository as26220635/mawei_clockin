<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2019/11/26
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>

<input type="hidden" id="rankTotal" value="${total}">
<c:choose>
    <c:when test="${detailList.size() ne 0}">
        <c:forEach items="${detailList}" var="rank">
            <div class="weui-cell weui-cell_example">
                <div class="weui-cell__rank">
                        ${rank.BWR_RANK}
                </div>
                <div class="weui-cell__hd weui-avatar-circle">
                    <img src="${rank.BW_AVATAR}"
                         alt="" style="margin-right:16px;display:block"></div>
                <div class="weui-cell__bd">
                    <p>${rank.BW_USERNAME}</p>
                    <div class="weui-cell__desc">
                        <c:if test="${not empty rank.BWR_LIGHT_ICON}">
                            <c:forEach items="${rank.BWR_LIGHT_ICON.split(Attribute.SERVICE_SPLIT)}" var="IMG_PATH"  varStatus="status">
                                <img class="weui-cell__achievement ${fns:trueOrFalse(rank.iconStatusList.get(status.index) eq 0,'weui-grid__gray' ,'' )}"
                                     src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${IMG_PATH}">
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
                    <%--前三名加粗--%>
                <div class="weui-cell__ft ${fns:trueOrFalse(rank.BWR_RANK <= 3, 'strong' ,'')}">
                    <span>${rank.BWR_CLOCKIN_COUNT}</span>
                    <a href="javascript:;" class="paw-button click ${fns:trueOrFalse(rank.isPraise, 'liked confetti' ,'')}" data-id="${rank.BW_ID}">
                        <div class="text">
                            <span class="paw-number">${rank.BWP_NUMBER}</span>
                            <svg>
                                <use xlink:href="#heart">
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