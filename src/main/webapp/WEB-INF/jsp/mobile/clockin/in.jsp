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
    .weui-form {
        padding-top: 0px;
    }
</style>
<style>
    /*a  upload */
    .weui-a_upload {
        margin-top: 5px;
        margin-bottom: 5px;
        padding: 4px 10px;
        height: 20px;
        line-height: 20px;
        position: relative;
        cursor: pointer;
        color: #888;
        background: #fafafa;
        border: 1px solid #ddd;
        border-radius: 4px;
        overflow: hidden;
        display: inline-block;
        *display: inline;
        *zoom: 1;
        margin-left: 1px;
    }

    .weui-a_upload input {
        position: absolute;
        font-size: 100px;
        right: 0;
        top: 0;
        opacity: 0;
        filter: alpha(opacity=0);
        cursor: pointer
    }

    .weui-a_upload:hover {
        color: #444;
        background: #eee;
        border-color: #ccc;
        text-decoration: none
    }

    .weui-a_remove {
        margin-top: 5px;
        margin-bottom: 5px;
        color: red !important;
    }

    #removeVideoBtn {
        display: none;
    }

    .weui-video {
        height: auto;
        width: 50%;
        display: none;
    }

    #submitBtn {
        margin-top: 60px;
    }

    .weui-form__opr-area:last-child {
        margin-bottom: 10px;
    }

    .weui-form__opr-area{
        text-align: center;
    }
    .weui-btn{
        display: inline;
        width: 45%;
        margin-left: 5px;
        margin-right: 5px;
    }
</style>
<div class="container container-page">
    <%@ include file="/WEB-INF/jsp/mobile/common/common_top.jspf" %>
    <div class="weui-form">
        <div class="weui-form__text-area">
            <h2 class="weui-form__title">打卡地点:</h2>
            <h2 class="weui-form__desc">${clockinAddress}</h2>
        </div>
        <div class="weui-form__control-area">
            <form id="addAndEditForm">
                <input type="hidden" name="${SUBMIT_TOKEN_NAME}" value="${token}">
                <input type="hidden" name="BA_ID" value="${BA_ID}">
                <input type="hidden" name="BW_ID" value="${BW_ID}">
                <input type="hidden" id="BAD_FILETYPE" name="BAD_FILETYPE">
                <input type="hidden" id="  " name="BAD_FILEPARAMS">
                <input type="hidden" name="BAD_ADDRESS" value="${clockinAddress}">

                <div class="weui-cells__group weui-cells__group_form">
                    <div class="weui-cells__title">概述</div>
                    <div class="weui-cells weui-cells_form">
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <textarea id="BAD_REMARKS" name="BAD_REMARKS" class="weui-textarea" placeholder="概述"
                                          rows="3"
                                          maxlength="200"></textarea>
                                <div id="remarksCounter" class="weui-textarea-counter"><span>0</span>/200</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-tab" id="switchTab" style="height:44px;">
                    <div class="weui-navbar">
                        <c:if test="${mobileConfig.MOBILE_CLOCKIN_UPLOAD_IMG ne 0}">
                            <div class="weui-navbar__item tab-green">
                                上传图片 <span class="weui-uploader__info" id="uploader_count" data-total="9"
                                           data-val="0">0/9</span>
                            </div>
                        </c:if>
                        <c:if test="${mobileConfig.MOBILE_CLOCKIN_UPLOAD_VIDEO ne 0}">
                            <div class="weui-navbar__item">
                                上传视频
                            </div>
                        </c:if>
                    </div>
                </div>
            </form>

            <div id="uploadImageArea" class="weui-cells weui-cells_form" style="display: none;">
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <div class="weui-uploader">
                            <div class="weui-uploader__bd">
                                <form id="imageForm" enctype="multipart/form-data" method="post">
                                    <c:forEach items="${FILE_NAMES}" var="FILE_NAME">
                                        <input type="hidden" name="fileNames" value="${FILE_NAME}">
                                    </c:forEach>
                                    <input type="hidden" name="uploadToken" value="${UPLOAD_TOKEN}">
                                    <input type="hidden" name="SF_TYPE_CODE" value="${Attribute.BUS_FILE_DEFAULT}">
                                    <input type="hidden" id="fileCount" name="fileCount">
                                    <ul class="weui-uploader__files" id="uploader_files"></ul>
                                    <div class="weui-uploader__input-box">
                                        <input class="weui-uploader__input" id="uploader_input" type="file"
                                               accept="image/*" multiple="">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="uploadVideoArea" class="weui-cells weui-cells_form" style="display: none;">
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <div id="videoArea" class="weui-uploader">
                            <video class="weui-video" src="" id="video0" controls="controls"
                                   webkit-playsinline="true" playsinline="true" autoplay></video>
                            <img id="test">

                            <form id="videoForm" enctype="multipart/form-data" method="post">
                                <input type="hidden" name="uploadToken" value="${UPLOAD_TOKEN}">
                                <input type="hidden" name="fileName" value="${FILE_NAMES.get(0)}">
                                <input type="hidden" name="SF_TYPE_CODE" value="${Attribute.BUS_FILE_DEFAULT}">
                                <a id="uploadVideoAreaBtn" href="javascript:;" class="weui-a_upload"> <input
                                        id="uploadVideo"
                                        name="uploadVideo" class="uploadVideo" type="file"
                                        accept="video/*">上传视频
                                </a>
                                <%--视频时长--%>
                                <input type="hidden" id="video0Time">
                                <br>
                                <a id="removeVideoBtn" href="javascript:;" class="weui-a_upload weui-a_remove">移除视频
                                </a>
                                <span id="fileName" style="font-size: 18px"></span>
                                <div id="showFileName"></div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="weui-form__opr-area">
                <button class="weui-btn weui-btn_primary" href="javascript:" id="submitBtn">确定</button>
                <button class="weui-btn weui-btn_warn" href="javascript:" id="cancelBtn">取消</button>
            </div>


            <!--图片上传-->
            <div class="weui-gallery" id="gallery">
                <span class="weui-gallery__img" id="galleryImg"></span>
                <div class="weui-gallery__opr">
                    <a href="javascript:" class="weui-gallery__del">
                        <i class="weui-icon-delete weui-icon_gallery-delete"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    <c:if test="${isClockin eq 1}">
    //回到主页
    goHome();
    </c:if>
    hideBottpmMenu();
    switchTabbar('clockinTabbar');
    mainInit.initPjax();
</script>
<script>
    //提交打卡
    $('#submitBtn').click(function () {
        var $form = $('#addAndEditForm');
        if ($('#BAD_REMARKS').val() == '') {
            $.toast("请输入概述", "forbidden");
            return;
        }
        var BAD_FILETYPE = $('#BAD_FILETYPE').val();
        if (BAD_FILETYPE == 1) {
            if ($(".weui-uploader__file").length == 0) {
                $.toast("请上传图片", "forbidden");
                return;
            }
        } else if (BAD_FILETYPE == 2) {
            if ($('#uploadVideo').val() == '') {
                $.toast("请上传视频", "forbidden");
                return;
            }
            if ($('#video0Time').val() == undefined || $('#video0Time').val() == '') {
                $.toast("获取视频总时长失败,请重试", "forbidden");
                return;
            }
            if ($('#video0Time').val() > 10) {
                $.toast("上传视频不能大于10秒", "forbidden");
                return;
            }
        }
        if (BAD_FILETYPE == 1) {
            submitFile(BAD_FILETYPE, '${WEBCONFIG_FILE_SERVER_URL}uploadBase64Imgage', $('#imageForm'), '图片');
        } else if (BAD_FILETYPE == 2) {
            //先上传视频
            submitFile(BAD_FILETYPE, '${WEBCONFIG_FILE_SERVER_URL}upload', $('#videoForm'), '视频');
        }
    });

    $('#cancelBtn').on('click',function () {
        backHtml();
    });

    $('#BAD_REMARKS').bind('input propertychange', function () {
        var len = $("#BAD_REMARKS").val().length;
        $('#remarksCounter').html('<span>' + len + '</span>/200');
    });

    $('#switchTab').tab({
        defaultIndex: 0,
        activeClass: 'tab-green',
        onToggle: function (index) {
            if (index == 0) {
                $('#uploadImageArea').show();
                $('#uploadVideoArea').hide();
                //设置类型
                $('#BAD_FILETYPE').val('1');
                //移除视频
                $('#video0').hide();
                $('#uploadVideoAreaBtn').show();
                $('#removeVideoBtn').hide();
                $('#uploadVideo').val('');
                $('#video0Time').val('');
            } else if (index == 1) {
                $('#uploadImageArea').hide();
                $('#uploadVideoArea').show();
                //设置类型
                $('#BAD_FILETYPE').val('2');
                //移除图片
                $("#uploader_count").html("" + 0 + "/" + $("#uploader_count").attr('data-total') + "");
                $('#fileCount').val(0);
                $('#uploader_files').empty();
            }
        }
    })

    /**
     * 上传文件
     * @param url
     * @param $form
     * @param progressId
     * @param progressText
     */
    function submitFile(BAD_FILETYPE, url, $form, progressText) {
        var progressId = uuid();
        $.showProgress(progressId, progressText + "上传中", function () {
            //取消上传
            var jqxhr = $($form).data('jqxhr');
            jqxhr.abort();
        });
        ajax.fileProgress(url, $form, function (event, position, total, percentComplete) {
            //进度条
            $('#' + progressId).css('width', percentComplete + '%');
            if (percentComplete == 100){
                $.closeModal();
                $.showLoading(progressText + '保存中');
            }
        }, function (data) {
            $.closeModal();
            $.hideLoading();
            if (data.code == 1) {
                if (BAD_FILETYPE == 1) {
                    submitClockin(JSON.stringify(data.imageArray));
                } else if (BAD_FILETYPE == 2) {
                    submitClockin(JSON.stringify(data.message));
                }
            } else {
                $.toast("上传文件失败,请重试", "forbidden");
            }
        })
    }

    function submitClockin(uploadInfo) {
        var $form = $('#addAndEditForm');
        var params = packFormParams($form);
        //文件上传信息
        params['uploadInfo'] = uploadInfo;

        $.showLoading('提交打卡中');
        ajax.post('${BASE_URL}clockin/in/upload', params, function (data) {
            $.hideLoading();
            if (data.code == 1) {
                $.toast('打卡成功', 1000, function () {
                    backHtml();
                    <%--loadUrl('${BASE_URL}achievement/share/${BA_ID}/${BW_ID}?action=1');--%>
                });
            } else {
                $.toast("打卡失败", "forbidden");
            }
        });
    }
</script>
<script>
    $(function () {
        //var tmpl = '<li id="" class="weui-uploader__file" style="background-image:url(#url#)"></li>',//weui.js中的方法
        //var tmpl = '<li id="" class="weui-uploader__file" style="background-image:url(#url#)"><input type="hidden" id="#imgid#" name="#imgid#" value="#url#" /></li>',
        var tmpl = '<li id="" class="weui-uploader__file" style="background-image:url(#url#)"><input type="hidden" id="#imgid#" name="#imgname#" value="#url#" /><div class="weui-uploader__file-content">50%</div></li>',
            $gallery = $(".weui-gallery"), $galleryImg = $(".weui-gallery__img"),
            $gallery__del = $(".weui-gallery__del"),
            $uploaderInput = $("#uploader_input"),
            $uploaderFiles = $("#uploader_files"),
            $uploaderCount = $("#uploader_count")//显示已上传数的div元素
        ;
        // 允许上传的图片类型
        var allowTypes = ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'];
        // 1024KB，也就是 1MB
        var maxSize = 1024 * 1024;
        // 图片最大宽度
        var maxWidth = 1000;
        // 最大上传图片数量
        var imgTotal = 0;
        // 记录当前已上传数量
        var imgCount = 0;
        //记录当前被gallery的click事件打开的li元素
        var $galleryClickLi;
        $uploaderInput.on("change", function (e) {
            var src, url = window.URL || window.webkitURL || window.mozURL, files = e.target.files;
            imgTotal = parseInt($uploaderCount.attr("data-total"));//从显示上传数的$uploaderCount获取最大上传数量
            imgCount = parseInt($uploaderCount.attr("data-val"));//从显示上传数的$uploaderCount获取当前的数量
            for (var i = 0, len = files.length; i < len; ++i) {
                var file = files[i];

                if (url) {
                    src = url.createObjectURL(file);
                } else {
                    src = e.target.result;
                }
                imgCount = imgCount + 1;//数量+1；
                //$uploaderFiles.append($(tmpl.replace('#url#', src)));
                //新方法中对隐藏域的ID和value进行替换
                $.showLoading();
                var reader = new FileReader();
                reader.onload = function (e) {
                    var img = new Image();
                    img.onload = function () {
                        // 不要超出最大宽度
                        var w = Math.min(maxWidth, img.width);
                        // 高度按比例计算
                        var h = img.height * (w / img.width);
                        var canvas = document.createElement('canvas');
                        var ctx = canvas.getContext('2d');
                        // 设置 canvas 的宽度和高度
                        canvas.width = w;
                        canvas.height = h;
                        ctx.drawImage(img, 0, 0, w, h);
                        var base64 = canvas.toDataURL('image/png');

                        // 插入到预览区
                        $uploaderFiles.append($(tmpl.replace('#url#', base64).replace('#imgid#', "uploadImg" + imgCount).replace('#imgname#', "uploadImg").replace('#url#', base64)));
                        $.hideLoading();
                    };
                    img.src = e.target.result;
                };
                reader.readAsDataURL(file);

            }
            //更新记录数量的$uploaderCount 中的值和显示内容
            updateImgCount();
        });
        $uploaderFiles.on("click", "li", function () {
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
            $galleryClickLi = this;//记录被单击调用$gallery显示的li元素
        });
        $gallery.on("click", function () {
            $gallery.fadeOut(100);
        });
        $gallery__del.on("click", function () {
            $gallery.fadeOut(100);
            $galleryClickLi.remove();// $gallery删除事件执行移除li元素
            imgCount = imgCount - 1;
            updateImgCount();
        });

        //更新记录数量的$uploaderCount中的值和显示内容
        function updateImgCount() {
            $uploaderCount.attr("data-val", imgCount);
            $uploaderCount.html("" + imgCount + "/" + imgTotal + "");
            $('#fileCount').val(imgCount);
            if (imgCount >= imgTotal) {
                $('.weui-uploader__input-box').hide();
            } else {
                $('.weui-uploader__input-box').show();
            }
        }
    });
</script>

<script>
    $('#removeVideoBtn').click(function () {
        $('#video0').hide();
        $('#uploadVideoAreaBtn').show();
        $('#removeVideoBtn').hide();
        $('#uploadVideo').val('');
        $('#video0Time').val('');
    });

    $("#uploadVideoAreaBtn").on("change", "input[type='file']", function () {
        var filePath = $(this).val();
        var arr = filePath.split('\\');
        var fileName = arr[arr.length - 1];
        $(".showFileName").html(fileName);

        var objUrl = getObjectURL(this.files[0]);
        if (objUrl) {
            $("#video0").attr("src", objUrl);
            $('#video0').show();
            $('#uploadVideoAreaBtn').hide();
            $('#removeVideoBtn').show();
        }
    })

    //视频加载成功事件
    document.getElementById("video0").oncanplay = function () {
        var pl = document.getElementById("video0");
        $('#video0Time').val(pl.duration);
    }

    //建立一个可存取到该file的url
    function getObjectURL(file) {
        var url = null;
        if (window.createObjectURL != undefined) { // basic
            url = window.createObjectURL(file);
        } else if (window.URL != undefined) { // mozilla(firefox)
            url = window.URL.createObjectURL(file);
        } else if (window.webkitURL != undefined) { // webkit or chrome
            url = window.webkitURL.createObjectURL(file);
        }
        return url;
    }
</script>