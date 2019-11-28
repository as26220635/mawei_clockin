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
</style>

<div class="container container-page">
    <%@ include file="/WEB-INF/jsp/mobile/common/common_top.jspf" %>

    <div class="weui-cells">
        <a class="weui-cell weui-cell_access" href="javascript:;">
            <div class="weui-cell__bd">
                <p>地点1阿萨是的撒的阿萨是的撒的阿萨是的撒的打卡</p>
            </div>
            <div class="weui-cell__ft">2019-11-27 14:13:37</div>
        </a>
        <a class="weui-cell weui-cell_access" href="javascript:;">
            <div class="weui-cell__bd">
                <p>地点2打卡</p>
            </div>
            <div class="weui-cell__ft">2019-11-27 14:13:37</div>
        </a>
    </div>
</div>
<script>
    hideBottpmMenu();
    switchTabbar('myTabbar');
    mainInit.initPjax();
</script>
