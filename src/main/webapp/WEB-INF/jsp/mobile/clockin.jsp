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
    #clockinArea {
        z-index: 1000;
        position: relative;
        /*height: calc(50% - 30px);*/
        /*height: 250px;*/
        background-color: #ffffff;
        text-align: center;
        box-shadow: 0px 1px 30px rgba(136, 136, 136, 0.7);
    }

    #clockinAreaImg {
        /*width: auto;*/
        /*max-width: 100%;*/
        /*height: 253px;*/
        /*height: calc(100% - 30px) !important;*/
        /*object-fit: contain;*/
        width: 100%;
        height: auto;
        margin-bottom: -3%;
    }

    .anchorBL a {
        display: none;
    }

    .BMap_stdMpZoom {
        display: none;
    }

    .BMap_geolocationAddress {
        display: none !important;
    }

    #clockinAreaCheckDiv {
        margin: auto 0;
        text-align: center;
        z-index: 997;
        width: 100%;
        top: 84%;
        position: absolute;
        display: none;
    }

    #map {
        /*height: calc(100% - 30px) !important;*/
        /*height: 45%;*/
        -webkit-transition: all 0.5s ease-in-out;
        transition: all 0.5s ease-in-out;
        z-index: 101 !important;
        /*height: 192px;*/
        min-height: 190px;
        /*height: calc(40vh);*/
    }

    .BMap_geolocationIcon {
        z-index: 105;
    }

    #switchBtn {
        z-index: 1005;
    }

    .clockin-check-area {
        width: 100%;
        position: absolute;
        top: calc(57% + 40px);
        margin: auto 0;
        z-index: 102;
        text-align: center;
    }

    .clockin-check-area #clockin {
        width: 283px;
        height: auto;
        margin-top: -70px;
        margin-left: 16px;
    }

    #clockinAddressArea {
        margin-top: 50px;
    }

    #clockinAddress {
        font-size: 13px !important;
        color: #000000;
        pointer-events: none;
        background-color: rgba(255, 255, 255, 0.30);
    }

    .disabled {
        pointer-events: none;
    }

    #searchBar {
        z-index: 999;
    }

    #searchContent {
        display: none;
        position: fixed;
        top: 6%;
        height: 94%;
        width: 100%;
        background-color: #ffffff;
        z-index: 998;
    }

    .remind-block {
        height: 30px;
        line-height: 30px;
        background-color: #fce9aa;
        color: #947334;
        position: relative;
        overflow: hidden;
        text-align: center;
        width: 100%;
        padding-right: 20px;
        z-index: 1001;
    }

    .marquee-block {
        display: inline-block;
        width: 100%;
        height: 100%;
        vertical-align: middle;
        overflow: hidden;
        box-sizing: border-box;
        padding-left: 15px;
        position: relative;
    }

    .marquee {
        animation: marquee 25s linear infinite;
        white-space: nowrap;
        position: absolute;
    }

    @keyframes marquee {
        0% {
            transform: translateX(400px);
            -webkit-transform: translateX(400px);
        }
        100% {
            transform: translateX(-100%);
            -webkit-transform: translateX(-100%);
        }
    }

    @-webkit-keyframes marquee {
        0% {
            transform: translateX(400px);
            -webkit-transform: translateX(400px);
        }
        100% {
            transform: translateX(-100%);
            -webkit-transform: translateX(-100%);
        }
    }

    @media screen and (min-height: 600px) and (max-height: 700px) {
        #map {
            height: calc(45vh);
        }
    }

    @media screen and (min-height: 700px) and (max-height: 820px) {
        #map {
            height: calc(53vh);
        }
    }

    @media screen and (min-height: 820px) and (max-height: 900px) {
        #map {
            height: calc(55vh);
        }
    }

    @media screen and (min-width: 600px) and (max-width: 960px) {

        #map {
            height: calc(42vh);
            min-height: 400px;
        }

        #clockinArea {
            text-align: center;
        }

        #clockinAreaCheckDiv {
            top: 90%;
        }

        .clockin-check-area {
            top: calc(70% + 40px);
        }

        @keyframes marquee {
            0% {
                transform: translateX(600px);
                -webkit-transform: translateX(600px);
            }
            100% {
                transform: translateX(-100%);
                -webkit-transform: translateX(-100%);
            }
        }

        @-webkit-keyframes marquee {
            0% {
                transform: translateX(600px);
                -webkit-transform: translateX(600px);
            }
            100% {
                transform: translateX(-100%);
                -webkit-transform: translateX(-100%);
            }
        }
    }

    @media screen and (min-width: 960px)  and (max-width: 1100px) {
        #map {
            height: calc(41vh);
            min-height: 440px;
        }

        #clockinArea {
            text-align: center;
        }

        #clockinAreaCheckDiv {
            top: 86%;
        }

        .clockin-check-area {
            top: calc(70% + 40px);
        }

        @keyframes marquee {
            0% {
                transform: translateX(960px);
                -webkit-transform: translateX(960px);
            }
            100% {
                transform: translateX(-100%);
                -webkit-transform: translateX(-100%);
            }
        }

        @-webkit-keyframes marquee {
            0% {
                transform: translateX(960px);
                -webkit-transform: translateX(960px);
            }
            100% {
                transform: translateX(-100%);
                -webkit-transform: translateX(-100%);
            }
        }
    }

    @media screen and (min-width: 1100px) {
        #map {
            height: calc(55vh);
            min-height: 440px;
        }

        #clockinArea {
            text-align: center;
        }

        #clockinAreaCheckDiv {
            top: 90%;
        }

        .clockin-check-area {
            top: calc(125% + 40px);
        }

        @keyframes marquee {
            0% {
                transform: translateX(960px);
                -webkit-transform: translateX(960px);
            }
            100% {
                transform: translateX(-100%);
                -webkit-transform: translateX(-100%);
            }
        }

        @-webkit-keyframes marquee {
            0% {
                transform: translateX(1100px);
                -webkit-transform: translateX(1100px);
            }
            100% {
                transform: translateX(-100%);
                -webkit-transform: translateX(-100%);
            }
        }
    }

</style>
<div class="container container-page" id="clockinContainer">
    <%--    <div class="weui-search-bar" id="searchBar">--%>
    <%--        <form class="weui-search-bar__form">--%>
    <%--            <div class="weui-search-bar__box">--%>
    <%--                <i class="weui-icon-search"></i>--%>
    <%--                <input type="search" class="weui-search-bar__input" id="searchInput" placeholder="搜索" required="">--%>
    <%--                <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>--%>
    <%--            </div>--%>
    <%--            <label class="weui-search-bar__label" id="searchText"--%>
    <%--                   style="transform-origin: 0px 0px; opacity: 1; transform: scale(1, 1);">--%>
    <%--                <i class="weui-icon-search"></i>--%>
    <%--                <span>搜索</span>--%>
    <%--            </label>--%>
    <%--        </form>--%>
    <%--        <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">取消</a>--%>
    <%--    </div>--%>

    <div class="page list js_show" id="searchContent">
        <div class="page__bd">
            <div class="weui-cells" id="searchList">
            </div>
        </div>
    </div>


    <div id="bannerArea" class="remind-block">
        <div class="marquee-block">
            <div class="marquee">
                ${mobileConfig.MOBILE_CLOCKIN_BANNER_CONTENT}
            </div>
        </div>
    </div>

    <div id="clockinArea">
        <img id="clockinAreaImg" border="0" usemap="#clockinAreaMap"
             src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${mainImage.IMG_PATH}"/>
        <map name="clockinAreaMap" id="clockinAreaMap">
            <c:forEach items="${areaList}" var="area">
                <area shape="rect" coords="${area.BIMA_MAPINFO}" data-main-id="${area.BMI_RELATIONID}"/>
            </c:forEach>
        </map>
        <div id="clockinAreaCheckDiv">
            <a id="clockinAreaCheckBtn" href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">返回</a>
        </div>
    </div>


    <div id="map"></div>
    <div class="clockin-check-area-block">
        <div class="clockin-check-area">
            <%--            <a id="clockin" href="javascript:;" class="weui-btn weui-btn_primary weui-btn_loading">不在打卡范围内</a>--%>
            <img id="clockin" src="${BASE_URL}resources/assets/images/main/not_range.png">
        </div>
        <div id="clockinAddressArea" class="clockin-check-area">
            <a id="switchBtn" href="javascript:;" class="weui-btn weui-btn_default" style="display: none;">切换</a>
            <div id="clockinAddress" class="weui-btn weui-btn_disabled weui-btn_default"></div>
        </div>
    </div>
    <input type="hidden" id="clockinGeolocaltionPoint">
</div>
<script>
    showBottpmMenu();
    switchTabbar('clockinTabbar');
    mainInit.initPjax();
</script>
<script>
    $('#clockinArea').viewer({
        fullscreen: false,
        toolbar:false,
        title:false,
        navbar:false,
        rotatable:false,
        scalable:false,
        keyboard:false,
        toggleOnDblclick:false,
        <%--url:function (src) {--%>
        <%--    return '${BASE_URL}resources/assets/images/main/mawei_map.jpg';--%>
        <%--}--%>
    });
</script>
<script>
    <%--主页图片--%>
    //调整area
    <%--$('#clockinAreaImg').one('load', function () {--%>
    <%--    adjust('${mainImage.BMI_AREAWIDTH}', '${mainImage.BMI_AREAHEIGHT}');--%>
    <%--});--%>


    function adjust(imageWidth, imageHeigth) {
        var map = document.getElementById("clockinAreaMap");
        var area = map.getElementsByTagName('area');

        for (var i = 0; i < area.length; i++) {
            var oldCoords = area[i].getAttribute("coords");
            var newcoords = adjustPosition(imageWidth, imageHeigth, oldCoords);
            area[i].setAttribute("coords", newcoords);
            $(area[i]).unbind('click').on('click', function () {
                var mainId = $(this).attr('data-main-id');
                switchMainImage(mainId);
            })
        }
    }

    function adjustPosition(imageWidth, imageHeigth, position) {
        // 获取宽高
        var pageWidth = $('#clockinAreaImg').width();
        var pageHeight = $('#clockinAreaImg').height();
        // 图片原始尺寸
        var imageWidth = imageWidth;
        var imageHeigth = imageHeigth;

        var each = position.split(",");

        for (var i = 0; i < each.length; i++) {
            if (i % 2 != 0) {
                // 新的y轴坐标
                each[i] = Math.round(parseInt(each[i]) * pageHeight / imageHeigth).toString();
            } else {
                // 新的x轴坐标
                each[i] = Math.round(parseInt(each[i]) * pageWidth / imageWidth).toString();
            }
        }
        var newPosition = "";
        for (var j = 0; j < each.length; j++) {
            newPosition += each[j];
            if (j < each.length - 1) {
                newPosition += ",";
            }
        }
        return newPosition;
    }

    function switchMainImage(mainId) {
        $.showLoading();
        ajax.get('${BASE_URL}clockin/mainImage/' + mainId, {}, function (res) {
            if (res.code == 1) {
                var data = res.data;
                var mainImage = data.mainImage;
                var areaList = data.areaList;

                var $clockinAreaImg = $('#clockinAreaImg');
                var $clockinAreaMap = $('#clockinAreaMap');

                $clockinAreaImg.one('load', function () {
                    //调整区域
                    adjust(mainImage.BMI_AREAWIDTH, mainImage.BMI_AREAHEIGHT);
                });

                //切换主区域
                $clockinAreaImg.attr('src', '${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}' + mainImage.IMG_PATH);
                $clockinAreaImg.css('height', mainImage.BMI_HEIGHT + 'px');
                $clockinAreaImg.css('margin-top', mainImage.BMI_TOP + 'px');
                //切换点击区域
                $clockinAreaMap.empty();
                if (areaList.length != 0) {
                    var html = '';
                    for (let i in areaList) {
                        var area = areaList[i];
                        html += '<area shape="rect" coords="' + area.BIMA_MAPINFO + '" data-main-id="' + area.BMI_RELATIONID + '"/>';
                    }
                    $clockinAreaMap.html(html);
                }

                //显示返回按钮
                if (mainImage.IS_TOP == 0) {
                    $('#clockinAreaCheckBtn').attr('data-parent-id', mainImage.BMI_PARENTID);
                    $('#clockinAreaCheckDiv').fadeIn();
                }
            } else {
                $.hideLoading();
                $.toast("切换失败", "forbidden");
            }
        });
    }

    //返回按钮点击事件
    $('#clockinAreaCheckBtn').on('click', function () {
        $('#clockinAreaCheckDiv').fadeOut();
        var mainId = $(this).attr('data-parent-id');
        switchMainImage(mainId);
    });

    $('#clockinAreaImg').on('load', function () {
        // 加载完成
        $.hideLoading();
    });
    $('#clockinAreaImg').on('error', function () {
        // 加载完成
        $.hideLoading();
    });
</script>
<script>
    <%--搜索--%>
    var $ajax;
    var $searchContent = $('#searchContent');
    var $searchList = $('#searchList');
    var $searchClear = $('#searchClear');
    var $searchCancel = $('#searchCancel');
    var $searchInput = $('#searchInput');

    $searchClear.on('click', function () {
        search('');
    });
    $searchCancel.on('click', function () {
        $searchList.empty();
        $searchContent.fadeOut();
        showBottpmMenu();
    });
    $searchInput.on('keydown', function (e) {
        if (e.keyCode == 13) {
            var $items = $searchList.find('.weui-cell[data-search-id]');
            if ($items.length == 1) {
                clickSearchItem($($items[0]).attr('data-search-id'));
                $('#clockinAreaImg').focus();
            }
            e.preventDefault()
        }
    })
    $searchInput.on('click', function () {
        search($(this).val());
        $searchContent.fadeIn();
        hideBottpmMenu();
    });
    $searchInput.bind('input propertychange', function () {
        search($(this).val());
    });

    function search(queryWord) {
        if ($ajax != undefined) {
            $ajax.abort();
        }
        $ajax = ajax.get('${BASE_URL}clockin/search', {queryWord: queryWord}, function (data) {
            $searchList.empty();
            if (data.code == 1) {
                var dataList = data.data;
                var html = '';
                if (dataList.length != 0) {
                    for (let i in dataList) {
                        html += getSearchDataItem(dataList[i]);
                    }
                }

                $searchList.html(html);

                //点击事件
                $('.weui-cell[data-search-id]').unbind('click').on('click', function () {
                    clickSearchItem($(this).attr('data-search-id'));
                })
            }
        });
    }

    function clickSearchItem(searchId) {
        $searchList.empty();
        $searchContent.fadeOut();
        showBottpmMenu();
        switchMainImage(searchId);
    }

    function getSearchDataItem(data) {
        return '  <a class="weui-cell weui-cell_access" href="javascript:;" data-search-id="' + data.id + '"><div class="weui-cell__bd"><p>' + data.name + '</p></div><div class="weui-cell__ft"></div></a>';
    }
</script>
<script>
    <%--地图定位--%>
    var map;
    var geolocation;
    //打卡点坐标
    var geolocaltionPoint = {
        <c:forEach items="${achievementList}" var="achievement">
        '${achievement.ID}': [${achievement.BA_LONGITUDE}, ${achievement.BA_LATITUDE}, ${achievement.BA_RANGE}, ${achievement.BAD_COUNT}, '${achievement.IMG_PATH_BTN}', '${achievement.BAD_ID}'],
        </c:forEach>
    };
    var overlapPosition = 0;
    var geolocaltionPointOverlap = [];
    //打卡点圆
    var circleArray = {};
    var isLoading = false;
    //位置
    var marker;

    //异步加载地图
    function loadJScript() {
        removeMap();
        var script = document.createElement("script");
        script.type = "text/javascript";
        script.src = "https://api.map.baidu.com/api?v=3.0&ak=${WEBCONFIG_BAIDU_MAP_AK}&callback=initMap";
        document.body.appendChild(script);
    }

    function initMap(callback) {
        BDmap(function (rs) {
            callback(rs);
        });

        /* 渲染地图
         * @param callback 回调函数
         * @return none
         * @author pengYuanYuan
         * */
        function BDmap(callback) {
            // 百度地图API功能
            // new一个百度地图
            map = new BMap.Map('map', {enableMapClick: false});
            map.enableInertialDragging();
            map.enableContinuousZoom();
            map.enableDoubleClickZoom();
            map.enableScrollWheelZoom();
            //禁止拖拽
            // map.disableDragging();
            //禁止缩放
            // map.disableScrollWheelZoom();
            //禁止双击放大
            // map.disableDoubleClickZoom();
            var point = new BMap.Point(119.45759193517489, 25.989725336215738);
            map.centerAndZoom(point, 17);

            //设置样式
            map.setMapStyle({style: 'googlelite'});
            // map.setMapStyleV2({
            //     styleId: 'b64f732968aa5d4d6c415f1c2de1f86d'
            // });

            //去掉图片点击事件
            map.addEventListener("tilesloaded", function () {
                $('.anchorBL a').attr("disabled", true).css("pointer-events", "none");
            });

            //画圆
            for (let i in geolocaltionPoint) {
                var mPoint = new BMap.Point(geolocaltionPoint[i][0], geolocaltionPoint[i][1]);
                var circle = new BMap.Circle(mPoint, geolocaltionPoint[i][2], {
                    fillColor: "#99e4ff",
                    strokeColor: '#2C9FEB',
                    strokeOpacity: 1,
                    strokeWeight: 1,
                    fillOpacity: 0.3,
                });
                circleArray[i] = circle;
                map.addOverlay(circle);
            }

            geolocation = new BMap.Geolocation();
            geolocation.getCurrentPosition(function (r) {
                if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                    //用户拒绝地理位置授权
                    if (r.accuracy == null) {
                        handleError(BMAP_STATUS_PERMISSION_DENIED);
                        return;
                    }
                    map.panTo(r.point);
                    // 定位中心点，放大倍数
                    map.centerAndZoom(r.point, map.getZoom());
                    checkPoint(r.point);
                } else {
                    switchClockinBtn(3);
                    handleError(this.getStatus());
                }
            }, {enableHighAccuracy: true});

            // 添加定位控件
            var geolocationControl = new BMap.GeolocationControl();
            geolocationControl.addEventListener("locationSuccess", function (e) {
                // 定位成功事件
                setAddress(e.addressComponent, e.point.lng, e.point.lat)
            });
            geolocationControl.addEventListener("locationError", function (e) {
                // 定位失败事件
                $.toast("获取定位失败,请重试", "forbidden");
            });
            map.addControl(geolocationControl);

            // 添加地图移动事件
            // map.addEventListener('moving', function () {
            //     checkPoint(map.getCenter());
            // });

            /* GPS坐标转化为百度坐标 --start */
            function transformPoint(Point, callback) {
                var convertor = new BMap.Convertor();
                var pointArr = [];
                var ggPoint = new BMap.Point(Point.lng, Point.lat);
                pointArr.push(ggPoint);
                convertor.translate(pointArr, 1, 5, function (data) {
                    if (data.status === 0) {
                        callback(data.points[0])
                    } else {
                        callback(Point)
                    }
                });
            }

            /* 坐标转化 --end */
        }
    }

    /*  用户坐标转换为具体位置*/
    function checkPoint(pt) {
        var geoc = new BMap.Geocoder();
        var point = new BMap.Point(pt.lng, pt.lat);
        geoc.getLocation(pt, function (rs) {
            setAddress(rs.addressComponents, pt.lng, pt.lat)
        })
        addMarker(pt.lng, pt.lat);
    }

    function setAddress(addComp, lng, lat) {
        var address = addComp.province;
        address += addComp.city;
        address += addComp.district;
        address += addComp.street;
        address += addComp.streetNumber;
        $('#clockinAddress').text('地点:' + address);
        isLoading = true;

        //判断是否在打卡范围中
        if (isCheckCircleInside(lng, lat)) {
            var clockinGeolocaltionPoint = $('#clockinGeolocaltionPoint').val();
            var point = geolocaltionPoint[clockinGeolocaltionPoint];
            if (point[3] <= 0) {
                switchClockinBtn(1);
            } else {
                switchClockinBtn(4);
            }
        } else {
            switchClockinBtn(2);
        }
    }

    function addMarker(lng, lat) {
        map.removeOverlay(marker);
        var mPoint = new BMap.Point(lng, lat);
        marker = new BMap.Marker(mPoint);
        map.addOverlay(marker);
        marker.setAnimation(BMAP_ANIMATION_BOUNCE);
    }

    function isCheckCircleInside(lng, lat) {
        var isCheck = false;
        var pt = new BMap.Point(lng, lat);
        //是否重叠了
        var isOverlap = false;
        for (let i in circleArray) {
            if (BMapLib.GeoUtils.isPointInCircle(pt, circleArray[i])) {
                if (isCheck) {
                    isOverlap = true;
                } else {
                    $('#clockinGeolocaltionPoint').val(i);
                }
                isCheck = true;
                geolocaltionPointOverlap.push(i);
                // break;
            } else {
                if (!isCheck) {
                    $('#clockinGeolocaltionPoint').val('');
                }
            }
        }
        if (!isCheck) {
            geolocaltionPointOverlap = [];
            overlapPosition = 0;
        }
        if (isOverlap) {
            $('#switchBtn').fadeIn();
        } else {
            $('#switchBtn').fadeOut();
        }
        return isCheck;
    }

    function getGeolocation(callback) {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(callback, handleError, {
                enableHighAccuracy: true,
                maximumAge: 1000
            });
        } else {
            $.toast("获取定位失败,请确认是否打开GPS", "forbidden");
        }
    }

    function handleError(value) {
        switch (value) {
            case BMAP_STATUS_PERMISSION_DENIED:
                $.toast("位置服务被拒绝", "forbidden");
                break;
            case BMAP_STATUS_UNKNOWN_LOCATION:
                $.toast("获取位置失败,请确认是否打开GPS", "forbidden");
                break;
            case BMAP_STATUS_UNKNOWN_ROUTE:
                $.toast("获取位置失败,请确认是否打开GPS", "forbidden");
                break;
            case BMAP_STATUS_TIMEOUT:
                $.toast("获取定位获取信息超时", "forbidden");
                break;
            default:
                $.toast("未知错误", "forbidden");
                break;
        }
    }

    function switchClockinBtn(val) {
        var src = $('#clockin').attr('src');
        var changeSrc = src;
        if (val == 1 || val == 4) {
            var clockinGeolocaltionPoint = $('#clockinGeolocaltionPoint').val();
            var point = geolocaltionPoint[clockinGeolocaltionPoint];

            $('#clockin').removeClass('weui-btn_loading').removeClass('disabled');
            changeSrc = '${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}' + point[4];
        } else {
            $('#clockin').addClass('weui-btn_loading').addClass('disabled');
            changeSrc = '${BASE_URL}resources/assets/images/main/not_range.png';
        }
        if (changeSrc != src) {
            $('#clockin').attr('src', changeSrc);
        }
    }

    loadJScript();
</script>
<script>
    <%--切换打卡地点--%>
    $('#switchBtn').unbind('click').on('click', function () {
        if (overlapPosition >= geolocaltionPointOverlap.length - 1) {
            overlapPosition = 0;
        } else {
            overlapPosition++;
        }
        $('#clockinGeolocaltionPoint').val(geolocaltionPointOverlap[overlapPosition]);
        var point = geolocaltionPoint[geolocaltionPointOverlap[overlapPosition]];
        if (point[3] <= 0) {
            switchClockinBtn(1);
        } else {
            switchClockinBtn(4);
        }
    });
    <%--打卡--%>
    $('#clockin').unbind('click').on('click', function () {
        var clockinGeolocaltionPoint = $('#clockinGeolocaltionPoint').val();
        var point = geolocaltionPoint[clockinGeolocaltionPoint];
        if (clockinGeolocaltionPoint != undefined && clockinGeolocaltionPoint != '') {
            if (point[3] > 0) {
                //查看打卡详细
                loadUrl('${BASE_URL}my/clockin/' + point[5]);
            } else {
                //调用打卡功能
                loadUrl('${BASE_URL}clockin/in/${wechatUser.id}/' + clockinGeolocaltionPoint + '?clockinAddress=' + encodeURIComponent($('#clockinAddress').text().replace('地点:', '')));
            }
        }
    });
</script>
<script>
    isLocate = true;
    var locateTimeOut;
    <%--每5秒定位一次--%>
    getPosition();

    /**
     * 5秒刷新定位
     */
    function getPosition() {
        clearTimeout(locateTimeOut);
        locateTimeOut = setTimeout(function () {
            geolocation.getCurrentPosition(function (r) {
                if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                    if (r.accuracy == null) {
                        handleError(BMAP_STATUS_PERMISSION_DENIED);
                        return;
                    }
                    checkPoint(r.point);
                } else {
                    switchClockinBtn(3);
                    handleError(this.getStatus());
                }
            }, {enableHighAccuracy: true})
            if (isLocate) {
                getPosition();
            }
        }, 10000);
    }
</script>
