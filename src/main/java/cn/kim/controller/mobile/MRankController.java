package cn.kim.controller.mobile;

import cn.kim.controller.manager.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Created by 余庚鑫 on 2019/11/27
 * 成就墙
 */
@Controller
public class MRankController extends BaseController {

    @GetMapping("/rank")
    public String rank(Model model) {
        return "mobile/rank";
    }
}
