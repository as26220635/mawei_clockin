package cn.kim.controller.mobile;

import cn.kim.common.attr.MagicValue;
import cn.kim.controller.manager.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * Created by 余庚鑫 on 2019/11/26
 * 我的
 */
@Controller
public class MMyController extends BaseController {

    @GetMapping("/my")
    public String my(Model model) {
        model.addAttribute(MagicValue.SESSION_WECHAT_USER, getWechatUser());
        return "mobile/my";
    }

    /**
     * 打卡列表
     *
     * @param model
     * @return
     */
    @GetMapping("/my/clockin/{ID}")
    public String clockinList(Model model) {
        setHeaderTitle(model, "打卡列表");
        return "mobile/my/clockin_list";
    }
}
