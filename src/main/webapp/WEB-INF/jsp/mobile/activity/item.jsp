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
    .weui-cell__ft{
        width: 90px;
        font-size: 14px;
    }
</style>

<div class="container container-page">
    <%@ include file="/WEB-INF/jsp/mobile/common/common_top.jspf" %>
    <div class="weui-content">
        <div class="weui-c-inner">
            <div class="weui-c-content">
                <h2 class="weui-c-title">Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面</h2>
                <div class="weui-c-meta">
                    <span class="weui-c-nickname"><a href="javascript:;">Yoby开发者</a></span>
                    <em class="weui-c-nickname">2018-10-10 10:10</em>
                </div>
                <div class="weui-c-article">
                    <p> Flutter是谷歌的移动UI框架 [4]  ，可以快速在iOS和Android上构建高质量的原生用户界面。 Flutter可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。它也是构建未来的Google Fuchsia [1]  应用的主要方式。</p>
                    <p>
                        Flutter组件采用现代响应式框架构建，这是从React中获得的灵感，中心思想是用组件(widget)构建你的UI。 组件描述了在给定其当前配置和状态时他们显示的样子。当组件状态改变，组件会重构它的描述(description)，Flutter会对比之前的描述， 以确定底层渲染树从当前状态转换到下一个状态所需要的最小更改。
                    </p>
                    <p>Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面。 Flutter可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。</p>

                </div>
            </div>
        </div>

    </div>
</div>
<script>
    hideBottpmMenu();
    switchTabbar('activityTabbar');
    mainInit.initPjax();
</script>
