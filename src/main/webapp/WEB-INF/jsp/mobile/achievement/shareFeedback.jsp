<%--
  Created by IntelliJ IDEA.
  User: 余庚鑫
  Date: 2019/11/27
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/jsp/common/common_meta.jsp" %>
<%--    <%@ include file="/WEB-INF/jsp/common/common_config.jsp" %>--%>
    <title>${WEBCONFIG_HEAD_TITLE}</title>
<%--    <%@ include file="/WEB-INF/jsp/mobile/common/common_css.jsp" %>--%>
    <link href="https://cdn.bootcss.com/weui/2.1.3/style/weui.min.css" rel="stylesheet">
    <style>
        .share-img {
            width: 100%;
            height: auto;
        }
        #shareBtn{
            width: 60px;
            height: 60px;
            padding: 15px 12px;
            margin: 5px;
            font-size: 12px;
            -moz-border-radius: 50px;
            -webkit-border-radius: 50px;
            border-radius: 50px;
            position: fixed;
            bottom: 8%;
            right: 5%;
            z-index: 888;
            box-shadow: 2px 2px 2px #888888;
        }
        #shareBtn:active{
            background-color: #069746;
        }
    </style>
</head>
<body class="index-page">

<div>
    <img class="share-img" src="${WEBCONFIG_FILE_SERVER_URL}${Url.FILE_SERVER_PREVIEW_URL}${IMG_PATH}">
    <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
            <a href="javascript:;" class="weui-btn weui-btn_primary" id="shareBtn" onclick="isfollowqr()">关注<br/>公众号</a>
        </p>
    </div>
</div>

<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script>
    function addcss(e) {
        var t = document.createElement("style"), d = document.head || document.getElementsByTagName("head")[0];
        if (t.type = "text/css", t.styleSheet) {
            var a = function () {
                try {
                    t.styleSheet.cssText = e
                } catch (e) {
                }
            };
            t.styleSheet.disabled ? setTimeout(a, 10) : a()
        } else {
            var s = document.createTextNode(e);
            t.appendChild(s)
        }
        d.appendChild(t)
    }
    function isfollowqr() {
        var e = "http://open.weixin.qq.com/qr/code?username=${MobileConfig.MOBILE_OFFICIAL_USERNAME}",
            o = !(arguments.length > 1 && void 0 !== arguments[1]) || arguments[1],
            i = "关注公众号",
            d = "感谢关注",
            n = document.createElement("div");
        n.classList.add("weui-model");
        var t = 1 == o ? '<span class="close" onclick="$(\'.weui-model\').remove();"></span>' : "",
            l = 1 == o ? "onclick=\"$('.weui-model').remove();\"" : "";
        n.innerHTML = '<div class="model-mask"  ' + l + '></div><div class="model-main">' + t + '<div class="model-head"><div class="m-title"><p>' + i + "</p><p>" + d + '</p></div></div><div class="model-body"><div class="follow">\n    <img src="' + e + '">\n    <p>长按识别图中二维码</p>\n</div></div></div>', document.body.appendChild(n), addcss(".weui-model{width:100%;height:100%;position:fixed;z-index:9999;top:0;left:0;display:block;text-align:center}\n.model-mask{width:100%;height:100%;background-color:#000;opacity:.7;cursor:pointer}\n.model-main{width:80%;min-height:2.5em;background-color:#fff;color:#333;z-index:99999;border-radius:.2em;position:absolute;top:50%;left:50%;-webkit-transform:translate(-50%,-50%);transform:translate(-50%,-50%)}\n.model-main .close{position:absolute;top:-45px;right:-10px;width:35px;height:35px;padding:5px;background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAC70lEQVRIS52WTajVVRTFf6usaCKCQWRNmokNFGtUmNgzyMrvED/AgZEmiOCgqIZNkiwzFNICDcHPUWCkA0mLQM1IFCRRQdRUzIImKRK2ZMn5P87z3f+997UnF+45/732x9p7HdHFbD8MvATMA54FxgFjgRvAFeAo8A3wg6Q7ba7UdmB7EfAp8AewC/ge+B34C3gCeBp4Hci9W8AaSfs6+RsGYjuR7gWSxTuSEm2r2X4AWAx8CJwGFkr6p/5gCIjtCcABYKOkdd2c339m+xFgDzAemCHpQnNnEMT2k8DxEv2OkQA0d23H3xfA1PRQ0s2c3QOx/SBwEvhE0tf/B6ACiq+fgHOSltYgy4HpkhZUl8ekuZJO9AK1nW8PVt8+HpAQQ9KPsj0KuAgMSDpTXZwDbC//p4wdzfZK4GNgsqQ4vme2VwNvSpoYkJeB9yQNdGhm0t3UBmR7GfB5qcKx+vtChNB9ICBp1FlJn3UK1XaANhZHgxnZXgJsKQEMAaiyyaCeD8gvwHJJv3YpycLiMLU/bvsNYFuhaprcVso1wNyAXAUmScpkt5rtBijz8y7wqqRWgNKXBLMuILeBRyX91weLvgTeAj6Q9FEf96cA+wNyrTAjv90yaUq0NkQBZko63OObmSFOQDIHb0vq2Lwq7a1NiWy/BuzuBWR7BbAsIF8BZyRl4w4z27OAncArdQ/6AbKdwG4FZD6wStK0DnMSgOyx2ZKy6odYNyDbDxVZWBKQ0cAl4EVJpyqOp2nZyKn9MIDqXlO60Huw5GVQN0TomgUZSkb9nm9YViY2q+JIHyx6AfhZ0r+lh9Gi88B6SRsakKSWYfxW0vu9nPY6t51BnQQ8F1mu9eSpRFP2WBbjiK3oSVZQ6D5R0vU4uV8ZnwG+Azb3M2x1FJUyJoMo42/NeZvGR0YjpyPV+LNF4/+uA+j2WsnjILOTlDN4YdjlltdKVlICyr1h1gpSsSQ6M7e8u/IUegz4s7y7svqzzg81zOoEchflLmD7O1+wYQAAAABJRU5ErkJggg==) no-repeat center center;background-size:auto;background-size:25px 25px}\n.model-main .model-head{font-size:20px;padding:.6em 0;background:-webkit-gradient(linear,left top,left bottom,from(#fd7a71),to(#e5484c));background:-webkit-linear-gradient(top,#fd7a71,#e5484c);background:linear-gradient(to bottom,#fd7a71,#e5484c);border-radius:.1em .1em 0 0;position:relative}\n.model-main .model-head p{color:#fff}.model-main .model-head p:nth-child(1){font-size:20px;line-height:1.5;font-weight:bold}\n.model-main .model-head p:nth-child(2){font-size:16px;line-height:1.5}.model-main .model-body{padding:.5em;-webkit-box-sizing:border-box;box-sizing:border-box;min-height:5em;width:100%}\n.model-main .model-body img{margin-top:.1em;width:70%}.model-main .model-body p{color:#333;line-height:1.6;font-size:16px}")
    }
</script>
</body>
</html>