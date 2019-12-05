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
        height: 55%;
        background-color: #ffffff;
    }

    #clockinAreaImg {
        width: 100%;
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
        top: 55%;
        position: absolute;
        display: none;
    }

    #map {
        height: 37%;
        -webkit-transition: all 0.5s ease-in-out;
        transition: all 0.5s ease-in-out;
        z-index: 101 !important;
    }

    .BMap_geolocationIcon {
        z-index: 105;
    }

    .clockin-check-area #clockin {
    }

    .clockin-check-area {
        width: 100%;
        position: absolute;
        top: calc(65% + 40px);
        margin: auto 0;
        z-index: 102;
        text-align: center;
    }

    #clockinAddressArea {
        margin-top: 50px;
        pointer-events: none;
    }

    #clockinAddress {
        font-size: 13px !important;
        color: #000000;
    }

    #searchBar {
        z-index: 999;
    }

    #searchContent {
        display: none;
        position: fixed;
        top: 8%;
        height: 92%;
        width: 100%;
        background-color: #ffffff;
        z-index: 998;
    }
</style>
<div class="container container-page" id="clockinContainer">
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
        <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">取消</a>
    </div>

    <div class="page list js_show" id="searchContent">
        <div class="page__bd">
            <div class="weui-cells" id="searchList">
            </div>
        </div>
    </div>

    <div id="clockinArea">
        <img id="clockinAreaImg" border="0" usemap="#clockinAreaMap"
             src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${mainImage.IMG_PATH}"
             style="height: ${mainImage.BMI_HEIGHT}px;margin-top: ${mainImage.BMI_TOP}px;"/>
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
            <a id="clockin" href="javascript:;" class="weui-btn weui-btn_primary weui-btn_loading">不在打卡范围内</a>
        </div>
        <div id="clockinAddressArea" class="clockin-check-area">
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
    <%--主页图片--%>
    //调整area
    adjust('${mainImage.BMI_AREAWIDTH}', '${mainImage.BMI_AREAHEIGHT}');

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
                //调整区域
                adjust(mainImage.BMI_AREAWIDTH, mainImage.BMI_AREAHEIGHT);
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
        '${achievement.ID}': [${achievement.BA_LONGITUDE}, ${achievement.BA_LATITUDE}, ${achievement.BA_RANGE}],
        </c:forEach>
    };
    //打卡点圆
    var circleArray = {};
    var isLoading = false;
    //位置
    var marker;

    //异步加载地图
    function loadJScript() {
        $("script[src^='https://api.map.baidu.com/getscript?v=3.0']").remove();
        $("script[src^='https://api.map.baidu.com/api?v=3.0']").remove();
        $("iframe[src^='https://api.map.baidu.com/res/staticPages/location.html']").remove();
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
            map.setMapStyle({style:'googlelite'});
            map.enableInertialDragging();
            map.enableContinuousZoom();
            //禁止拖拽
            // map.disableDragging();
            //禁止缩放
            // map.disableScrollWheelZoom();
            //禁止双击放大
            // map.disableDoubleClickZoom();
            var point = new BMap.Point(116.331398, 39.897445);
            map.centerAndZoom(point, 17);

            //去掉图片点击事件
            map.addEventListener("tilesloaded", function () {
                $('.anchorBL a').attr("disabled",true).css("pointer-events","none");
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
                    //var mk = new BMap.Marker(r.point);
                    //map.addOverlay(mk);
                    // panTo()方法将让地图平滑移动至新中心点
                    map.panTo(r.point);
                    // 定位中心点，放大倍数
                    map.centerAndZoom(r.point, map.getZoom());
                    checkPoint(r.point);
                } else {
                    switchClockinBtn(3);
                    $.toast("获取定位失败", "forbidden");
                }
            }, {enableHighAccuracy: true});

            // 添加带有定位的导航控件
            // var navigationControl = new BMap.NavigationControl({
            //     // 靠左上角位置
            //     anchor: BMAP_ANCHOR_TOP_LEFT,
            //     // LARGE类型
            //     type: BMAP_NAVIGATION_CONTROL_LARGE,
            //     // 启用显示定位
            //     enableGeolocation: true
            // });
            // map.addControl(navigationControl);

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
            switchClockinBtn(1);
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
        for (let i in circleArray) {
            if (BMapLib.GeoUtils.isPointInCircle(pt, circleArray[i])) {
                $('#clockinGeolocaltionPoint').val(i);
                isCheck = true;
                break;
            } else {
                $('#clockinGeolocaltionPoint').val('');
            }
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
        switch (value.code) {
            case 1:
                $.toast("位置服务被拒绝", "forbidden");
                break;
            case 2:
                $.toast("获取定位失败,请确认是否打开GPS", "forbidden");
                break;
            case 3:
                $.toast("获取定位获取信息超时", "forbidden");
                break;
            case 4:
                $.toast("未知错误", "forbidden");
                break;
        }
    }

    function switchClockinBtn(val) {
        if (val == 1) {
            $('#clockin').removeClass('weui-btn_loading');
            $('#clockin').text('打卡');
        } else if (val == 3) {
            $('#clockin').removeClass('weui-btn_loading');
            $('#clockin').text('定位失败');
        } else {
            $('#clockin').addClass('weui-btn_loading');
            $('#clockin').text('不在打卡范围内');
        }
    }

    loadJScript();
</script>
<script>
    <%--打卡--%>
    $('#clockin').click(function () {
        var clockinGeolocaltionPoint = $('#clockinGeolocaltionPoint').val();
        if (clockinGeolocaltionPoint != undefined && clockinGeolocaltionPoint != '') {
            //调用打卡功能
            loadUrl('${BASE_URL}clockin/in/${wechatUser.id}/' + clockinGeolocaltionPoint);
        }
    });
</script>
<script>
    var timeOut;
    <%--每5秒定位一次--%>
    getPosition();

    /**
     * 5秒刷新定位
     */
    function getPosition() {
        clearTimeout(timeOut);
        timeOut = setTimeout(function () {
            geolocation.getCurrentPosition(function (r) {
                if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                    checkPoint(r.point);
                } else {
                    switchClockinBtn(3);
                }
            }, {enableHighAccuracy: true})
            getPosition();
        }, 5000);
    }
</script>
