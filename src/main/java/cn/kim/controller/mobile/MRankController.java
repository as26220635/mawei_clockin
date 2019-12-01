package cn.kim.controller.mobile;

import cn.kim.common.annotation.WechaNotEmptyLogin;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.WechatUser;
import cn.kim.service.WechatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/11/27
 * 成就墙
 */
@Controller
public class MRankController extends BaseController {

    @Autowired
    private WechatService wechatService;

    @GetMapping("/rank")
    @WechaNotEmptyLogin
    public String rank(Model model) {
        WechatUser wechatUser = getWechatUser();
        Map<String,Object> resultMap = wechatService.selectWechatRank(wechatUser.getId());

        model.addAttribute("rankList",resultMap.get("rankList"));
        model.addAttribute("myRank",resultMap.get("myRank"));
        return "mobile/rank";
    }
}
