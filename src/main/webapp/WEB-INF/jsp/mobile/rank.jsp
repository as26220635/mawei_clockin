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

    .weui-cell__ft {
        font-size: 24px;
        color: #07C160;
        height: 35px;
        padding-top: 5px;
    }

    .weui-cell__ft.strong {
        color: #ffc300 !important;
    }

    .weui-avatar-circle {
        width: 40px;
        height: 40px;
    }

    .weui-cell__hd img {
        margin-left: 10px;
        margin-right: 35px;
        width: 40px;
        height: 40px;
    }

    .weui-cell__bd {
        margin-left: 20px;
    }

    .weui-cell__rank {
        min-width: 20px;
    }

    .weui-search-bar {
        background-color: #ffffff;
    }

    .weui-cell__desc {
        font-size: 13px;
        color: rgba(0, 0, 0, .5);
    }

    .weui-cell__desc {
        width: 140px;
    }

    .weui-cell__achievement {
        width: 20px;
        height: 20px;
    }

    .weui-search-bar__search-btn {
        display: none;
        margin-left: 8px;
        line-height: 28px;
        color: #576B95;
        white-space: nowrap;
    }
</style>
<style>
    .paw-button {
        /*height: 100%;*/
        text-align: center;
        width: 35px;
        top: -13px;
        --background: #8a8a8a;
        --background-active: #FB5C5C;
        --background-in: #8a8a8a;
        --background-in-active: #FB5C5C;
        display: inline-flex;
        text-decoration: none;
        font-weight: bold;
        position: relative;
        line-height: 19px;
        /*padding: 3px 0px;*/
        margin-left: 7px;
        z-index: 50;
    }

    .paw-button:before {
        content: '';
        position: absolute;
        display: block;
        left: -2px;
        top: -2px;
        bottom: -2px;
        right: -2px;
        z-index: 1;
        border-radius: 5px;
        transition: background .45s, border-color .45s;
        /*background: var(--background);*/
        border: 2px solid var(--border);
    }

    .paw-button svg {
        display: block;
        margin: auto;
    }

    .paw-button .text {
        position: relative;
        z-index: 3;
        margin: auto;
    }

    .paw-button .text span,
    .paw-button .text svg {
    }

    .paw-button .text span {
        display: block;
        position: absolute;
        left: 30px;
        top: 0;
        color: #8a8a8a;
        display: contents;
    }

    .paw-button .text svg {
        /*--background: var(--heart-background);*/
        /*--border: var(--heart-border);*/
        --shadow-light: transparent;
        --shadow-dark: transparent;
        width: 20px;
        height: 20px;
        padding-left: 3px;
    }

    .paw-button > span {
        display: block;
        position: relative;
        z-index: 2;
        color: var(--number);
    }

    .paw-button .paws {
        overflow: hidden;
        position: absolute;
        left: 0;
        right: 0;
        bottom: 0;
        height: 60px;
        z-index: 2;
    }

    .paw-button .paws svg {
        position: absolute;
        bottom: 0;
    }

    .paw-button i {
        position: absolute;
        display: block;
        width: 4px;
        height: 4px;
        top: 50%;
        left: 50%;
        margin: -2px 0 0 -2px;
        opacity: var(--o, 0);
        background: var(--b);
        -webkit-transform: translate(var(--x), var(--y)) scale(var(--s, 1));
        transform: translate(var(--x), var(--y)) scale(var(--s, 1));
    }

    .paw-button:not(.confetti):hover .text {
        --o: 0;
        --x: 12px;
        --y: 8px;
    }

    .paw-button:not(.confetti):hover .paws svg.paw {
        --o: 1;
        --x: 0;
    }

    .paw-button.confetti i {
        -webkit-animation: confetti .6s ease-out forwards;
        animation: confetti .6s ease-out forwards;
    }

    .paw-number {
        font-size: 12px;
    }

    .paw-button.liked {
        --background: var(--background-active);
    }

    .paw-button.animation .text svg {
        --background: var(--background-active);
    }

    @-webkit-keyframes confetti {
        from {
            -webkit-transform: translate(0, 0);
            transform: translate(0, 0);
            opacity: 1;
        }
    }

    @keyframes confetti {
        from {
            -webkit-transform: translate(0, 0);
            transform: translate(0, 0);
            opacity: 1;
        }
    }
</style>
<div class="container container-page" id="rankContainer">
    <div class="page__hd">
        <h1 class="page__title">排行榜</h1>
        <p class="page__desc">
<%--            排名每10分钟更新--%>
            <c:if test="${not empty updateDate}">
                更新时间:${updateDate}
            </c:if>
        </p>
    </div>
    <div class="weui-cells">
        <div class="weui-search-bar" id="searchBar">
            <form class="weui-search-bar__form">
                <div class="weui-search-bar__box">
                    <i class="weui-icon-search"></i>
                    <input type="search" class="weui-search-bar__input" id="searchInput" placeholder="搜索" required="">
                    <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
                </div>
                <label class="weui-search-bar__label" id="searchText"
                       style="transform-origin: 0px 0px; opacity: 1; transform: scale(1, 1);">
                    <i class="weui-icon-search"></i>
                    <span>搜索</span>
                </label>
            </form>
            <a href="javascript:" class="weui-search-bar__search-btn" id="searchBtn">搜索</a>
        </div>

        <div class="weui-cell weui-cell_example">
            <div class="weui-cell__rank">
                ${myRank.BWR_RANK}
            </div>
            <div class="weui-cell__hd weui-avatar-circle">
                <img src="${myRank.BW_AVATAR}"
                     alt="" style="margin-right:16px;display:block"></div>
            <div class="weui-cell__bd">
                <p>${myRank.BW_USERNAME}</p>
                <div class="weui-cell__desc">
                    <c:if test="${not empty myRank.BWR_LIGHT_ICON}">
                        <c:forEach items="${myRank.BWR_LIGHT_ICON.split(Attribute.SERVICE_SPLIT)}" var="IMG_PATH" varStatus="status">
                            <img class="weui-cell__achievement ${fns:trueOrFalse(myRank.iconStatusList.get(status.index) eq 0,'weui-grid__gray' ,'' )}"
                                 src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${IMG_PATH}">
                        </c:forEach>
                    </c:if>
                </div>
            </div>
            <div class="weui-cell__ft ${fns:trueOrFalse(myRank.BWR_RANK <= 3, 'strong' ,'')}">${myRank.BWR_CLOCKIN_COUNT}
                <a href="javascript:;" class="paw-button">
                    <div class="text">
                        <span class="paw-number">${myRank.BWP_NUMBER}</span>
                        <svg>
                            <use xlink:href="#heart">
                        </svg>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <div class="weui-cells">
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
                    <div id="rankList">
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

<!-- Symbols -->
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
    <symbol class="icon" viewBox="0 0 1170 1024" version="1.1" p-id="1260"  width="228.515625" height="200" id="heart">
        <defs>
            <style type="text/css"></style>
        </defs>
        <path d="M32 407.584a279.584 279.584 0 0 1 480-194.944 279.584 279.584 0 0 1 480 194.944 278.144 278.144 0 0 1-113.024 224.512L562.592 892.8a96 96 0 0 1-124.416-1.952l-308.16-270.688A278.976 278.976 0 0 1 32 407.584z"
              p-id="3404" fill="var(--background)"></path>
    </symbol>
</svg>

<script>
    showBottpmMenu();
    switchTabbar('rankTabbar');
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
            ajax.getMHtml('${BASE_URL}rank/' + pagesize + '/' + page, {
                BW_USERNAME: $('#searchInput').val()
            }, function () {
                $("#more").show();
            }, function (html) {
                $("#rankList").append(html);
                $("#more").hide();
                if (isLast) {
                    $('.weui-loadmore_dot').show();
                }
                let $rankTotal = $('#rankTotal');
                maxpage = Math.ceil($rankTotal.val() / pagesize);
                $rankTotal.remove();
                loading = false;
            });
        }

        $('#rankContainer').infinite(100).on("infinite", function () {
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

        $('#searchBar').on('click', function () {
            $('#searchBtn').show();
        });

        $('#searchBtn').on('click', function () {
            page = 0;
            isLast = false;
            $('.weui-loadmore_dot').hide();
            $('#rankList').empty();
            ajaxpage(0);
        });

        $('#searchInput').on('keydown', function (e) {
            if (e.keyCode == 13) {
                page = 0;
                isLast = false;
                $('.weui-loadmore_dot').hide();
                $('#rankList').empty();
                ajaxpage(0);
                e.preventDefault()
            }
        });

        ajaxpage(0);
    });
</script>
<script>
    function likedPaw() {
        document.querySelectorAll('.paw-button.click').forEach(elem => {
            var toId = $(elem).attr('data-id');
            if (toId == '${wechatUser.id}') {
                $(elem).removeClass('click');
            } else {
                $(elem).unbind('click').on('click',function (e) {
                    $(elem).css("pointer-events", "none");

                    let $number = $($(elem).find('.paw-number')[0]);
                    let number = $number.text();
                    if (!elem.classList.contains('liked')) {
                        elem.classList.add('animation');
                        for (let i = 0; i < confettiAmount; i++) {
                            createConfetti(elem);
                        }
                        elem.classList.add('confetti');
                        // $.showLoading('加载中');
                        elem.classList.add('liked');
                        $number.text(parseInt(number) + 1);
                        submitPraisePoint('${wechatUser.id}', toId, 1, elem);
                        setTimeout(() => {
                            elem.querySelectorAll('i').forEach(i => i.remove());
                        }, 600);
                    } else {
                        // $.showLoading('加载中');
                        elem.classList.remove('animation', 'liked', 'confetti');
                        $number.text(parseInt(number) - 1);
                        submitPraisePoint('${wechatUser.id}', toId, 0, elem);
                    }
                    e.preventDefault();
                });
            }
        });
    }

    /**
     * 点赞或取消
     * @param fromId
     * @param toId
     * @param action
     * @param elem
     */
    function submitPraisePoint(fromId, toId, action, elem) {
        ajax.post('${BASE_URL}rank/praise/' + fromId + '/' + toId + '/' + action, {}, function (data) {
            $(elem).css("pointer-events", "auto");
            if (data.code != 1) {
                if (action == 1) {
                    elem.classList.remove('animation', 'liked', 'confetti');
                    elem.children[1].textContent = parseInt(elem.children[1].textContent) - 1;
                } else {
                    elem.classList.add('liked', 'confetti');
                    elem.children[1].textContent = parseInt(elem.children[1].textContent) + 1;
                }
                // $.hideLoading();
                $.toast(data.message != null ? data.message : "点赞失败", "forbidden");
            } else {
                // $.hideLoading();
            }
        });
    }
</script>