<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2018/5/22
  Time: 23:48
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    #photo {
        width: 1000px;
        height: auto;
    }
</style>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box" id="boxContentDiv">
                <div class="box-header">
                    <div class="col-md-12 btn-group-header">
                        <s:button back="true"></s:button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="col-md-12">
                        <div class="box box-default">
                            <div class="box-body">
                                <form id="addAndEditForm">
                                    <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
                                    <input type="hidden" name="BA_ID" value="${achievement.ID}">
                                    <input type="hidden" name="BAS_PARENTID" value="${BAS_PARENTID}">

                                    <div class="hot_area" id="areaContent">
                                        <!-- 可添加热区数量与还可添加热区数量实时显示（可选）：-->
                                        <p><span class="">已添加已添加<b class="added_amount">0</b>个热区， 还可添加<b
                                                class="remain_amount">X</b>个热区</span></p>

                                        <!-- 图片展示部分：-->
                                        <div class="" name="imageMap" id="image_map">
                                            <img src="" ref="imageMap" id="photo"/>
                                        </div>

                                        <div class="box-body">
                                            <table id="areaTable" class="table table-bordered table-striped">
                                            </table>
                                        </div>

                                        <!-- 热区数据存储（隐藏）：-->
                                        <input type="hidden" id="hotAreas" name="hotAreas">
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<c:if test="${!fns:isEmpty(EXTRA.TITLE)}">
    <c:set scope="request" var="MENU_TITLE" value="${EXTRA.TITLE}-"></c:set>
</c:if>
<%@ include file="/WEB-INF/jsp/admin/component/setTitleParams.jsp" %>
<script>
    //绑定删除按钮点击事件
    var deleteFun;
    //列表显示
    var objTable = $('#areaTable');
    var $dataGrid = tableView.init({
        //table对象
        object: objTable,
        paging: false,
        pageLength: -1,
        cache: false,
        info: false,
        data: ${areaInfoList},
        //对应上面thead里面的序列
        columns: [
            {
                data: 'BAS_PARENTID',
                title: '父ID',
                visible: false,
            },
            {
                data: 'BAS_INDEX',
                title: '索引',
                width: '100px',
                className: 'text-center dataTable-column-min-width'
            },
            {
                data: 'areaMapInfo',
                title: '坐标',
                width: '100px',
                className: 'text-center dataTable-column-min-width'
            },
            {
                data: 'BAS_TYPE',
                title: '类型',
                width: '70px',
                className: 'text-center dataTable-column-min-width'
            },
            {
                data: 'BAS_TEXT',
                visible: false,
                title: '文本',
                width: '250px',
                className: 'text-left dataTable-column-min-width'
            },
            {
                data: 'SF_ID',
                visible: false,
                title: '图片',
                width: '60px',
                className: 'text-center dataTable-column-min-width',
                render: function (data, type, full, meta) {
                    if (data == null) {
                        return '';
                    }
                    return '<img src="${BASE_URL}${AttributePath.FILE_PREVIEW_URL}' + data + '"  style="width:50px;height:auto;" data-action="zoom"/>';
                }
            },
            {
                data: 'ID',
                title: '操作',
                width: '100px',
                className: 'text-center dataTable-column-min-width',
                render: function (data, type, row, meta) {
                    var html = '<div class="dataTable-column-min-width-operation">';
                    html += '<button class="btn btn-xs btn-info" id="edit">编辑</button>';
                    // html += '<button class="btn btn-xs btn-success" id="share">分享图片</button>';
                    html += '<button class="btn btn-xs btn-danger" id="del">删除</button>';
                    html += '</div>';
                    return html;
                }
            },
        ],
        endCallback: function () {
            onEditClick();
            // onShareClick();
        },
    });

    function onEditClick() {
        //修改
        objTable.find('tbody').unbind('click').on('click', '#edit', function () {
            var $this = $(this);
            var data = tableView.rowData($dataGrid, $this);
            var id = data.ID;
            var BAS_INDEX = data.BAS_INDEX;
            var BAS_TYPE = data.BAS_TYPE;
            // var BAS_TEXT = data.BAS_TEXT;

            ajax.getHtml('${BASE_URL}${Url.ACHIEVEMENT_SHARE_HTML_UPDATE_URL}/' + id, {
                    BAS_TYPE: BAS_TYPE,
                    // BAS_TEXT: BAS_TEXT
                }, function (html) {
                    model.show({
                        title: '修改索引:' + BAS_INDEX,
                        content: html,
                        footerModel: model.footerModel.ADMIN,
                        isConfirm: true,
                        confirm: function ($model) {
                            $dataGrid.rows($this.parents('tr')).every(function () {
                                var d = this.data();
                                d.BAS_TYPE = $('#BAS_TYPE').select2("data")[0].text;
                                d.BAS_TEXT = $('#BAS_TEXT').val();
                                this.invalidate();
                            }).draw();
                            $($model).modal('hide');
                            <%--ajax.get('${BASE_URL}${AttributePath.FILE_INFO_URL}' + id + '/${TableName.BUS_ACHIEVEMENT_SHARE}', {}, function (data) {--%>
                            <%--    if (data.code == STATUS_SUCCESS) {--%>
                            <%--        var file = data.data;--%>
                            <%--        //更新数据--%>
                            <%--        $dataGrid.rows($this.parents('tr')).every(function () {--%>
                            <%--            var d = this.data();--%>
                            <%--            d.BAS_TYPE = $('#BAS_TYPE').select2("data")[0].text;--%>
                            <%--            d.BAS_TEXT = $('#BAS_TEXT').val();--%>
                            <%--            d.SF_ID = file.ID;--%>
                            <%--            this.invalidate();--%>
                            <%--        }).draw();--%>
                            <%--        deleteFun();--%>
                            <%--        $($model).modal('hide');--%>
                            <%--    }--%>
                            <%--});--%>
                        },
                    });
                }
            );
        });
    }

    function onShareClick() {
        //修改
        objTable.find('tbody').unbind('click').on('click', '#share', function () {
            var $this = $(this);
            var data = tableView.rowData($dataGrid, $this);
            var ID = data.ID;
            var BAS_INDEX = data.BAS_INDEX;
            if (data.IS_INSERT == 1) {
                demo.showNotify(ALERT_WARNING, '请保存后使用');
                return;
            }

            var param = {
                BA_ID: '${achievement.ID}',
                BAS_PARENTID: ID,
                TITLE: '索引:' + BAS_INDEX,
                IS_BACK: 1,
            };
            //切换主界面
            loadUrl('${BASE_URL}${fns:getUrlByMenuCode("MOBILE:ACHIEVEMENT_SHARE")}' + urlEncode(param));
        });
    }
</script>
<script>
    $(function () {
        var setting = {
            maxAmount: 3,
            tag: 'tr',
            addBtn: 'addBtn',
            params: {
                //'areaLink':'添加热区时的默认值',
                //'areaType':'添加热区时的默认值'
            },
            initCallBack: function (params, id, index, delFun) {
                //设置索引
                $('#' + id).attr('ref', index);
                deleteFun = delFun;
            },
            createAreaItem: function (id, index, areaTitle, areaMapInfo, delFun) {
                //获取ID
                ajax.post('${BASE_URL}${Url.SEQUENCE_ID_URL}', {}, function (data) {
                    if (data.code == STATUS_SUCCESS) {
                        //创建行
                        var $row = $dataGrid.row.add({
                            'ID': data.id,
                            'BAS_INDEX': index,
                            'areaMapInfo': areaMapInfo,
                            'IS_INSERT': 1
                        }).draw().node();
                        $($row).attr('ref', index);
                        onEditClick();
                        onShareClick();
                        deleteFun = delFun;
                        deleteFun();
                    } else {
                        demo.showNotify(ALERT_WARNING, '获取ID失败');
                        $(".hot_area").find('.position_container').find('.map_position[ref=' + index + ']').remove();
                    }
                });
            },
            changeCallBack: function ($this, index) {
                //更新数据
                $dataGrid.rows($this).every(function () {
                    var data = this.data();
                    data.BAS_INDEX = index;
                    this.invalidate();
                }).draw();
                deleteFun();
            },
            changeAreaInfoCallBack: function (index, left, top, right, bottom) {
                //更新数据
                $dataGrid.rows($('.table tr[ref="' + index + '"]')).every(function () {
                    var data = this.data();
                    data.BAS_INDEX = index;
                    data.areaMapInfo = new Array(Math.round(left), Math.round(top), Math.round(right), Math.round(bottom)).join(',');
                    this.invalidate();
                }).draw();
                deleteFun();
            },
            deleteCallBack: function ($this, index) {
                //删除列表
                $dataGrid.row($this).remove().draw();
            },
            domCallBack: function (params) {
                //console.log(params);
                // return "<td>链接：<input type='text' value='http://baidu.com'/></td>"
                return '';
            }
        }

        //初始化加载
        var areas = '${areaInfoList}';
        $("#hotAreas").val(areas);

        imageMaps.proportionNoSameManual("${BASE_URL}${AttributePath.FILE_PREVIEW_URL}${achievement.SF_ID}", setting, 1, 1, true);
    });
</script>
<script>
    //保存
    function save() {
        model.show({
            title: '是否保存',
            content: '保存后无法还原之前配置,请确认!',
            class: model.class.WARNING,
            footerModel: model.footerModel.ADMIN,
            isConfirm: true,
            confirm: function ($model) {
                var $form = $('#addAndEditForm');
                //验证
                if (!validator.formValidate($form)) {
                    demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
                    return;
                }
                var updateAreaList = [];
                var data = $dataGrid.data();
                for (let i = 0; i < data.length; i++) {
                    updateAreaList[i] = data[i];
                }
                var params = packFormParams($form);
                params['updateAreaList'] = JSON.stringify(updateAreaList);
                params['BAS_HEIGHT'] = $('#photo').height();
                params['BAS_WIDTH'] = $('#photo').width();

                ajax.put('${BASE_URL}${Url.ACHIEVEMENT_SHARE_UPDATE_URL}', params, function (data) {
                    ajaxReturn.data(data, $model, null, null, {
                        success: function () {
                            if ('${EXTRA.IS_BACK}' == '1') {
                                backHtml();
                            } else {
                                refresh();
                            }
                        }
                    });
                });
            }
        });
    }

    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>