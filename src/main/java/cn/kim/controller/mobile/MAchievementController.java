package cn.kim.controller.mobile;

import cn.kim.controller.manager.BaseController;
import cn.kim.entity.WechatUser;
import cn.kim.service.AchievementService;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/11/27
 * 成就墙
 */
@Controller
public class MAchievementController extends BaseController {

    @Autowired
    private AchievementService achievementService;

    @GetMapping("/achievement")
    public String achievement(Model model) {
        WechatUser wechatUser = getWechatUser();
        List<Map<String, Object>> list = achievementService.selectMAchievementListByWechat(wechatUser.getId());

        int clockinCount = (int) list.stream().filter(m -> toInt(m.get("BAD_COUNT")) > 0).count();

        model.addAttribute("achievementList", list);
        model.addAttribute("clockinCount", clockinCount);
        return "mobile/achievement";
    }
}
