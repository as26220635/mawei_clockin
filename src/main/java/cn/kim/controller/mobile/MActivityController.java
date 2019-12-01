package cn.kim.controller.mobile;

import cn.kim.common.annotation.WechaNotEmptyLogin;
import cn.kim.controller.manager.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Created by 余庚鑫 on 2019/11/27
 * 成就墙
 */
@Controller
public class MActivityController extends BaseController {

    @GetMapping("/activity")
    @WechaNotEmptyLogin
    public String activity(Model model)throws Exception  {
        return "mobile/activity";
    }

    /**
     * 活动文章
     *
     * @param model
     * @return
     */
    @GetMapping("/activity/item/{ID}")
    @WechaNotEmptyLogin
    public String clockinList(Model model)throws Exception  {
        setHeaderTitle(model, "文章1");
        return "mobile/activity/item";
    }
}
