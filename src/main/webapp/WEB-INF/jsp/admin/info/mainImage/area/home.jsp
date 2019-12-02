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
        width: 100%;
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

                                    <div class="hot_area" id="areaContent">
                                        <!-- 可添加热区数量与还可添加热区数量实时显示（可选）：-->
                                        <p><span class="">已添加已添加<b class="added_amount">0</b>个热区， 还可添加<b
                                                class="remain_amount">X</b>个热区</span></p>

                                        <!-- 图片展示部分：-->
                                        <div class="" name="imageMap" id="image_map">
                                            <img src="" ref="imageMap" id="photo"/>
                                        </div>

                                        <table>
                                            <tbody id="areaItems"></tbody>
                                        </table>

                                        <!-- 添加热区按钮部分：-->
                                        <p><a id="add_hot_area" href="JavaScript:;" class="">添加热区</a> &nbsp;
                                            <a id="" href="JavaScript:viewMap();" class="">查看热区</a>
                                        </p>

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
    $(function () {
        var setting = {
            maxAmount: 99,
            tag: 'tr',
            params: {
                //'areaLink':'添加热区时的默认值',
                //'areaType':'添加热区时的默认值'
            },
            //proportion:"0.5",
            domCallBack: function (params) {
                //console.log(params);
                return "<td>链接：<input type='text' value='http://baidu.com'/></td>"
            }
        }

        //初始化加载
        var areas = "[{'areaTitle':'热区1','areaLink':'','areaMapInfo':'0,0,120,80'},{'areaTitle':'热区 2','areaLink':'','areaMapInfo':'260,13,353,112'}]";
        $("#hotAreas").val(areas);

        //$('#hotAreas').val('');     //清空热区数据
        //$('#image_map').imageMaps(setting);
        //imageMaps.originalManual("./size.jpg",setting,true);
        imageMaps.proportionNoSameManual("${BASE_URL}${AttributePath.FILE_PREVIEW_URL}${mainImage.SF_ID}", setting, 1, 1, true);
    });

    function viewMap() {
        alert($('#areaItems').html());
        //$('#image_map').getAreaMapInfo(item);
    }
</script>
<script>
    //保存
    $('#save').click(function () {
        var $form = $('#addAndEditForm');
        //验证
        if (!validator.formValidate($form)) {
            demo.showNotify(ALERT_WARNING, VALIDATE_FAIL);
            return;
        }
        var params = packFormParams($form);

        ajax.put('${BASE_URL}${Url.WEBCONFIG_BASE_URL}', params, function (data) {
            ajaxReturn.data(data, null, null, null);
        })
    });

    validator.init({
        //验证表单
        form: $('#addAndEditForm'),
    });
</script>