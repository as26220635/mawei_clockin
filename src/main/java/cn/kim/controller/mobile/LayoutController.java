package cn.kim.controller.mobile;

import cn.kim.common.annotation.WechaNotEmptyLogin;
import cn.kim.common.attr.MagicValue;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.ResultState;
import cn.kim.util.HttpUtil;
import cn.kim.util.SessionUtil;
import com.google.common.collect.Maps;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

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
        //判断是否登录
        if (isEmpty(SessionUtil.get(MagicValue.SESSION_WECHAT_USER))) {
            WebUtils.issueRedirect(request, response, "/oauth/render/wechat", null, true);
        }
        return "mobile/common/main";
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
