package cn.kim.controller.mobile;

import cn.kim.common.annotation.WechaNotEmptyLogin;
import cn.kim.controller.manager.BaseController;
import cn.kim.entity.DataTablesView;
import cn.kim.entity.WechatUser;
import cn.kim.service.ActivityService;
import cn.kim.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.Map;

/**
 * Created by 余庚鑫 on 2019/11/27
 * 成就墙
 */
@Controller
public class MActivityController extends BaseController {

    @Autowired
    private ActivityService activityService;

    @GetMapping("/activity")
    @WechaNotEmptyLogin
    public String activity(Model model) throws Exception {
        int count = activityService.selectActivityListCount();

        model.addAttribute("count", count);
        return "mobile/activity";
    }

    /**
     * 打卡列表记录
     *
     * @param model
     * @return
     */
    @GetMapping("/activity/{pageSize}/{page}")
    @WechaNotEmptyLogin
    public String clockinItemList(@PathVariable("pageSize") int pageSize, @PathVariable("page") int page, Model model) throws Exception {
        WechatUser wechatUser = getWechatUser();
        DataTablesView<?> dataTablesView = activityService.selectMActivityList(toInt(CommonUtil.getStrat(page, pageSize)), pageSize);

        model.addAttribute("detailList", dataTablesView.getData());
        return "mobile/activity/activity_data";
    }


    /**
     * 活动文章
     *
     * @param model
     * @return
     */
    @GetMapping("/activity/item/{ID}")
    @WechaNotEmptyLogin
    public String item(@PathVariable("ID") String ID, Model model) throws Exception {
        Map<String, Object> activity = activityService.selectActivityById(ID);

        model.addAttribute("activity", activity);
        setHeaderTitle(model, "活动");
        return "mobile/activity/activity_item";
    }
}
