package cn.kim.controller.mobile;

import cn.kim.common.annotation.WechaNotEmptyLogin;
import cn.kim.common.attr.MagicValue;
import cn.kim.common.attr.MobileConfig;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.tools.JSSDKConfig;
import cn.kim.util.TextUtil;
import com.google.common.collect.Maps;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2017/4/15.
 */
@Controller
public class LayoutController extends BaseController {

    /**
     * 主界面url
     */
    public static final String LAYOUT_PATH = "/mLayout";

    @GetMapping("/mLayout")
    @WechaNotEmptyLogin
    public String layout(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        //底部菜单配置
        model.addAttribute("bottomMenuConfig", MobileConfig.getConfig());
        return "mobile/common/main";
    }

    /**
     * 获得微信jssdk登录参数
     *
     * @return
     * @throws Exception
     */
    @GetMapping("/JSSDKConfig")
    @WechaNotEmptyLogin
    @ResponseBody
    public ResultState JSSDKConfig(String url) throws Exception {
        Map<String, String> map = JSSDKConfig.jsSDKSign(url);
        return resultSuccess(TextUtil.toJSONString(map));
    }

    /**
     * 获取文件ID
     *
     * @return
     * @throws Exception
     */
    @PostMapping("/getFileId")
    public ResultState upload() throws Exception {
        Map<String, Object> resultMap = Maps.newHashMapWithExpectedSize(2);
        resultMap.put(MagicValue.ID, getId());
        resultMap.put(MagicValue.STATUS, STATUS_SUCCESS);
        return resultState(resultMap);
    }

}
