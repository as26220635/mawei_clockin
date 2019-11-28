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
        height: 250px;
        margin-top: 30px;
    }

    #clockinAreaCheck1 {
        z-index: 100;
        top: 80px;
        left: 2%;
        position: absolute;
        background: #00000000;
        /*background: rgba(40, 199, 253, 0.31);*/
        width: 50%;
        height: 130px;
    }

    #clockinAreaCheck2 {
        z-index: 100;
        top: 210px;
        left: 2%;
        position: absolute;
        background: #00000000;
        /*background: rgba(45, 47, 51, 0.31);*/
        width: 50%;
        height: 130px;
    }
    #clockinAreaCheck3 {
        z-index: 100;
        top: 80px;
        left: 52%;
        position: absolute;
        background: #00000000;
        /*background: rgba(5, 0, 255, 0.31);*/
        width: 48%;
        height: 130px;
    }
    #clockinAreaCheckDiv{
        margin: auto 0;
        text-align: center;
        z-index: 99998;
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
    }

    #clockinAddress {
        font-size: 13px !important;
        color: #000000;
    }
</style>
<div class="container container-page">
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

    <div id="clockinArea">
        <img id="clockinAreaImg" src="${BASE_URL}resources/assets/images/main/map.jpg">
        <div id="clockinAreaCheck1" data-type="1">

        </div>
        <div id="clockinAreaCheck2" data-type="2">

        </div>
        <div id="clockinAreaCheck3" data-type="3">

        </div>
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
    //打卡点坐标
    var geolocaltionPoint = {
        <c:forEach items="${achievementList}" var="achievement">
        '${achievement.ID}': [${achievement.BA_LONGITUDE}, ${achievement.BA_LATITUDE}, ${achievement.BA_RANGE}],
        </c:forEach>
    };
    //打卡点圆
    var circleArray = {};
    var isLoading = false;

    //异步加载地图
    function loadJScript() {
        var script = document.createElement("script");
        script.type = "text/javascript";
        script.src = "https://api.map.baidu.com/api?v=3.0&ak=o9eGesSQqcQGkKaiqu1ZHAg9gkF0ShnC&coord=bd09ll&callback=initMap";
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
            var map = new BMap.Map('map', {enableMapClick: false});
            map.enableInertialDragging();
            map.enableContinuousZoom();
            //禁止拖拽
            map.disableDragging();
            //禁止缩放
            map.disableScrollWheelZoom();
            var point = new BMap.Point(116.331398, 39.897445);
            map.centerAndZoom(point, 15);

            //画圆
            for (let i in geolocaltionPoint) {
                var mPoint = new BMap.Point(geolocaltionPoint[i][0], geolocaltionPoint[i][1]);
                var circle = new BMap.Circle(mPoint, geolocaltionPoint[i][2], {
                    fillColor: "blue",
                    strokeWeight: 1,
                    fillOpacity: 0.3,
                    strokeOpacity: 0.3,
                    // enableEditing: true
                });
                circleArray[i] = circle;
                map.addOverlay(circle);
            }

            var geolocation = new BMap.Geolocation();
            geolocation.getCurrentPosition(function (r) {
                if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                    //var mk = new BMap.Marker(r.point);
                    //map.addOverlay(mk);
                    map.panTo(r.point);  // panTo()方法将让地图平滑移动至新中心点
                    map.centerAndZoom(r.point, 15);                                // 定位中心点，放大倍数
                } else {
                    console.log('failed' + this.getStatus());
                }
            }, {enableHighAccuracy: true});

            // 添加带有定位的导航控件
            var navigationControl = new BMap.NavigationControl({
                // 靠左上角位置
                anchor: BMAP_ANCHOR_TOP_LEFT,
                // LARGE类型
                type: BMAP_NAVIGATION_CONTROL_LARGE,
                // 启用显示定位
                enableGeolocation: true
            });
            map.addControl(navigationControl);

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
            map.addEventListener('moving', function () {
                checkPoint(map.getCenter());
            });

            /*  用户坐标转换为具体位置 --start */
            function checkPoint(pt) {
                var geoc = new BMap.Geocoder();
                var point = new BMap.Point(pt.lng, pt.lat);
                geoc.getLocation(pt, function (rs) {
                    setAddress(rs.addressComponents, pt.lng, pt.lat)
                })
            }

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

    function setAddress(addComp, lng, lat) {
        $('.BMap_geolocationContainer,.BMap_stdMpZoom').hide();
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
        } else {
            $('#clockin').addClass('weui-btn_loading');
            $('#clockin').text('不在打卡范围内');
        }
    }

    loadJScript();
</script>
<script>
    $('#clockin').click(function () {
        var clockinGeolocaltionPoint = $('#clockinGeolocaltionPoint').val();
        if (clockinGeolocaltionPoint != undefined && clockinGeolocaltionPoint != '') {
            //调用打卡功能
            loadUrl('${BASE_URL}clockin/in/${wechatUser.id}/' + clockinGeolocaltionPoint);
        }
    });
    $('#clockinAreaCheck1,#clockinAreaCheck2,#clockinAreaCheck3').click(function () {
        $.showLoading();
        var type = $(this).attr('data-type');
        if (type == 1){
            $('#clockinAreaImg').prop('src', '${BASE_URL}resources/assets/images/main/map_1.png');
        }else if (type == 2){
            $('#clockinAreaImg').prop('src', '${BASE_URL}resources/assets/images/main/map_2.png');
        }else if (type == 3){
            $('#clockinAreaImg').prop('src', '${BASE_URL}resources/assets/images/main/map_3.png');
        }
        $('#clockinAreaCheck1,#clockinAreaCheck2,#clockinAreaCheck3').hide();
        $('#clockinAreaCheckDiv').fadeIn();
    });
    $('#clockinAreaCheckDiv').click(function () {
        $.showLoading();
        $('#clockinAreaImg').prop('src', '${BASE_URL}resources/assets/images/main/map.jpg');
        $('#clockinAreaCheckDiv').fadeOut();
        $('#clockinAreaCheck1,#clockinAreaCheck2,#clockinAreaCheck3').show();
    });
    document.getElementById('clockinAreaImg').onload=function(){
        // 加载完成
        $.hideLoading();
    };
</script>
<script>
    getPosition();

    /**
     * 5秒刷新定位
     */
    function getPosition() {
        setTimeout(function () {
            if (isLoading) {
                $('.BMap_geolocationIcon').click();
                isLoading = false;
            }
            getPosition();
        }, 5000);
    }
</script>
