<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/3/27
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .searech_btn_group button{
        margin-top: 5px;
        margin-bottom: 5px;
        width: 150px;
    }
</style>
<form id="addAndEditForm">
    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
    <input type="hidden" name="ID" value="${achievement.ID}">
    <input type="hidden" name="insertId" value="${insertId}">
    <div class="form-group has-feedback">
        <label>成就墙名称:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_ACHIEVEMENT, "BA_NAME")}
               value="${achievement.BA_NAME}">
    </div>
    <div class="form-group has-feedback">
        <label>经度:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_ACHIEVEMENT, "BA_LONGITUDE")}
               value="${achievement.BA_LONGITUDE}" readonly>
    </div>
    <div class="form-group has-feedback">
        <label>纬度:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_ACHIEVEMENT, "BA_LATITUDE")}
               value="${achievement.BA_LATITUDE}" readonly>
    </div>
    <div class="form-group has-feedback">
        <label>打卡范围:</label>
        <input type="text" class="form-control" ${fns:validField(TableName.BUS_ACHIEVEMENT, "BA_RANGE")}
               value="${achievement.BA_RANGE}">
    </div>
    <div class="form-group has-feedback">
        <label>位置展示:</label>
        <div>
            <input id="searchMapInput" type="text" class="form-control">
        </div>
        <div class="text-center searech_btn_group">
            <button id="searchMapBtn" type="button" class="btn btn-success btn-xs">
                搜索
            </button>
            <button id="locateBtn" type="button" class="btn btn-info btn-xs">
                定位标志
            </button>
        </div>
        <div style="width:100%;height:350px;border:#ccc solid 1px;" id="dituContent"></div>
    </div>
    <s:fileInput title="附件" sdtCode="BUS_ACHIEVEMENT_FILE"
                 tableId="${not empty achievement ? achievement.ID: insertId}"
                 tableName="${TableName.BUS_ACHIEVEMENT}" typeCode="${TableName.BUS_ACHIEVEMENT}"
                 multiple="false"
    ></s:fileInput>
</form>

<script>
    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>
<script>
    //异步加载地图
    function loadJScript() {
        var script = document.createElement("script");
        script.type = "text/javascript";
        script.src = "https://api.map.baidu.com/api?v=3.0&ak=${WEBCONFIG_BAIDU_MAP_AK}&callback=initMap";
        document.body.appendChild(script);
    }

    //默认马尾
    var lng = 119.45759193517489;
    var lat = 25.989725336215738;
    //地图缩放等级
    var level = getLevel('${achievement.BA_RANGE}');
    //打卡范围
    var circle;
    //标注
    var marker;

    <c:if test="${not empty achievement}">
    lng = ${achievement.BA_LONGITUDE};
    lat = ${achievement.BA_LATITUDE};
    </c:if>

    var map;
    var local;

    function initMap() {
        map = new BMap.Map("dituContent");
        var point = new BMap.Point(lng, lat);//定义一个中心点坐标
        map.centerAndZoom(point, level);

        <c:if test="${not empty achievement}">
        addCircle(lng, lat, '${achievement.BA_RANGE}');
        </c:if>

        //拉回中心
        var loadCount = 1;
        map.addEventListener("tilesloaded", function () {
            if (loadCount <= 3) {
                //设定地图的中心点和坐
                map.centerAndZoom(point, level);
            }
            loadCount = loadCount + 1;
        });

        setLocalSearch();//设置地图搜索
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
    }


    function setLocalSearch() {
        local = new BMap.LocalSearch(map, {
            renderOptions: {map: map}
        });
        $('#searchMapBtn').on('click',function () {
            searchMap();
        });
        $('#locateBtn').on('click',function () {
            if (marker != undefined){
                var mpoint = new BMap.Point(marker.point.lng, marker.point.lat);
                map.centerAndZoom(mpoint,map.getZoom());
            }
        });
    }

    //地图事件设置函数：
    function setMapEvent() {
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }

    //地图控件添加函数：
    function addMapControl() {
        //单击获取点击的经纬度
        map.addEventListener("click", function (e) {
            $('#BA_LONGITUDE').val(e.point.lng);
            $('#BA_LATITUDE').val(e.point.lat);
            changeMapCoordinate();
        });
        //向地图中添加缩放控件
        var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
        map.addControl(ctrl_nav);
    }

    function searchMap() {
        var text = $('#searchMapInput').val();
        if (text!= ''){
            local.search(text);
        }
    }

    function addCircle(lng, lat, range) {
        var mPoint = new BMap.Point(lng, lat);
        circle = new BMap.Circle(mPoint, range, {
            fillColor: "#99e4ff",
            strokeColor: '#2C9FEB',
            strokeOpacity: 1,
            strokeWeight: 1,
            fillOpacity: 0.3,
        });
        map.addOverlay(circle);
        addMarker(lng, lat);
    }

    function addMarker(lng, lat) {
        map.removeOverlay(marker);
        var mPoint = new BMap.Point(lng, lat);
        marker = new BMap.Marker(mPoint);
        map.addOverlay(marker);
    }

    function getLevel(range) {
        var level = 13;
        if (!isEmpty(range)) {
            if (range <= 60) {
                level = 22;
            } else if (range <= 100) {
                level = 18;
            } else if (range <= 200) {
                level = 17;
            } else if (range <= 500) {
                level = 16;
            } else if (range <= 1000) {
                level = 15;
            } else if (range <= 1500) {
                level = 14;
            }
        }
        return level;
    }

    $('#BA_LONGITUDE,#BA_LATITUDE,#BA_RANGE').on('input propertychange', function (event) {
        changeMapCoordinate();
    });

    function changeMapCoordinate() {
        var lng = $('#BA_LONGITUDE').val();
        var lat = $('#BA_LATITUDE').val();
        var range = $('#BA_RANGE').val();

        //删除旧范围
        map.removeOverlay(circle);

        addCircle(lng, lat, range);
    }

    loadJScript();

</script>